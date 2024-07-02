import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/font_util.dart';
import 'package:nguru/custom_widgets/my_assets.dart';
import 'package:nguru/custom_widgets/my_colors.dart';
import 'package:nguru/custom_widgets/my_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';

import 'package:nguru/screen/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class AddSchool extends StatefulWidget {
   AddSchool({super.key});

  @override
  State<AddSchool> createState() => _SignInState();
}

class _SignInState extends State<AddSchool> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [
              169.heightBox,
              Image.asset(
                MyAssets.niitLogo,
                height: 70,
              ),
              50.heightBox,
              Text(
                MyStrings.customData,
                style: FontUtil.customData,
                textAlign: TextAlign.center,
              ),
              20.heightBox,
              VxTextField(
                fillColor: Colors.transparent,
                borderColor: MyColors.borderColor,
                borderType: VxTextFieldBorderType.roundLine,
                hint: MyStrings.appName,
                style: FontUtil.hintText,
                borderRadius: 9,
              ),
              14.heightBox,
              VxTextField(
                fillColor: Colors.transparent,
                borderColor: MyColors.borderColor,
                borderType: VxTextFieldBorderType.roundLine,
                hint: MyStrings.nickName,
                style: FontUtil.hintText,
                borderRadius: 9,
              ),
              30.heightBox,
              TextButton(onPressed: (){}, child: Text(MyStrings.add,style: FontUtil.needHelp,)),
            //  CustomTextButton(title: MyStrings.add,textStyle: FontUtil.addButton, onPressed: (){}),
              PrimaryButton(
                  title: MyStrings.submit,
                  onPressed: () {
                    NavigationService.navigateTo(
                      LoginScreen(),
                      context,
                    );
                  }),
              20.heightBox,

              TextButton(onPressed: (){}, child: Text(MyStrings.needHelp,style: FontUtil.needHelp,))
           // CustomTextButton(title: MyStrings.needHelp,textStyle: FontUtil.needHelp, onPressed: (){})
            ],
          ),
        )),
      ),
    );
  }
}
