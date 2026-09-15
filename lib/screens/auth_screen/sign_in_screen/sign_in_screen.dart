import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_asserts_image_path.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/routes/app_routes.dart';
import 'package:flutter_bloc_template/routes/app_routes_key.dart';
import 'package:flutter_bloc_template/screens/auth_screen/sign_in_screen/cubit/sign_in_cubit.dart';
import 'package:flutter_bloc_template/services/storage/storage_services.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/utils/app_snack_bar.dart';
import 'package:flutter_bloc_template/utils/gap.dart';
import 'package:flutter_bloc_template/widgets/app_image/app_image.dart';
import 'package:flutter_bloc_template/widgets/buttons/app_button.dart';
import 'package:flutter_bloc_template/widgets/inputs/app_input_widget_tow.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: const _SignInView(),
    );
  }
}

class _SignInView extends StatefulWidget {
  const _SignInView();

  @override
  State<_SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<_SignInView> {
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late GlobalKey<FormState> formKey;

  Future<void> checkLoginFunction() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      final response = await context.read<SignInCubit>().signIn(
            emailTextEditingController.text.trim(),
            passwordTextEditingController.text.trim(),
          );
      if (response) {
        AppRoutes.instance.go(AppRoutesKey.instance.homeScreen);
      } else {
        AppSnackBar.instance.error("Invalid email and password");
      }
    } catch (e) {
      errorLog("checkLoginFunction", e);
    }
  }

  Future<void> continueAsGuest() async {
    try {
      await StorageServices.instance.setAppRoll("GUEST");
      AppRoutes.instance.pushNamed(AppRoutesKey.instance.homeScreen);
    } catch (e) {
      errorLog("continueAsGuest", e);
    }
  }

  void onInitialApp() {
    try {
      emailTextEditingController = TextEditingController();
      passwordTextEditingController = TextEditingController();
      formKey = GlobalKey<FormState>();
    } catch (e) {
      errorLog("onInitialApp", e);
    }
  }

  @override
  void initState() {
    super.initState();
    onInitialApp();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: AppSize.size.width,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSize.size.width * 0.8,
                    height: AppSize.size.height * 0.14,
                    child: Center(
                      child: AppImage(width: AppSize.size.width * 0.8, path: AppAssertsImagePath.instance.logo),
                    ),
                  ),
                  Gap(height: 20),
                  AppText(
                    text: "Welcome Back",
                    fontSize: AppSize.width(value: 26),
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(height: 10),
                  AppText(
                    text: "Sign in to continue",
                    fontSize: AppSize.width(value: 14),
                    color: AppColors.instance.dark400,
                  ),
                  Gap(height: 30),
                  AppInputWidgetTwo(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email";
                      }
                      return null;
                    },
                    title: "Email",
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  Gap(height: 15),
                  AppInputWidgetTwo(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your password";
                      }
                      if (value.length < 6) {
                        return "At least 6 characters";
                      }
                      return null;
                    },
                    title: "Password",
                    isPassWord: true,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: passwordTextEditingController,
                    textInputAction: TextInputAction.done,
                  ),
                  Gap(height: 30),
                  BlocBuilder<SignInCubit, bool>(
                    builder: (context, isLoading) {
                      return AppButton(
                        isLoading: isLoading,
                        onTap: checkLoginFunction,
                        title: "Login",
                        backgroundColor: AppColors.instance.success,
                        borderColor: AppColors.instance.success,
                        padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 10)),
                        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
                      );
                    },
                  ),
                  Gap(height: 30),
                  AppButton(
                    onTap: continueAsGuest,
                    title: "Browse as Guest",
                    backgroundColor: AppColors.instance.white50,
                    borderColor: AppColors.instance.dark500,
                    titleColor: AppColors.instance.dark500,
                    padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 10)),
                    margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
                  ),
                  Gap(height: 30),
                  InkWell(
                    onTap: () {
                      AppRoutes.instance.pushNamed(AppRoutesKey.instance.signUpScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: "Don't have an account? ",
                          fontSize: AppSize.width(value: 14),
                          color: AppColors.instance.dark400,
                        ),
                        AppText(
                          text: "Sign Up",
                          fontSize: AppSize.width(value: 14),
                          fontWeight: FontWeight.w600,
                          color: AppColors.instance.success,
                        ),
                      ],
                    ),
                  ),
                  Gap(height: 15),
                  InkWell(
                    onTap: () {
                      AppRoutes.instance.pushNamed(AppRoutesKey.instance.forgotScreen);
                    },
                    child: AppText(
                      text: "Forgot Password?",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.success,
                    ),
                  ),
                  Gap(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
