import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';

Widget attendenceAndFeeCard(BuildContext context,
    {String? headerText, String? mainText, String? footerText}) {
  return Container(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.106,
      maxWidth: MediaQuery.of(context).size.width * 0.33,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: MyColors.boarderColor,
        width: 2.0,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (headerText != null)
                  Text(headerText,
                      style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          textColor: MyColors.textcolors)),
                Text(mainText ?? '__',
                    style: FontUtil.customStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.boldTextColor)),
                Text(footerText ?? 'N/A',
                    style: FontUtil.customStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        textColor: MyColors.textcolors)),
              ],
            ),
          ),
          const Icon(
            Icons.circle,
            color: Colors.green,
            size: 10,
          ),
        ],
      ),
    ),
  );
}
