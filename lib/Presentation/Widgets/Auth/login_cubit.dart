import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy/Data/DataSource/Repository/Auth/login_repo.dart';
import 'package:dummy/Presentation/Widgets/Auth/login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository = LoginRepository();

  LoginCubit(repository) : super(LoginInitial());

  Future<void> handleGoogleSignIn() async {
    emit(LoginLoading());

    try {
      final user = await repository.signInWithGoogle();
      print(user);
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginError("Failed to sign in with Google"));
      }
    } catch (error) {
      emit(LoginError("An error occurred: $error"));
    }
  }
}
