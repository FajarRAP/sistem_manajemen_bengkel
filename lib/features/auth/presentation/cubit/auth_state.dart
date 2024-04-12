part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class ObsecurePassword extends AuthState {}

class LoginAuthenticating extends AuthState {}

class LoginAuthenticated extends AuthState {
  final String message;

  LoginAuthenticated(this.message);
}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

class RegisterAuthenticating extends AuthState {}

class RegisterAuthenticated extends AuthState {
  final String message;

  RegisterAuthenticated(this.message);
}

class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}
