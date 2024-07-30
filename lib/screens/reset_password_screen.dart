import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/reset_password/reset_password_cubit.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/screens/login_screen.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confiremNewPasswordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confiremNewPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          30.heightBox,
          screenTitleHeader("Reset Password ?",
              onPressed: () => Navigator.pop(context)),
          15.heightBox,
          Text(
            "Lorem ipsum dolor sit amet consectetur. Eget enim vulputate porta diam diam.",
            textAlign: TextAlign.center,
            style: FontUtil.customStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: MyColors.fadedTextColor),
          ),
          14.heightBox,

              TextFormField(
                              obscureText: _obscureText,
                              controller: currentPasswordController,
                              decoration: InputDecoration(
                                label: const Text(
                                  MyStrings.currentpass,
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
          // TextFormField(
          //   inputFormatters: [LengthLimitingTextInputFormatter(20)],
          //   controller: currentPasswordController,
          //   // ignore: prefer_const_constructors
          //   decoration: InputDecoration(
          //     label: const Text(
          //       MyStrings.currentpass,
          //       style: TextStyle(
          //           fontSize: 15,
          //           // fontStyle: FontStyle.italic,
          //           color: Colors.grey,
          //           fontFamily: "Effra_Trial"),
          //     ),
          //     contentPadding:
          //         const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          //     border: const OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //     ),
          //     enabledBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: MyColors.borderColor,
          //       ),
          //     ),
          //     focusedBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey, width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //     ),
          //   ),
          //   style: FontUtil.signInFieldText,
          // ),
          14.heightBox,

          TextFormField(
                              obscureText: _obscureText,
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                label: const Text(
                                  MyStrings.newpass,
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
          // TextFormField(
          //   inputFormatters: [LengthLimitingTextInputFormatter(20)],
          //   controller: newPasswordController,
          //   decoration: const InputDecoration(
          //     label: Text(
          //       MyStrings.newpass,
          //       style: TextStyle(
          //           fontSize: 15,
          //           // fontStyle: FontStyle.italic,
          //           color: Colors.grey,
          //           fontFamily: "Effra_Trial"),
          //     ),
          //     contentPadding:
          //         EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: MyColors.borderColor,
          //       ),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey, width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //     ),
          //   ),
          //   style: FontUtil.signInFieldText,
          // ),
          14.heightBox,


          TextFormField(
                              obscureText: _obscureText,
                              controller: confiremNewPasswordController,
                              decoration: InputDecoration(
                                label: const Text(
                                  MyStrings.confirmnewpass,
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
          // TextFormField(
          //   inputFormatters: [LengthLimitingTextInputFormatter(20)],
          //   controller: confiremNewPasswordController,
          //   // ignore: prefer_const_constructors
          //   decoration: InputDecoration(
          //     label: const Text(
          //       MyStrings.confirmnewpass,
          //       style: TextStyle(
          //           fontSize: 15,
          //           // fontStyle: FontStyle.italic,
          //           color: Colors.grey,
          //           fontFamily: "Effra_Trial"),
          //     ),
          //     contentPadding:
          //         const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          //     border: const OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //     ),
          //     enabledBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: MyColors.borderColor,
          //       ),
          //     ),
          //     focusedBorder: const OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey, width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(9.0)),
          //     ),
          //   ),
          //   style: FontUtil.signInFieldText,
          // ),
          30.heightBox,
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
            if (state is ResetPasswordLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return PrimaryButton(
                  title: "Sign in",
                  onPressed: () {
                    if (currentPasswordController.text.isNotEmpty &&
                        newPasswordController.text.isNotEmpty &&
                        confiremNewPasswordController.text.isNotEmpty &&
                        newPasswordController.text ==
                            confiremNewPasswordController.text) {
                      context.read<ResetPasswordCubit>().resetPassword(
                          confiremNewPasswordController.text,
                          currentPasswordController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please fill out the propper and correct details!!")));
                    }
                  });
            }
          }, listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Your new password is reset successfully!")));
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const LoginScreen()));
              Navigator.pop(context);
            } else if (state is ResetPasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Something went wrong!")));
            }
          }),
        ],
      ),
    ));
  }
}
