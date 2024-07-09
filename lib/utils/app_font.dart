import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nguru/utils/app_colors.dart';

class FontUtil {
  static TextStyle customStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color textColor,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      fontFamily: 'FontMain',
    );
  }
  static TextStyle hintText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: MyColors.textcolors,
      fontFamily: 'FontMain');

  static TextStyle sessionchanged = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: MyColors.addButtonColor,
      fontFamily: 'FontMain');

  static TextStyle customData = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.textcolors,
      fontFamily: 'FontMain');

  static TextStyle primaryButton = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: MyColors.white,
      fontFamily: 'FontMain');

  static TextStyle needHelp = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.needHelpColor,
      fontFamily: 'FontMain');

  static TextStyle addButton = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: MyColors.addButtonColor,
      fontFamily: 'FontMain');

  static TextStyle forgotpassword = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.red,
      fontFamily: 'FontMain');

  static TextStyle cardTitle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: MyColors.cardTitle,
      fontFamily: 'FontMain');

  static TextStyle cardsubTitle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: MyColors.textcolors,
      
      fontFamily: 'FontMain');

      static TextStyle search = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: MyColors.search,
      
      fontFamily: 'FontMain');
}
