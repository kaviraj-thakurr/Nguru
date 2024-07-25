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



const  String  APP_FONT = "Effra_Trial";
class FontUtil {
  static TextStyle customStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color textColor,
    String? fontFamily,
    
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      fontFamily: "Effra_Trial",
    );
  }

  static TextStyle hintText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: MyColors.textcolors,
       fontFamily: 'Effra_Trial'
      );

  static TextStyle sessionchanged = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: MyColors.addButtonColor,
       fontFamily: 'Effra_Trial'
      );

  static TextStyle customData = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.customdataColor,
       fontFamily: APP_FONT
      );

  static TextStyle primaryButton = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: MyColors.white,
      fontFamily: 'Effra_Trial'
      );

  static TextStyle needHelp = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.needHelpColor,
      fontFamily: 'Effra_Trial'
      );

  static TextStyle addButton = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: MyColors.addButtonColor,
       fontFamily: 'Effra_Trial'
      );

  static TextStyle forgotpassword = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.red,
       fontFamily: 'Effra_Trial'
      );

  // static TextStyle cardTitle = TextStyle(
  //     fontSize: 14,
  //     fontWeight: FontWeight.w500,
  //     color: MyColors.cardTitle,
  //     fontFamily: 'QuickStand'
  //     );

  static TextStyle cardsubTitle = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: MyColors.textcolors,
        fontFamily: 'Effra_Trial');
  
    

  static TextStyle search = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: MyColors.search,
      fontFamily: 'Effra_Trial'
      );

      static TextStyle cardTitle = TextStyle(
      fontSize: 16.h,
      fontWeight: FontWeight.w600,
      color: MyColors.cardTitle,
      fontFamily: 'Effra_Trial'
      );

       static TextStyle noCircular = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w400,
      color: MyColors.circular,
      fontFamily: 'Effra_Trial'
      );

      static TextStyle noCircularcommets = TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w400,
      color: MyColors.circular,
      fontFamily: 'Effra_Trial'
      );

       static TextStyle circularsubttile = TextStyle(
      fontSize: 12.h,
      fontWeight: FontWeight.w400,
      color: MyColors.circularsubttile,
      fontFamily: 'Effra_Trial'
      );


      static TextStyle circularTitle = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: MyColors.circularsubttile,
        fontFamily: 'Effra_Trial');

      
}
