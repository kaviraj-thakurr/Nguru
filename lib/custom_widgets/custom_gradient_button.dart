import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';

Widget gradientRoundedBorderButton({
  required String title,
  required VoidCallback onPressed,
  required FontWeight fontWeight,
  bool isSelected = false,
  double containerVerticalPadding = 6.0,
  double containerHorizontalPadding = 10.0,
  double containerborderWidth = 1.5,
  double containerBorderRadius = 18.0,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: ShaderMask(
      shaderCallback: (Rect bounds) {
        return isSelected
            ? MyColors.buttonColors.createShader(bounds)
            : const LinearGradient(colors: [Colors.grey, Colors.grey])
                .createShader(bounds);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: containerborderWidth,
            color: Colors.white, // This color will be overridden by ShaderMask
          ),
          borderRadius: BorderRadius.circular(containerBorderRadius),
        ),
        padding: EdgeInsets.symmetric(
          vertical: containerVerticalPadding,
          horizontal: containerHorizontalPadding,
        ),
        child: Text(
          title,
          style: FontUtil.customStyle(
            fontSize: 12,
            fontWeight: fontWeight,
            textColor: MyColors.boldTextColor,
          ),
        ),
      ),
    ),
  );
}
