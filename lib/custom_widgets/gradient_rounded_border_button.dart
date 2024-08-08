import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget gradientRoundedBorderButton({
  double containerVerticalPadding = 6.0,
  double containerHorizontalPadding = 10.0,
  double containerborderWidth = 1.0,
  double containerBorderRadius = 20.0,
  Color containerBorderColor = MyColors.white,
  String title = "Title",
  double fontSize = 12,
  Color fontColor = MyColors.boldTextColor,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return ShaderMask(
    shaderCallback: (Rect bounds) {
      return MyColors.buttonColors.createShader(bounds);
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: containerVerticalPadding,
          horizontal: containerHorizontalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerBorderRadius),
        border: Border.all(
          color: Colors.white, // This color is not visible
          width: containerborderWidth,
        ),
      ),
      child: Text(
        title,
        style: FontUtil.customStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: fontColor,
        ),
      ),
    ),
  );
}
