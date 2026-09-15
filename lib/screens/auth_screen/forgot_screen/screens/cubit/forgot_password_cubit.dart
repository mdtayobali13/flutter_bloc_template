import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/services/repository/auth_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to manage forgot password request state
class ForgotPasswordCubit extends Cubit<bool> {
  ForgotPasswordCubit() : super(false);

  Future<bool> forgotPassword({required String email}) async {
    try {
      emit(true);
      bool response = await AuthRepository.instance.forgotPassword(email: email);
      emit(false);
      return response;
    } catch (e) {
      errorLog("ForgotPasswordCubit.forgotPassword", e);
      emit(false);
      return false;
    }
  }
}
