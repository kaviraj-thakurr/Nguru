import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nguru/utils/my_colors.dart';


class FontUtil {
      static TextStyle hintText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: MyColors.textcolors,
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
  }
