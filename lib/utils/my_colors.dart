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
  static const Color white = Color(0xFFFFFFFF);
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
}