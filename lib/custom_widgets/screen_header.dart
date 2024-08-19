

import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

Widget screenTitleHeader(String title,{ Function()? onPressed }) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onPressed,
        child: const Icon(Icons.arrow_back),
      ),
      5.widthBox,
      Text(title,
          style: FontUtil.customStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily:"Effra_Trial",
              textColor: MyColors.boldTextColor)),
    ],
  );
}