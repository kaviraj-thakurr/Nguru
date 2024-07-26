import 'package:flutter/cupertino.dart';
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
      fontStyle: FontStyle.italic,
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

  static TextStyle customData =  TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: MyColors.customdataColor,
       fontFamily: APP_FONT
      );

  static TextStyle signInFieldText =   TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF070707).withOpacity(0.7),

      fontFamily: 'Effra_Trial'
  );


  static TextStyle schoolname =   TextStyle(
      fontSize: 18.h,
      fontWeight: FontWeight.w500,
      color: Color(0xFF070707).withOpacity(0.7),

      fontFamily: 'Effra_Trial'
  );

  static TextStyle primaryButton = const TextStyle(
      fontSize: 18,
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
      color: MyColors.forgetpassword,
       fontFamily: 'Effra_Trial'
      );

        static TextStyle add = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: MyColors.forgetpassword,
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

  static TextStyle storyTitle = TextStyle(
      fontSize: 15.h,
      fontWeight: FontWeight.w500,
      color: const Color(0x86231F20),
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


     static TextStyle textfield = TextStyle(
      fontSize: 16.h,
      fontWeight: FontWeight.w500,
      color: MyColors.greyShade_3,
      fontFamily: 'Effra_Trial'
     )  ;

      
}
