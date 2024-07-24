import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyColors {
  const MyColors._();

  static const Color sessiontext = Color(0xFF231F20);
  static const Color customdataColor = Color(0xFF3E3E3E);
  static const Color assignmentdateColor = Color(0xFF0160AE);
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color searchbox = Color(0xFFF3F3F3);
  static const Color borderColor = Color(0xFFD7D7D7);
  static const Color textcolors = Color(0xFF7A7A7A);
  static const Color buttonColor = Color(0xFF7A7A7A);
  static const Color secondaryColor = Colors.green;
  static const Color needHelpColor = Color(0xFF999999);
  static const Color addButtonColor = Color(0xFF0C0C0B);
  static const Color pagenocolor = Color(0xFF606060);
  static const Color appColor1 = Color(0xFF0160AE);
  static const Color appColor2 = Color(0xFFA0CA7B);
  static const Color cardsubTitle = Color(0xFF323232);
  static const Color cardTitle = Color(0xFF111111);
  static const Color circular = Color(0xFF333333);
  static const Color circularsubttile = Color(0xFF242424);
  static const Color textfieldColor = Color(0xB3070707);

  static const Color search = Color(0xFFA1A1A1);
  static const Color searchbackgroundColor = Color(0xFFF3F3F3);

//container boarder color
  static const Color boarderColor = Color(0xFFEBEBEB);

//text colors
  static const Color boldTextColor = Color(0xFF000000);
  static const Color fadedTextColor = Color(0xFF434343);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyShade_3 = Color(0xFFAAAAAA);

  //calendar screen colors
  static const Color calendarFooterCard = Color(0xFFF4F4F4);
  static const Color buildLegendColor_1 = Color(0xFF545557);
  static const Color buildLegendColor_2 = Color(0xFF78818B);
  static const Color buildLegendColor_3 = Color(0xFF8D4399);
  static const Color buildLegendColor_4 = Color(0xFF0160AE);
  static const Color buildLegendColor_5 = Color(0xFFFF3D3D);
  static const Color buildLegendColor_6 = Color(0xFF05B637);
  static const Color calendarDateColor = Color(0xFF1A1A1A);
  static const Color forgetpassword = Color(0xFF0160AE);
  static const Color passIcon = Color(0xFF858585);

  //container boarder color

  static const Color monthNameColor = Color(0xFF333333);

  // setting screen

//tags colors
  static const Color blueShades_1 = Color(0xFF0261AE);
  static const Color orangeShades_1 = Color(0xFFF26640);
  static const Color darkPink = Color(0xFF830E3F);
  static const Color purple = Color(0xFF8D4399);
  static const Color skyBlue = Color(0xFF6DBCF7);

  static const Color greyShade_4 = Color(0xFFEAEAEA);
  static const Color greyShade_5 = Color(0xFFF9F9F9);

  // story screen colors
  static const Color greenShade_1 = Color(0xFFA0CA7B);

  static const Color appColorGreen = Color(0xFFA0CA7B);
  static const Color appColorBlue = Color(0xFF0160AE);
  static const Color greyShade_6 = Color(0xFFF3F3F3);

// gradients
  static const LinearGradient buttonColors = LinearGradient(
    colors: [Color(0xFF0160AE), Color(0xFFA0CA7B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient animatedborder = LinearGradient(
    colors: [Color.fromARGB(255, 242, 241, 241), Color.fromARGB(255, 231, 233, 235)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient divider = LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFF005FAF), Color(0xFFFFFFFF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

//cards colors
  static LinearGradient cardColors = LinearGradient(
    colors: [
      Color(0xFF0261AE).withOpacity(0.10),
      Color(0xFFA0CB7C).withOpacity(0.10)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

//arrow color
  static const Gradient arrowColor = LinearGradient(
    colors: <Color>[Color(0xFF0261AE), Color(0xFFA0CB7C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient assignmentDate = LinearGradient(
    colors: <Color>[
      Color(0xFF90CDFF),
      Color(0xFFC9E6FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
