import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/forgot_password/forgot_password_cubit.dart';
import 'package:nguru/logic/forgot_password/forgot_password_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/login_screen.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/app_utils.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPassCubit(AuthRepo()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                Text(
                  "Forgot Password?",
                  style: FontUtil.customStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      textColor: MyColors.addButtonColor),
                ),
                10.heightBox,
                Text(
                  "Enter your username to receive instructions on how to reset your password.",
                  style: FontUtil.customStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.forgotColor,
                    fontFamily: "Effra_Trial",
                  ),
                ),
                25.heightBox,
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
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
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
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

                  //  VxTextField(
                  //   controller: userNameController,
                  //   fillColor: Colors.transparent,
                  //   borderColor: MyColors.borderColor,
                  //   borderType: VxTextFieldBorderType.roundLine,
                  //   hint: MyStrings.userName,
                  //   style: FontUtil.hintText,
                  //   borderRadius: 9,
                  //   validator: (username) {
                  //     if (username == null || username.isEmpty) {
                  //       return MyStrings.userName;
                  //     }
                  //     return null;
                  //   },
                  // ),
                ),
                10.heightBox,
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Eget enim vulputate porta diam diam.",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Effra_Trial",
                      textColor: MyColors.needHelpColor),
                ),
                25.heightBox,
                BlocConsumer<ForgetPassCubit, ForgetPasswordState>(
                    builder: (context, state) {
                  if (state is ForgetPassLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return PrimaryButton(
                      title: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          isFromForgotPassword=true;
                          context.read<ForgetPassCubit>().forgotPassword(
                                userNameController.text.trim(),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(MyStrings.enterusernamepass),
                            ),
                          );
                        }
                      },
                    );
                  }
                }, listener: (context, state) {
                  if (state is ForgetPassSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Password reset instruction has been sent to your registered Email/Phone")));
                    Navigator.pop(context);
                  } else if (state is ForgetPassErrorState) {
                    _showSnackBar(context, state.message);
                  }
                }),
              ],
            ),
          ),
        ),
      ),
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
