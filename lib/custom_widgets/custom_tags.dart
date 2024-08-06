import 'package:flutter/material.dart';
import 'package:nguru/utils/app_font.dart';

Widget customTags(String? tagName, Color bgColor, Color tagNameColor, {double fontSize=10,double width=0}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      tagName ?? "N/A",
      style: FontUtil.customStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        textColor: tagNameColor,
      ),
    ),
  );
}
