import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyColors {
  const MyColors._();

  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color borderColor = Color(0xFFD7D7D7);
  static const Color textcolors = Color(0xFF7A7A7A);
  static const Color buttonColor = Color(0xFF7A7A7A);
  static const Color secondaryColor = Colors.green;
  static const Color needHelpColor = Color(0xFF999999);
  static const Color addButtonColor = Color(0xFF0C0C0B);
  static const Color appColor1 = Color(0xFF0160AE);
  static const Color appColor2 = Color(0xFFA0CA7B);
  static const Color cardsubTitle = Color(0xFF323232);
   static const Color cardTitle = Color(0xFF111111);

   static const Color search = Color(0xFFA1A1A1);
   static const Color searchbackgroundColor = Color(0xFFF3F3F3);

//container boarder color
  static const Color boarderColor = Color(0xFFEBEBEB);

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
    colors: <Color>[Color(0xFF0261AE
), Color(0xFFA0CB7C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
