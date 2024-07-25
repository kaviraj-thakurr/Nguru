import 'package:flutter/material.dart';
import 'package:nguru/utils/app_font.dart';

Widget customTags(String? tagName, Color bgColor, Color tagNameColor) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      tagName ?? "N/A",
      style: FontUtil.customStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        textColor: tagNameColor,
      ),
    ),
  );
}
