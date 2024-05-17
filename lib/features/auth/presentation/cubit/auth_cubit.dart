import 'dart:convert';

import 'package:bengkel_pak_bowo/features/auth/data/models/account.dart';
import 'package:bengkel_pak_bowo/features/auth/data/models/login_credentials.dart';
import 'package:bengkel_pak_bowo/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:bengkel_pak_bowo/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants_finals.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isObsecure = false;

  Map<String, dynamic> credentials = {};

  // Getter
  bool get getIsObsecure => isObsecure;
  int get getRole => credentials['role'];

  void obsecurePassword() {
    isObsecure = !isObsecure;
    emit(ObsecurePassword());
  }

  Future<void> authLogin(final LoginCredentials data) async {
    emit(LoginAuthenticating());
    final result =
        await locator<AuthRepositoriesImpl>().authLogin(loginToJson(data));

    result.fold(
      (failure) {
        emit(LoginError(failure.message));
      },
      (success) async {
        final Map<String, dynamic> responseDecoded = jsonDecode(success);

        if (responseDecoded['statusCode'] == 200) {
          final prefs = locator<SharedPreferences>();
          await prefs.setString('token', responseDecoded['token']);
          emit(LoginAuthenticated(responseDecoded['message']));
        } else {
          emit(LoginError(responseDecoded['message']));
        }
      },
    );
  }

  Future<void> authRegister(final AccountModel account) async {
    emit(RegisterAuthenticating());

    final result = await locator<AuthRepositoriesImpl>()
        .authRegister(accountToJson(account));

    result.fold(
      (failure) {
        emit(RegisterError(failure.message));
      },
      (success) {
        final Map<String, dynamic> responseDecoded = jsonDecode(success);

        if (responseDecoded['statusCode'] == 201) {
          emit(RegisterAuthenticated(responseDecoded['message']));
        } else {
          emit(RegisterError(responseDecoded['message']));
        }
      },
    );
  }

  void authLogout(BuildContext context) {
    locator<SharedPreferences>().remove('token');
    Navigator.pushReplacementNamed(context, loginPage);
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
