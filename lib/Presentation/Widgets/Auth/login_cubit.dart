import 'package:dummy/Data/DataSource/Repository/Auth/login_repo.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginAuthState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.signInWithGoogle();

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError("Sign-in with Google failed"));
      }
    } catch (error) {
      emit(AuthError("An error occurred: $error"));
    }
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await _authRepository.signInWithPhoneNumber(
        phoneNumber,
        onVerificationCompleted: (credential) {
          emit(AuthVerificationCompleted(credential));
        },
        onCodeSent: (verificationId, resendToken) {
          emit(AuthCodeSent(verificationId, resendToken));
          print("code sent");
        },
      );
      User? user = FirebaseAuth.instance.currentUser;
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
