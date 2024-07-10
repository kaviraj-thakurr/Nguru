import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyColors{
  const MyColors._();

  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color borderColor = Color(0xFFD7D7D7);
  static const Color textcolors = Color(0xFF7A7A7A);
  static const Color buttonColor = Color(0xFF7A7A7A);
  static const Color secondaryColor = Colors.green;
  static const Color needHelpColor = Color(0xFF999999);
  static const Color addButtonColor = Color(0xFF0C0C0B);
  static const Color appColorGreen =  Color(0xFFA0CA7B);
  static const Color appColorBlue = Color(0xFF0160AE);
  static const Color search = Color(0xFFA1A1A1);
   static const Color searchbackgroundColor = Color(0xFFF3F3F3);

  //calendar screen colors
   static const Color calendarFooterCard = Color(0xFFF4F4F4);
  static const Color buildLegendColor_1 = Color(0xFF545557);
   static const Color buildLegendColor_2 = Color(0xFF78818B);
   static const Color buildLegendColor_3 = Color(0xFF8D4399);
   static const Color buildLegendColor_4 = Color(0xFF0160AE);
   static const Color buildLegendColor_5 = Color(0xFFFF3D3D);
   static const Color buildLegendColor_6 = Color(0xFF05B637);
    static const Color calendarDateColor = Color(0xFF1A1A1A);


//container boarder color
  static const Color boarderColor = Color(0xFFEBEBEB);
  static const Color monthNameColor = Color(0xFF333333);
 

//text colors
  static const Color boldTextColor = Color(0xFF242424);
  static const Color fadedTextColor = Color(0xFF434343);
  static const Color white = Color(0xFFFFFFFF);



// gradients
   static const LinearGradient buttonColors = LinearGradient(
    colors: [Color(0xFF0160AE), Color(0xFFA0CA7B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

   static const LinearGradient divider = LinearGradient(
    colors: [Color(0xFFFFFFFF
), Color(0xFF005FAF),Color(0xFFFFFFFF)],
    begin: Alignment.topLeft,    
    end: Alignment.bottomRight
  );


//cards colors 
  static  LinearGradient cardColors = LinearGradient(
    colors: [Color(0xFF0261AE
).withOpacity(0.10), Color(0xFFA0CB7C
).withOpacity(0.10)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}