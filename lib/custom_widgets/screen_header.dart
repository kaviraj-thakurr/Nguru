

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget screenTitleHeader(String title,{ Function()? onPressed }) {
  return Row(
    children: [
      IconButton(onPressed: onPressed, icon: const Icon(
        color: MyColors.boldTextColor,
        Icons.arrow_back)),
      Text(title,
          style: FontUtil.customStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textColor: MyColors.boldTextColor)),
    ],
  );
}