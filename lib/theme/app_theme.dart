import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nguru/utils/app_colors.dart';


class AppThemes {
  AppThemes._();
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.white),
    useMaterial3: false,
    fontFamily: GoogleFonts.poppins().fontFamily,
    
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.addButtonColor),
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}
