import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_asserts_image_path.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/routes/app_routes.dart';
import 'package:flutter_bloc_template/routes/app_routes_key.dart';
import 'package:flutter_bloc_template/screens/auth_screen/sign_up_verify_screen/cubit/otp_verify_cubit.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/utils/app_snack_bar.dart';
import 'package:flutter_bloc_template/utils/gap.dart';
import 'package:flutter_bloc_template/widgets/app_image/app_image.dart';
import 'package:flutter_bloc_template/widgets/buttons/app_button.dart';
import 'package:flutter_bloc_template/widgets/inputs/app_input_widget_tow.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';

class SignUpVerifyScreen extends StatelessWidget {
  const SignUpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpVerifyCubit(),
      child: const _SignUpVerifyView(),
    );
  }
}

class _SignUpVerifyView extends StatefulWidget {
  const _SignUpVerifyView();

  @override
  State<_SignUpVerifyView> createState() => _SignUpVerifyViewState();
}

class _SignUpVerifyViewState extends State<_SignUpVerifyView> {
  late TextEditingController otpController;
  late GlobalKey<FormState> formKey;

  void onAppInitial() {
    try {
      otpController = TextEditingController();
      formKey = GlobalKey<FormState>();
    } catch (e) {
      errorLog("onAppInitial", e);
    }
  }

  void onAppClose() {
    otpController.dispose();
  }

  @override
  void initState() {
    super.initState();
    onAppInitial();
  }

  @override
  void dispose() {
    onAppClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  width: AppSize.size.width * 0.8,
                  height: AppSize.size.height * 0.14,
                  child: Center(
                    child: AppImage(width: AppSize.size.width * 0.8, path: AppAssertsImagePath.instance.logo),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AppText(
                      text: "Enter OTP Code",
                      fontSize: AppSize.width(value: 20),
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(height: AppSize.size.height * 0.01),
                    AppText(
                      text: "Check your email for the verification code",
                      fontSize: AppSize.width(value: 12),
                      color: AppColors.instance.dark400,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.size.width * 0.04, vertical: AppSize.size.height * 0.02),
                  child: AppInputWidgetTwo(
                    title: "OTP Code",
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Enter OTP code";
                      }
                      if (v.length < 4) {
                        return "Enter valid OTP";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const AppText(text: "If you didn't receive a code"),
                      Gap(width: AppSize.size.width * 0.021),
                      GestureDetector(
                        onTap: () {
                          context.read<OtpVerifyCubit>().resendOtp();
                        },
                        child: AppText(text: "Resend", fontSize: AppSize.size.width * 0.04, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.size.width * 0.04, vertical: AppSize.size.width * 0.04),
                  child: BlocBuilder<OtpVerifyCubit, bool>(
                    builder: (context, isLoading) {
                      return AppButton(
                        onTap: isLoading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  final isSuccess = await context.read<OtpVerifyCubit>().verifyOtp(otpController.text.trim());
                                  if (isSuccess) {
                                    AppSnackBar.instance.success("Verified successfully!");
                                    AppRoutes.instance.go(AppRoutesKey.instance.signInScreen);
                                  } else {
                                    AppSnackBar.instance.error("Invalid OTP");
                                  }
                                }
                              },
                        isLoading: isLoading,
                        title: "Verify",
                        height: AppSize.size.height * 0.06,
                        backgroundColor: AppColors.instance.success,
                        borderColor: AppColors.instance.success,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
