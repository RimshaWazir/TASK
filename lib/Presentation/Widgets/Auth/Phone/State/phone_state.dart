import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthSuccess extends PhoneAuthState {
  final User user;

  PhoneAuthSuccess(this.user);
}

class PhoneAuthError extends PhoneAuthState {
  final String errorMessage;

  PhoneAuthError(this.errorMessage);
}

class PhoneAuthCodeSent extends PhoneAuthState {
  final String verificationId;
  final int resendToken;

  PhoneAuthCodeSent(this.verificationId, this.resendToken);
}

class PhoneAuthVerificationCompleted extends PhoneAuthState {
  final AuthCredential credential;

  PhoneAuthVerificationCompleted(this.credential);
}
