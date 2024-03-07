import 'package:dummy/Data/DataSource/Repository/Auth/auth_repo.dart';

import 'package:dummy/Presentation/Widgets/Auth/Login/State/login.state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginAuthState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(AuthInitial());

  Future<void> signInWithGoogle(BuildContext context) async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.signInWithGoogle(context);

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError("Sign-in with Google failed"));
      }
    } catch (error) {
      emit(AuthError("An error occurred: $error"));
    }
  }
}
