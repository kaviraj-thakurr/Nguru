
import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';


Widget attendenceAndFeeCard(BuildContext context,
    {bool? isFeeCard, headerText, String? mainText, String? footerText}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    constraints: BoxConstraints(
      maxHeight: isFeeCard!
          ? MediaQuery.of(context).size.height * 0.12
          : MediaQuery.of(context).size.height * 0.11,
      maxWidth: MediaQuery.of(context).size.width * 0.33,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: MyColors.boarderColor,
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // if (headerText != null)
              //   Flexible(
              //     flex: 1,
              //     child: Text(headerText,
              //         style: FontUtil.customStyle(
              //             fontSize: 10,
              //             fontWeight: FontWeight.w300,
              //             textColor: MyColors.textcolors)),
              //   ),
              Flexible(
                flex: 3,
                child: Text(mainText ?? '__',
                    style: FontUtil.customStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.boldTextColor)),
              ),
              Flexible(
                flex: 1,
                child: Text(footerText ?? 'N/A',
                    style: FontUtil.customStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        textColor: MyColors.textcolors)),
              ),
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
  );
}
