import 'dart:developer';

import '../../../../../Data/DataSource/Resources/imports.dart';

class PhoneCubit extends Cubit<PhoneAuthState> {
  final AuthRepository _authRepository;

  PhoneCubit(this._authRepository) : super(PhoneAuthInitial());

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await _authRepository.signInWithPhoneNumber(
        phoneNumber,
        onVerificationCompleted: (credential) {
          emit(PhoneAuthVerificationCompleted(credential));
        },
        onCodeSent: (verificationId, resendToken) {
          emit(PhoneAuthCodeSent(verificationId, resendToken));
          log("code sent");
        },
      );
      User? user = FirebaseAuth.instance.currentUser;
      emit(PhoneAuthSuccess(user!));
    } catch (e) {
      emit(PhoneAuthError(e.toString()));
    }
  }
}
