import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to manage sign-in state (loading / idle) and authentication execution
class SignInCubit extends Cubit<bool> {
  SignInCubit() : super(false);

  Future<bool> signIn(String email, String password) async {
    try {
      emit(true);
      // Example repository call:
      // final response = await AuthRepository.instance.login(email: email, password: password);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(false);
      return true;
    } catch (e) {
      errorLog("SignInCubit.signIn", e);
      emit(false);
      return false;
    }
  }
}
