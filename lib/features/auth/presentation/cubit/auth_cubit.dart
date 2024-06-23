import 'dart:convert';

import '../../domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants_finals.dart';
import '../../../../injection_container.dart';
import '../../data/models/login.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/auth_login.dart';
import '../../domain/usecases/auth_register.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authLoginUseCase,
    required this.authRegisterUseCase,
  }) : super(AuthInitial());

  final AuthLoginUseCase authLoginUseCase;
  final AuthRegisterUseCase authRegisterUseCase;

  bool isObsecure = false;
  Map<String, dynamic> credentials = {};

  // Getter
  bool get getIsObsecure => isObsecure;
  int get getRole => credentials['role'];
  String get getName => credentials['name'];
  String get getUsername => credentials['username'];
  LoginModel loginData(final String username, final String password) =>
      LoginModel(username: username, password: password);
  UserModel accountData(
          final String name, final String username, final String password) =>
      UserModel(name: name, username: username, password: password);

  void obsecurePassword() {
    isObsecure = !isObsecure;
    emit(ObsecurePassword());
  }

  Future<void> authLogin(final User data) async {
    emit(LoginAuthenticating());

    final result = await authLoginUseCase(data);

    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (success) async {
        final Map<String, dynamic> responseDecoded = jsonDecode(success);

        if (responseDecoded['statusCode'] == 200) {
          final prefs = locator<SharedPreferences>();
          await prefs.setString('token', responseDecoded['token']);
          headers['Authorization'] = responseDecoded['token'];
          emit(LoginAuthenticated(responseDecoded['message']));
        } else {
          emit(LoginError(responseDecoded['message']));
        }
      },
    );
  }

  Future<void> authRegister(final User data) async {
    emit(RegisterAuthenticating());

    final result = await authRegisterUseCase(data);

    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (success) {
        final Map<String, dynamic> responseDecoded = jsonDecode(success);

        switch (responseDecoded['statusCode']) {
          case 201:
            emit(RegisterAuthenticated(responseDecoded['message']));
            break;
          case 400:
            emit(
                RegisterError((responseDecoded['message'] as List).join('\n')));
            break;
          case 409:
            emit(RegisterError(responseDecoded['message']));
            break;
          default:
        }
      },
    );
  }

  void authLogout(BuildContext context) {
    locator<SharedPreferences>().remove('token');
    Navigator.pushNamedAndRemoveUntil(context, loginPage, (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Berhasil Logout',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary));
  }

  String? validate(String? value) {
    if (value?.trim() == "") {
      return "Form Harus Diisi";
    }
    return null;
  }
}
