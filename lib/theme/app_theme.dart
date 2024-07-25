import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';


class AppThemes {
  AppThemes._();
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.white),
    useMaterial3: true,
    fontFamily: "Nunito",
    
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.addButtonColor),
    useMaterial3: true,
    fontFamily: "Nunito",
  );
}
