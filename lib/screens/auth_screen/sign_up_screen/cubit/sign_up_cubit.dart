import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/screens/auth_screen/sign_up_screen/cubit/sign_up_state.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to manage user registration form data, validation, and submission
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void stateUpdate({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? idCardFrontendPart,
    String? idCardBackendPart,
    String? storeName,
    String? storeBio,
    String? storeAddress,
    String? storePhoto,
    String? kycDocument,
    bool? isLoading,
    bool? isCustomer,
  }) {
    try {
      emit(state.copyWith(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        idCardFrontendPart: idCardFrontendPart,
        idCardBackendPart: idCardBackendPart,
        storeName: storeName,
        storeBio: storeBio,
        storeAddress: storeAddress,
        storePhoto: storePhoto,
        kycDocument: kycDocument,
        isLoading: isLoading,
        isCustomer: isCustomer,
      ));
    } catch (e) {
      errorLog("SignUpCubit.stateUpdate", e);
    }
  }

  void clearAll() {
    emit(SignUpState(isCustomer: state.isCustomer));
  }

  Future<void> customerSignUp({required GlobalKey<FormState> formKey}) async {
    try {
      if (!formKey.currentState!.validate()) return;

      if (state.isCustomer) {
        stateUpdate(isLoading: true);
        // Example repository integration:
        // bool success = await AuthRepository.instance.customerSignUp(...);
        await Future.delayed(const Duration(milliseconds: 500));
        stateUpdate(isLoading: false);
      } else {
        // AppRoutes.instance.pushNamed(AppRoutesKey.instance.kycVerificationScreen);
      }
    } catch (e) {
      errorLog("customerSignUp Cubit", e);
      stateUpdate(isLoading: false);
    }
  }

  Future<void> vendorSignup() async {
    // Optional vendor sign up implementation
  }
}
