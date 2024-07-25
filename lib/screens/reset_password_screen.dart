import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/reset_password/reset_password_cubit.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/screens/login_screen.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
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
          VxTextField(
            controller: currentPasswordController,
            fillColor: Colors.transparent,
            borderColor: MyColors.boarderColor,
            borderType: VxTextFieldBorderType.roundLine,
            borderRadius: 9.0,
            hint: "Current Password",
            style: FontUtil.hintText,
            isPassword: true,
          ),
          14.heightBox,
          VxTextField(
            controller: newPasswordController,
            fillColor: Colors.transparent,
            borderColor: MyColors.boarderColor,
            borderType: VxTextFieldBorderType.roundLine,
            borderRadius: 9.0,
            hint: "New Password",
            style: FontUtil.hintText,
            isPassword: true,
          ),
          14.heightBox,
          VxTextField(
            controller: confiremNewPasswordController,
            fillColor: Colors.transparent,
            borderColor: MyColors.boarderColor,
            borderType: VxTextFieldBorderType.roundLine,
            borderRadius: 9.0,
            hint: "Confirm New Password",
            style: FontUtil.hintText,
            isPassword: true,
          ),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>const LoginScreen()));
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
