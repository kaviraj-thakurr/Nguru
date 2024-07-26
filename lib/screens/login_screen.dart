import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/forgot_password.dart';
import 'package:nguru/screens/reset_password_screen.dart';

import 'package:nguru/utils/app_font.dart';
import 'package:nguru/custom_widgets/gradient_divider.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';

import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/logic/login_cubit/login_state.dart';

import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  final String? title;
  final String? schoolLogo;

  const LoginScreen({super.key, this.title, this.schoolLogo});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSchoolCubit, AddSchoolState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AddSchoolSuccessState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      169.heightBox,
                      SvgPicture.asset(MyAssets.schoolLogo),
                      15.heightBox,
                      Text(
                        state.schoolName ?? 'School Name',
                        style: const TextStyle(color: Colors.black),
                      ),
                      8.heightBox,
                      const GradientDivider(
                        gradient: MyColors.divider,
                        height: 1.0,
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
                                  height: 18,
                                  width: 18,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors
                                          .white, // This color is not visible
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 3,
                                left: 3,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    gradient: MyColors.buttonColors,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors
                                          .white, // This color is not visible
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          5.widthBox,
                          Text(widget.title ?? "",style: FontUtil.schoolname,)
                        ],
                      ),
                      17.heightBox,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20)
                              ],
                              controller: userNameController,
                              decoration: const InputDecoration(
                                label: Text(
                                  MyStrings.userName,
                                  style: TextStyle(
                                      //   fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: "Effra_Trial"),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.borderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)),
                                ),
                              ),
                          style: FontUtil.signInFieldText,
                              validator: (url) {
                                if (url == null || url.isEmpty) {
                                  return MyStrings.userName;
                                }
                                return null;
                              },
                            ),
                            14.heightBox,
                            TextFormField(
                              obscureText: _obscureText,
                              controller: passWordController,
                              decoration: InputDecoration(
                                label: const Text(
                                  MyStrings.passWord,
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: "Effra_Trial"),
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
                                    vertical: 15.0, horizontal: 20.0),
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
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)),
                                ),
                              ),
                              style: FontUtil.signInFieldText,
                              validator: (url) {
                                if (url == null || url.isEmpty) {
                                  return MyStrings.passWord;
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
                              MyStrings.forgotpassword,
                              style: FontUtil.forgotpassword,
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
                            title: "Sign in",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().logIn(
                                    userNameController.text.trim(),
                                    passWordController.text.toString());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(MyStrings.enterusernamepass),
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
                        } 

                       else if (state is LoginForgetPasswordState) {
                          NavigationService.navigateTo(
                              const ResetPasswordScreen(), context);
                        } 
                        
                        else if (state is LoginErrorState) {
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
        duration: Duration(seconds: 3),
      ),
    );
  }
}
