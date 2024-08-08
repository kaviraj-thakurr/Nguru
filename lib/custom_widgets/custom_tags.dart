import 'package:flutter/material.dart';
import 'package:nguru/utils/app_font.dart';

Widget customTags(String? tagName, Color bgColor, Color tagNameColor, {double fontSize=10,double width=0, double verticalPadding=6.0, double horizontalPadding=10.0, FontWeight fontWeight=FontWeight.w500}) {
  return Container(
    padding:  EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Center(
      child: Text(
        tagName ?? "N/A",
        style: FontUtil.customStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: tagNameColor,
        ),
      ),
    ),
  );
}
