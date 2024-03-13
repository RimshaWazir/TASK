import 'package:dummy/Data/DataSource/Resources/imports.dart';

import '../State/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _userRepository;

  SignUpCubit(this._userRepository) : super(SignUpInitial());

  Future<void> signUp(String email, String password, ChatUser user) async {
    try {
      emit(SignUpLoading());
      await _userRepository.signUpUser(user: user, password: password);
      emit(SignUpLoaded());
    } catch (e) {
      emit(SignUpError(error: e.toString()));
    }
  }
}
