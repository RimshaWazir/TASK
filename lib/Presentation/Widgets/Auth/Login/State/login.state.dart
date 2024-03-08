import '../../../../../Data/DataSource/Resources/imports.dart';

abstract class LoginAuthState {}

class AuthInitial extends LoginAuthState {}

class AuthLoading extends LoginAuthState {}

class AuthSuccess extends LoginAuthState {
  final User user;

  AuthSuccess(this.user);
}

class AuthError extends LoginAuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}

class AuthCodeSent extends LoginAuthState {
  final String verificationId;
  final int resendToken;

  AuthCodeSent(this.verificationId, this.resendToken);
}

class AuthVerificationCompleted extends LoginAuthState {
  final AuthCredential credential;

  AuthVerificationCompleted(this.credential);
}
