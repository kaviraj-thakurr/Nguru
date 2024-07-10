// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nguru/utils/app_colors.dart';


// class FontUtil {
//       static TextStyle hintText =const TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//       color: MyColors.textcolors,
//       fontFamily: 'FontMain');

//        static TextStyle sessionchanged =const TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//       color: MyColors.addButtonColor,
//       fontFamily: 'FontMain');

//       static TextStyle customData =const TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w400,
//       color: MyColors.textcolors,
//       fontFamily: 'FontMain');
       
       
//        static TextStyle primaryButton =const TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.w500,
//       color: MyColors.white,
//       fontFamily: 'FontMain');

//       static TextStyle needHelp =const TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w400,
//       color: MyColors.needHelpColor,
//       fontFamily: 'FontMain');



//       static TextStyle addButton =const TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.w500,
//       color: MyColors.addButtonColor,
//       fontFamily: 'FontMain');

//       static TextStyle forgotpassword =const TextStyle(
//       fontSize: 12,
//       fontWeight: FontWeight.w500,
//       color: Colors.red,
//       fontFamily: 'FontMain');
//   }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static const TextStyle hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MyColors.textcolors,
    fontFamily: 'FontMain',
  );

  static const TextStyle sessionchanged = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyColors.addButtonColor,
    fontFamily: 'FontMain',
  );

  static const TextStyle customData = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: MyColors.textcolors,
    fontFamily: 'FontMain',
  );

  static const TextStyle primaryButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: MyColors.white,
    fontFamily: 'FontMain',
  );

  static const TextStyle needHelp = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: MyColors.needHelpColor,
    fontFamily: 'FontMain',
  );

  static const TextStyle addButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: MyColors.addButtonColor,
    fontFamily: 'FontMain',
  );

  static const TextStyle forgotpassword = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.red,
    fontFamily: 'FontMain',
  );

  static TextStyle search = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: MyColors.search,
      
      fontFamily: 'FontMain');
}
