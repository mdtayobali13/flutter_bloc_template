import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_asserts_image_path.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/constant/app_constant.dart';
import 'package:flutter_bloc_template/screens/auth_screen/forgot_screen/screens/cubit/forgot_verify_email_cubit.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/utils/gap.dart';
import 'package:flutter_bloc_template/widgets/app_image/app_image.dart';
import 'package:flutter_bloc_template/widgets/buttons/app_button.dart';
import 'package:flutter_bloc_template/widgets/inputs/app_input_widget_tow.dart';
import 'package:flutter_bloc_template/widgets/inputs/formatter/otp_number_formatter.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';

class ForgotScreenOtpInputScreen extends StatelessWidget {
  const ForgotScreenOtpInputScreen({
    super.key,
    required this.onChange,
    required this.formKey,
    required this.otpTextEditingController,
  });

  final void Function(int index) onChange;
  final GlobalKey<FormState> formKey;
  final TextEditingController otpTextEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotVerifyEmailCubit(),
      child: _ForgotOtpView(
        onChange: onChange,
        formKey: formKey,
        otpTextEditingController: otpTextEditingController,
      ),
    );
  }
}

class _ForgotOtpView extends StatelessWidget {
  const _ForgotOtpView({
    required this.onChange,
    required this.formKey,
    required this.otpTextEditingController,
  });

  final void Function(int index) onChange;
  final GlobalKey<FormState> formKey;
  final TextEditingController otpTextEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.size.width,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: AppSize.size.width * 0.8,
                height: AppSize.size.height * 0.14,
                child: Center(
                  child: AppImage(width: AppSize.size.width * 0.8, path: AppAssertsImagePath.instance.logo),
                ),
              ),
              SizedBox(
                width: AppSize.size.width * 0.8,
                child: AppText(
                  text: "Enter Verification Code",
                  textAlign: TextAlign.center,
                  fontFamily: AppConstant.instance.fontFamilyPoppins,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: AppSize.width(value: 18),
                ),
              ),
              AppInputWidgetTwo(
                title: "Code ",
                keyboardType: const TextInputType.numberWithOptions(),
                controller: otpTextEditingController,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.center,
                inputFormatters: [OtpNumberFormatter()],
              ),
              Gap(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const AppText(text: "If you didn't receive a code,"),
                  Padding(
                    padding: EdgeInsets.only(right: AppSize.width(value: 20)),
                    child: InkWell(
                      onTap: () {
                        context.read<ForgotVerifyEmailCubit>().resendOtp();
                      },
                      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                      child: const AppText(text: " Resend", fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Gap(height: 25),
              BlocBuilder<ForgotVerifyEmailCubit, bool>(
                builder: (context, isLoading) {
                  return AppButton(
                    onTap: () {
                      context.read<ForgotVerifyEmailCubit>().verifyEmail(
                            formKey: formKey,
                            otpController: otpTextEditingController,
                            onChange: onChange,
                          );
                    },
                    isLoading: isLoading,
                    backgroundColor: AppColors.instance.success,
                    borderColor: AppColors.instance.success,
                    title: "Verify",
                    margin: EdgeInsetsDirectional.symmetric(horizontal: AppSize.width(value: 20)),
                    padding: EdgeInsets.all(AppSize.width(value: 8)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
