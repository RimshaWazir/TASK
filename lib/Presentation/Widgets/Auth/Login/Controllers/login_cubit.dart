import '../../../../../Data/DataSource/Resources/imports.dart';

class LoginCubit extends Cubit<LoginAuthState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(AuthInitial());

  Future<void> signInWithGoogle(BuildContext context) async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.signInWithGoogle(context);

      if (user != null) {
        emit(AuthSuccess(user));
        Navigate.toReplace(context, const BottomNavigationScreen());
      } else {
        emit(AuthError("Sign-in with Google failed"));
      }
    } catch (error) {
      emit(AuthError("An error occurred: $error"));
    }
  }
}
