import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Future<dynamic> customAlertDiaog(
  
String? titleText,
String? contentText,
String? cancelButtonActionText,
String? submitButtonActionText,
{
  required BuildContext context,
  required VoidCallback onSubmit,
  required VoidCallback onCancel,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: MyColors.white,
        title:  Text(titleText ?? ""),
        content:  Text(contentText?? ""),
        actions: <Widget>[
          TextButton(
            onPressed: onCancel,
            child:  Text(cancelButtonActionText?? "",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),
          ),
          TextButton(
            onPressed: onSubmit,
            child: Text(submitButtonActionText?? "",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),
          ),
        ],
      );
    }
  );
}