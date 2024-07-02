import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nguru/custom_widgets/font_util.dart';
import 'package:nguru/custom_widgets/gradient_divider.dart';
import 'package:nguru/custom_widgets/my_assets.dart';
import 'package:nguru/custom_widgets/my_colors.dart';

import 'package:nguru/custom_widgets/my_strings.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';

import 'package:nguru/custom_widgets/text_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            const Text(MyStrings.appName),
            8.heightBox,
            const GradientDivider(
              gradient: MyColors.divider,
              height: 2.0, // Customize height as needed
            ),
          
            42.heightBox,
          
            VxTextField(
              fillColor: Colors.transparent,
              borderColor: MyColors.borderColor,
              borderType: VxTextFieldBorderType.roundLine,
              hint: MyStrings.userName,
              style: FontUtil.hintText,
              borderRadius: 9,
            ),
            14.heightBox,
            VxTextField(
              isPassword: true,
              obscureText: true,
              suffixColor: MyColors.textcolors,
              fillColor: Colors.transparent,
              borderColor: MyColors.borderColor,
              borderType: VxTextFieldBorderType.roundLine,
              hint: MyStrings.passWord,
              style: FontUtil.hintText,
              borderRadius: 9,
            ),
            //30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      MyStrings.forgotpassword,
                      style: FontUtil.forgotpassword,
                    )),
              ],
            ),
          
            PrimaryButton(title: MyStrings.signin, onPressed: () {}),
          
            TextButton(
                onPressed: () {},
                child: Text(
                  MyStrings.needHelp,
                  style: FontUtil.needHelp,
                ))
          ],
                ),
              )),
        ));
  }
}
