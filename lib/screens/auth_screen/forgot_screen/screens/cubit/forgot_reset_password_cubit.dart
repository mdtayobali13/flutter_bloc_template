import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/routes/app_routes.dart';
import 'package:flutter_bloc_template/routes/app_routes_key.dart';
import 'package:flutter_bloc_template/services/repository/auth_repository.dart';
import 'package:flutter_bloc_template/services/storage/storage_services.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_snack_bar.dart';

/// Cubit to reset password with token in forgot password flow
class ForgotResetPasswordCubit extends Cubit<bool> {
  ForgotResetPasswordCubit() : super(false);

  Future<void> resetPassword({
    required GlobalKey<FormState> formKey,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        String password = passwordController.text.trim();
        String confirmPassword = confirmPasswordController.text.trim();

        if (password != confirmPassword) {
          AppSnackBar.instance.error("Password & Confirm Password do not match");
          return;
        }

        emit(true);

        String token = await StorageServices.instance.getToken();

        bool success = await AuthRepository.instance.forgotResetPassword(
          token: token,
          newPassword: password,
          confirmPassword: "",
        );

        emit(false);

        if (success) {
          AppSnackBar.instance.success("Password update successful, Login with your credential");
          AppRoutes.instance.go(AppRoutesKey.instance.signInScreen);
        } else {
          AppSnackBar.instance.error("Failed to reset password. Try again.");
        }
      }
    } catch (e) {
      errorLog("resetPassword ForgotResetPasswordCubit", e);
      emit(false);
    }
  }
}
