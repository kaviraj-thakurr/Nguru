import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/logic/form_validation/form_validation_cubit.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/forgot_password.dart';
import 'package:nguru/screens/reset_password_screen.dart';

import 'package:nguru/utils/app_font.dart';
import 'package:nguru/custom_widgets/gradient_divider.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_gapping.dart';

import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/utils/app_utils.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  final String? title;
  final String? schoolLogo;

  const LoginScreen({super.key, this.title, this.schoolLogo});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
      userNameController.addListener(() {
      context.read<FormValidationCubit>().validateUserName(userNameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSchoolCubit, AddSchoolState>(
      builder: (context, state) {
        if (state is AddSchoolSuccessState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding23),
                  child: Column(
                    children: [
                      169.heightBox,
                      SvgPicture.asset(state.schoolPhoto??MyAssets.schoolLogo),
                      15.heightBox,
                      Text(
                        state.schoolName ?? MyStrings.schoolName,
                        style: const TextStyle(color: Colors.black),
                      ),
                      8.heightBox,
                      const GradientDivider(
                        gradient: MyColors.divider,
                        height: height1,
                      ),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return MyColors.buttonColors
                                      .createShader(bounds);
                                },
                                child: Container(
                                  height: height18,
                                  width: width18,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: paddingVertical6, horizontal: paddingHorizontal10),
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors
                                          .white, // This color is not visible
                                      width: width1,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 3,
                                left: 3,
                                child: Container(
                                  height: height12,
                                  width: width12,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: paddingVertical6, horizontal: paddingHorizontal10),
                                  decoration: BoxDecoration(
                                    gradient: MyColors.buttonColors,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors
                                          .white, // This color is not visible
                                      width: width1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          5.widthBox,
                          Text(
                            widget.title ?? "",
                            style: FontUtil.schoolName,
                          )
                        ],
                      ),
                      17.heightBox,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            BlocBuilder<FormValidationCubit, FormValidationState>(
                              builder: (context,state) {
                                return CustomTextFormField(
                                  controller: userNameController,
                                  labelText: MyStrings.userName,
                                  validator: (url) {
                                    if (url == null || url.isEmpty) {
                                      return MyStrings.userNameReq;
                                    }
                                    return null;
                                  },
                                 autoValidateMode: state.autoValidateUserName
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                                );
                              }
                            ),
                            14.heightBox,
                            TextFormField(
                              obscureText: _obscureText,
                              controller: passWordController,
                              decoration: InputDecoration(
                                label: const Text(
                                  MyStrings.passWord,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.grey,
                                      fontFamily: APP_FONT),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    color: MyColors.passIcon,
                                    _obscureText
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: paddingVertical15, horizontal: paddingHorizontal20),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.borderColor,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: width1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)),
                                ),
                              ),
                              style: FontUtil.signInFieldText,
                              validator: (pass) {
                                if (pass == null || pass.isEmpty) {
                                  return MyStrings.passWordReq;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              NavigationService.navigateTo(
                                  const ForgotPassword(), context);
                            },
                            child: Text(
                              MyStrings.forgotPassword,
                              style: FontUtil.forgotPassword,
                            ),
                          ),
                        ],
                      ),
                      BlocConsumer<LoginCubit, LoginState>(
                          builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return PrimaryButton(
                            title: MyStrings.signIn,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().logIn(
                                    userNameController.text.trim(),
                                    passWordController.text.toString());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(MyStrings.enterUserNamePass),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      }, listener: (context, state) {
                        if (state is LoginSuccessState) {
                          NavigationService.navigateTo(
                              const NguruDashboardScreen(), context);
                        } else if (state is LoginForgetPasswordState) {
                          isFromForgotPassword = false;
                          NavigationService.navigateTo(
                              const ResetPasswordScreen(), context);
                        } else if (state is LoginErrorState) {
                          _showSnackBar(context, state.message);
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _showSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
