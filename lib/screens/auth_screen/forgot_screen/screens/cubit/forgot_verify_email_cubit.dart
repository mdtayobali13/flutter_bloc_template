import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/services/repository/auth_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_snack_bar.dart';

/// Cubit to verify email OTP in forgot password flow
class ForgotVerifyEmailCubit extends Cubit<bool> {
  ForgotVerifyEmailCubit() : super(false);

  Future<void> verifyEmail({
    required GlobalKey<FormState> formKey,
    required TextEditingController otpController,
    required void Function(int index) onChange,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        emit(true);
        String email = "";
        String otp = otpController.text.trim().replaceAll(RegExp(r'\D'), '');

        String token = await AuthRepository.instance.forgotVerifyEmail(
          email: email,
          otp: int.tryParse(otp) ?? 0,
        );

        emit(false);

        if (token.isNotEmpty) {
          AppSnackBar.instance.success("OTP Verification successful");
          onChange(2);
        } else {
          AppSnackBar.instance.error("Verification failed or OTP is incorrect.");
        }
      }
    } catch (e) {
      errorLog("verifyEmail ForgotVerifyEmailCubit", e);
      emit(false);
    }
  }

  Future<void> resendOtp() async {
    try {
      emit(true);
      String email = "";
      bool success = await AuthRepository.instance.forgotPassword(email: email);
      emit(false);
      if (success) {
        AppSnackBar.instance.success("OTP has been resent successfully");
      } else {
        AppSnackBar.instance.error("Failed to resend OTP. Please try again.");
      }
    } catch (e) {
      errorLog("resendOtp ForgotVerifyEmailCubit", e);
      emit(false);
    }
  }
}
