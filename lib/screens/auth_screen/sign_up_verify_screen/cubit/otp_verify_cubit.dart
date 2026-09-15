import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/services/repository/auth_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_snack_bar.dart';

/// Cubit to manage OTP verification state and API execution
class OtpVerifyCubit extends Cubit<bool> {
  OtpVerifyCubit() : super(false);

  Future<bool> verifyOtp(String code) async {
    try {
      emit(true);
      String email = "";
      final response = await AuthRepository.instance.authOtpVerify(
        email: email,
        otp: int.tryParse(code) ?? 0,
      );
      emit(false);
      return response;
    } catch (e) {
      errorLog("verifyOtp OtpVerifyCubit", e);
      emit(false);
      return false;
    }
  }

  Future<void> resendOtp() async {
    try {
      emit(true);
      String email = "";
      bool success = await AuthRepository.instance.authResendOTP(email: email);
      emit(false);
      if (success) {
        AppSnackBar.instance.success("OTP has been resent successfully");
      } else {
        AppSnackBar.instance.error("Failed to resend OTP. Please try again.");
      }
    } catch (e) {
      errorLog("resendOtp OtpVerifyCubit", e);
      emit(false);
    }
  }
}
