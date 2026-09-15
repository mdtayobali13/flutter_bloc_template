import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_asserts_image_path.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/routes/app_routes.dart';
import 'package:flutter_bloc_template/screens/auth_screen/forgot_screen/screens/cubit/forgot_password_cubit.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/utils/gap.dart';
import 'package:flutter_bloc_template/widgets/app_image/app_image.dart';
import 'package:flutter_bloc_template/widgets/buttons/app_button.dart';
import 'package:flutter_bloc_template/widgets/inputs/app_input_widget_tow.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';

class ForgotScreenEmailInputScreen extends StatelessWidget {
  const ForgotScreenEmailInputScreen({
    super.key,
    required this.emailTextEditingController,
    required this.onChange,
    required this.formKey,
  });

  final void Function(int index) onChange;
  final TextEditingController emailTextEditingController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: _ForgotEmailView(
        emailTextEditingController: emailTextEditingController,
        onChange: onChange,
        formKey: formKey,
      ),
    );
  }
}

class _ForgotEmailView extends StatelessWidget {
  const _ForgotEmailView({
    required this.emailTextEditingController,
    required this.onChange,
    required this.formKey,
  });

  final void Function(int index) onChange;
  final TextEditingController emailTextEditingController;
  final GlobalKey<FormState> formKey;

  Future<void> checkCallSend(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        final email = emailTextEditingController.text.trim();
        final success = await context.read<ForgotPasswordCubit>().forgotPassword(email: email);
        if (success) {
          onChange(1);
        }
      }
    } catch (e) {
      errorLog("checkCallSend", e);
    }
  }

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
                  text: "Enter Email Address",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: AppSize.width(value: 18),
                ),
              ),
              AppInputWidgetTwo(
                title: "Email",
                isEmail: true,
                keyboardType: TextInputType.emailAddress,
                controller: emailTextEditingController,
                textInputAction: TextInputAction.next,
              ),
              Gap(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: AppSize.width(value: 20)),
                  child: InkWell(
                    onTap: () {
                      AppRoutes.instance.pop();
                    },
                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                    child: const AppText(text: "Back to sign in"),
                  ),
                ),
              ),
              Gap(height: 25),
              BlocBuilder<ForgotPasswordCubit, bool>(
                builder: (context, isLoading) {
                  return AppButton(
                    onTap: () => checkCallSend(context),
                    isLoading: isLoading,
                    backgroundColor: AppColors.instance.success,
                    borderColor: AppColors.instance.success,
                    title: "Send",
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
