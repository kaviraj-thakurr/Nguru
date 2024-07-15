import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
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
    return Scaffold(
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
                "Lorem ipsum dolor sit amet consectetur. Eget  enim vulputate porta diam diam. ",
                style: TextStyle(fontSize: 17),
              ),
              25.heightBox,
              Form(
                key: _formKey,
                child: VxTextField(
                  controller: userNameController,
                  fillColor: Colors.transparent,
                  borderColor: MyColors.borderColor,
                  borderType: VxTextFieldBorderType.roundLine,
                  hint: MyStrings.userName,
                  style: FontUtil.hintText,
                  borderRadius: 9,
                  validator: (username) {
                    if (username == null || username.isEmpty) {
                      return MyStrings.userName;
                    }
                    return null;
                  },
                ),
              ),
              10.heightBox,
              Text(
                "Lorem ipsum dolor sit amet consectetur. Eget enim vulputate porta diam diam. ",
                style: FontUtil.customStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textColor: MyColors.needHelpColor),
              ),
              25.heightBox,
              PrimaryButton(
                  title: "Sign in",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(MyStrings.enterusernamepass),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
