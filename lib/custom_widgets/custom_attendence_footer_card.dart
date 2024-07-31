import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget customAttendenceFooterCard(BuildContext context,
    {String? headerText, String? footerText, Color? footerColor}) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.1,
      maxWidth: MediaQuery.of(context).size.width * 0.28,
    ),
    decoration: BoxDecoration(
      color: MyColors.calendarFooterCard,
      borderRadius: BorderRadius.circular(
          5.0), // Half of the width/height for a perfect circle
      border: Border.all(
        color:MyColors.calendarFooterCard,
        width: 2.0,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.23,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Text(
                  headerText ?? "Total Working Days",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.textColors),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              footerText ?? "30",
              style: FontUtil.customStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  textColor: footerColor!),
            )
          ],
        )
      ],
    ),
  );
}
