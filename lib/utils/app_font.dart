import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/utils/app_colors.dart';

const String APP_FONT = "Effra_Trial";

class FontUtil {
  static TextStyle customStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color textColor,
    String? fontFamily,
    TextDecoration? decoration, 
    
    
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      fontFamily: APP_FONT,
    
      decoration: decoration,
      decorationColor: Colors.blue, // Set the underline color
                decorationThickness: 1, // Set the underline thickness
               
    );
  }

  static TextStyle hintText = TextStyle(
      fontSize: 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      color: MyColors.textColors,
      fontFamily: APP_FONT);

  static TextStyle sessionchanged = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: MyColors.addButtonColor,
      fontFamily: APP_FONT);

  static TextStyle customData = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.customDataColor,
      fontFamily: APP_FONT);

  static TextStyle password = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: MyColors.grey,
      fontFamily: APP_FONT);

  static TextStyle signInFieldText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF070707).withOpacity(0.7),
      fontFamily: APP_FONT);

  static TextStyle schoolName = TextStyle(
      fontSize: 18.h,
      fontWeight: FontWeight.w500,
      color: Color(0xFF070707).withOpacity(0.7),
      fontFamily: APP_FONT);

  static TextStyle primaryButton = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: MyColors.white,
      fontFamily: APP_FONT);

  static TextStyle needHelp = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.needHelpColor,
      fontFamily: APP_FONT);

  static TextStyle addButton = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: MyColors.addButtonColor,
      fontFamily: APP_FONT);

  static TextStyle forgotPassword = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: MyColors.forgetPassword,
      fontFamily: APP_FONT);

  static TextStyle add = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: MyColors.forgetPassword,
      fontFamily: APP_FONT);

  // static TextStyle cardTitle = TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.w500,
  //     color: MyColors.cardTitle,
  //     fontFamily: 'QuickStand'
  //     );

  static TextStyle cardsubTitle = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: MyColors.textColors,
      fontFamily: APP_FONT);

  static TextStyle search = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: MyColors.search,
      fontFamily: APP_FONT);

  static TextStyle cardTitle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: MyColors.cardTitle,
      fontFamily: APP_FONT);

  static TextStyle noCircular = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w400,
      color: MyColors.circular,
      fontFamily: APP_FONT);

  static TextStyle noCircularcommets = TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w400,
      color: MyColors.circular,
      fontFamily: APP_FONT);

  static TextStyle storyTitle = TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w500,
      color: MyColors.storyFotter,
      fontFamily: APP_FONT);

  static TextStyle circularSubtitle = TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w400,
      color: MyColors.circularSubTittles,
      fontFamily: APP_FONT);

  static TextStyle circularTitle = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: MyColors.circularSubTittle,
      fontFamily: APP_FONT);

  static TextStyle textfield = TextStyle(
      fontSize: 16.h,
      fontWeight: FontWeight.w500,
      color: MyColors.greyShade_3,
      fontFamily: APP_FONT);

static TextStyle notificationTitle = TextStyle(
      fontSize: 17.h,
      fontWeight: FontWeight.w500,
      color: MyColors.teacherNameColor,
      fontFamily: APP_FONT);


      static TextStyle notificationSubtitle = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w400,
      color: MyColors.notificationSubtitle,
      fontFamily: APP_FONT);
  
}
