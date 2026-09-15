import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/constant/app_asserts_image_path.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/routes/app_routes.dart';
import 'package:flutter_bloc_template/routes/app_routes_key.dart';
import 'package:flutter_bloc_template/screens/auth_screen/sign_up_screen/cubit/sign_up_cubit.dart';
import 'package:flutter_bloc_template/screens/auth_screen/sign_up_screen/cubit/sign_up_state.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/utils/gap.dart';
import 'package:flutter_bloc_template/widgets/app_image/app_image.dart';
import 'package:flutter_bloc_template/widgets/buttons/app_button.dart';
import 'package:flutter_bloc_template/widgets/image_userPick/image_user_pick.dart';
import 'package:flutter_bloc_template/widgets/inputs/app_input_widget.dart';
import 'package:flutter_bloc_template/widgets/inputs/app_input_widget_tow.dart';
import 'package:flutter_bloc_template/widgets/texts/app_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController phoneNumberTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController confirmPasswordTextEditingController;
  late TextEditingController storeNameTextEditingController;
  late TextEditingController storeBioTextEditingController;
  late TextEditingController storeAddressTextEditingController;
  late TextEditingController storeImageController;
  late TextEditingController fontImageController;
  late TextEditingController backImageController;

  void onAppInitial() {
    try {
      nameTextEditingController = TextEditingController();
      emailTextEditingController = TextEditingController();
      phoneNumberTextEditingController = TextEditingController();
      passwordTextEditingController = TextEditingController();
      confirmPasswordTextEditingController = TextEditingController();
      storeNameTextEditingController = TextEditingController();
      storeBioTextEditingController = TextEditingController();
      storeAddressTextEditingController = TextEditingController();
      fontImageController = TextEditingController();
      backImageController = TextEditingController();
      storeImageController = TextEditingController();
      formKey = GlobalKey<FormState>();
    } catch (e) {
      errorLog("onAppInitial", e);
    }
  }

  void onAppClose() {
    try {
      nameTextEditingController.dispose();
      emailTextEditingController.dispose();
      phoneNumberTextEditingController.dispose();
      passwordTextEditingController.dispose();
      confirmPasswordTextEditingController.dispose();
      fontImageController.dispose();
      backImageController.dispose();
      storeAddressTextEditingController.dispose();
      storeBioTextEditingController.dispose();
      storeNameTextEditingController.dispose();
      storeImageController.dispose();
    } catch (e) {
      errorLog("onAppClose", e);
    }
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSize.size.width * 0.05),
          child: SizedBox(
            width: AppSize.size.width,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(height: 30),
                  SizedBox(
                    width: AppSize.size.width * 0.8,
                    height: AppSize.size.height * 0.1,
                    child: Center(
                      child: AppImage(
                        width: AppSize.size.width * 0.6,
                        path: AppAssertsImagePath.instance.logo,
                      ),
                    ),
                  ),
                  Gap(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      text: "Sign Up",
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      fontSize: AppSize.width(value: 18),
                    ),
                  ),
                  Gap(height: 20),
                  BlocSelector<SignUpCubit, SignUpState, bool>(
                    selector: (state) => state.isCustomer,
                    builder: (context, isCustomer) {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.read<SignUpCubit>().stateUpdate(isCustomer: true);
                              },
                              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                              child: AnimatedContainer(
                                duration: Durations.long1,
                                padding: EdgeInsets.all(AppSize.width(value: 10)),
                                decoration: BoxDecoration(
                                  color: isCustomer ? AppColors.instance.success : AppColors.instance.white100,
                                  border: Border.all(color: isCustomer ? AppColors.instance.success : AppColors.instance.dark300),
                                  borderRadius: BorderRadius.circular(AppSize.width(value: 10)),
                                ),
                                alignment: Alignment.center,
                                child: AppText(
                                  text: "Customer",
                                  color: isCustomer ? AppColors.instance.white50 : AppColors.instance.dark500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Gap(width: 20),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.read<SignUpCubit>().stateUpdate(isCustomer: false);
                              },
                              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                              child: AnimatedContainer(
                                duration: Durations.long1,
                                padding: EdgeInsets.all(AppSize.width(value: 10)),
                                decoration: BoxDecoration(
                                  color: !isCustomer ? AppColors.instance.success : AppColors.instance.white100,
                                  border: Border.all(color: !isCustomer ? AppColors.instance.success : AppColors.instance.dark300),
                                  borderRadius: BorderRadius.circular(AppSize.width(value: 10)),
                                ),
                                alignment: Alignment.center,
                                child: AppText(
                                  text: "Vendor",
                                  color: !isCustomer ? AppColors.instance.white50 : AppColors.instance.dark500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Gap(height: 10),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your name";
                      }
                      return null;
                    },
                    title: "Name",
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    controller: nameTextEditingController,
                    onChanged: (v) {
                      context.read<SignUpCubit>().stateUpdate(name: v);
                    },
                    hintText: "Enter your name",
                  ),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your email";
                      }
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    title: "Email",
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    isEmail: true,
                    controller: emailTextEditingController,
                    onChanged: (v) {
                      context.read<SignUpCubit>().stateUpdate(email: v);
                    },
                    hintText: "Enter your email",
                  ),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your phone number";
                      }
                      return null;
                    },
                    title: "Phone Number",
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    controller: phoneNumberTextEditingController,
                    onChanged: (v) {
                      context.read<SignUpCubit>().stateUpdate(phoneNumber: v);
                    },
                    hintText: "Enter your phone number",
                  ),
                  BlocSelector<SignUpCubit, SignUpState, bool>(
                    selector: (state) => state.isCustomer,
                    builder: (context, isCustomer) {
                      if (!isCustomer) {
                        return Column(
                          children: [
                            AppInputWidgetTwo(
                              controller: storeNameTextEditingController,
                              title: "Store Name",
                              onChanged: (v) {
                                context.read<SignUpCubit>().stateUpdate(storeName: v);
                              },
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return " enter your store name";
                                }
                                return null;
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              hintText: "Enter store name",
                            ),
                            AppInputWidgetTwo(
                              controller: storeBioTextEditingController,
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return " enter your store Bio";
                                }
                                return null;
                              },
                              title: "Store Bio",
                              onChanged: (v) {
                                context.read<SignUpCubit>().stateUpdate(storeBio: v);
                              },
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              hintText: "Enter store bio",
                            ),
                            AppInputWidgetTwo(
                              controller: storeAddressTextEditingController,
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return " enter your store address";
                                }
                                return null;
                              },
                              onChanged: (v) {
                                context.read<SignUpCubit>().stateUpdate(storeAddress: v);
                              },
                              title: "Store Address",
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              hintText: "Enter store address",
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppInputWidgetTwo(
                          maxLines: 1,
                          controller: fontImageController,
                          readOnly: true,
                          onTap: () {
                            appImageUserTake(
                              callBack: (v) {
                                context.read<SignUpCubit>().stateUpdate(idCardFrontendPart: v);
                                fontImageController.text = v;
                              },
                            );
                          },
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter your image";
                            }
                            return null;
                          },
                          title: "Resident Card",
                          hintText: "Upload front side photo",
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                        ),
                      ),
                      Gap(width: AppSize.size.width * 0.02),
                      Expanded(
                        flex: 1,
                        child: AppButton(
                          onTap: () {
                            appImageUserTake(
                              callBack: (v) {
                                context.read<SignUpCubit>().stateUpdate(idCardFrontendPart: v);
                                fontImageController.text = v;
                              },
                            );
                          },
                          height: AppSize.size.width * 0.13,
                          backgroundColor: AppColors.instance.success,
                          borderColor: AppColors.instance.success,
                          title: "Upload",
                        ),
                      ),
                    ],
                  ),
                  Gap(height: AppSize.size.width * 0.015),
                  BlocSelector<SignUpCubit, SignUpState, String>(
                    selector: (state) => state.idCardBackendPart,
                    builder: (context, backImage) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppInputWidget(
                              maxLines: 1,
                              controller: backImageController,
                              readOnly: true,
                              onTap: () {
                                appImageUserTake(
                                  callBack: (v) {
                                    context.read<SignUpCubit>().stateUpdate(idCardBackendPart: v);
                                  },
                                );
                              },
                              validator: (String? value) {
                                if (backImage.isEmpty) {
                                  return "Enter your image";
                                }
                                return null;
                              },
                              borderColor: AppColors.instance.success,
                              hintText: backImage.isEmpty ? "Upload back side photo" : backImage.split("/").last,
                            ),
                          ),
                          Gap(width: AppSize.size.width * 0.02),
                          Expanded(
                            flex: 1,
                            child: AppButton(
                              onTap: () {
                                appImageUserTake(
                                  callBack: (v) {
                                    context.read<SignUpCubit>().stateUpdate(idCardBackendPart: v);
                                  },
                                );
                              },
                              height: AppSize.size.width * 0.13,
                              backgroundColor: AppColors.instance.success,
                              borderColor: AppColors.instance.success,
                              title: "Upload",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        previous.isCustomer != current.isCustomer || previous.storePhoto != current.storePhoto,
                    builder: (context, state) {
                      if (!state.isCustomer) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 2,
                              child: AppInputWidgetTwo(
                                maxLines: 1,
                                controller: storeImageController,
                                readOnly: true,
                                onTap: () {
                                  appImageUserTake(
                                    callBack: (v) {
                                      context.read<SignUpCubit>().stateUpdate(storePhoto: v);
                                    },
                                  );
                                },
                                validator: (String? value) {
                                  if (state.storePhoto.isEmpty) {
                                    return "Enter your image";
                                  }
                                  return null;
                                },
                                title: "Store Photo",
                                hintText: state.storePhoto.isEmpty ? "Upload store photo" : state.storePhoto.split("/").last,
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                              ),
                            ),
                            Gap(width: AppSize.size.width * 0.02),
                            Expanded(
                              flex: 1,
                              child: AppButton(
                                onTap: () {
                                  appImageUserTake(
                                    callBack: (v) {
                                      context.read<SignUpCubit>().stateUpdate(storePhoto: v);
                                    },
                                  );
                                },
                                height: AppSize.size.width * 0.13,
                                backgroundColor: AppColors.instance.success,
                                borderColor: AppColors.instance.success,
                                title: "Upload",
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your password";
                      }
                      if (value!.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    title: "Password",
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    isPassWord: true,
                    controller: passwordTextEditingController,
                    onChanged: (v) {
                      context.read<SignUpCubit>().stateUpdate(password: v);
                    },
                    hintText: "Enter your password",
                  ),
                  AppInputWidgetTwo(
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your password";
                      }
                      if (value!.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      if (value != passwordTextEditingController.text) {
                        return "Password not matching";
                      }
                      return null;
                    },
                    title: "Confirm Password",
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    isPassWord: true,
                    controller: confirmPasswordTextEditingController,
                    hintText: "Enter Confirm Password",
                  ),
                  Gap(height: 20),
                  BlocSelector<SignUpCubit, SignUpState, bool>(
                    selector: (state) => state.isLoading,
                    builder: (context, isLoading) {
                      return AppButton(
                        onTap: () async {
                          await context.read<SignUpCubit>().customerSignUp(formKey: formKey);
                        },
                        isLoading: isLoading,
                        backgroundColor: AppColors.instance.success,
                        borderColor: AppColors.instance.success,
                        title: "Create Account",
                        padding: EdgeInsets.all(AppSize.width(value: 10)),
                      );
                    },
                  ),
                  Gap(height: 15),
                  Center(
                    child: Wrap(
                      children: [
                        const AppText(text: "Already have an account?"),
                        Gap(width: 10),
                        InkWell(
                          onTap: () {
                            AppRoutes.instance.go(AppRoutesKey.instance.signInScreen);
                          },
                          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                          child: const AppText(text: "Sign In", fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Gap(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
