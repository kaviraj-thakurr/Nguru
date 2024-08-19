import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';

// Widget gradientRoundedBorderButton({
 
//   double containerVerticalPadding = 6.0,
//   double containerHorizontalPadding = 10.0,
//   double containerborderWidth = 1.0,
//   double containerBorderRadius = 20.0,
//   Color containerBorderColor = MyColors.white,
//   String title = "Title",

//   double fontSize = 12,
//   Color fontColor = MyColors.boldTextColor,
//   FontWeight fontWeight = FontWeight.w500,
//   VoidCallback? onPressed,
// }) {
//   return GestureDetector(
//     onTap: onPressed,
//     child: ShaderMask(
//       shaderCallback: (Rect bounds) {
//         return MyColors.buttonColors.createShader(bounds);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             vertical: containerVerticalPadding,
//             horizontal: containerHorizontalPadding),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(containerBorderRadius),
//           border: Border.all(
//             color: containerBorderColor,
//             width: containerborderWidth,
//           ),
//         ),
//         child: Text(
//           title,
//           style: FontUtil.customStyle(
//             fontSize: 12,
//             fontWeight: fontWeight,
//             textColor: fontColor,
//           ),
//         ),
//       ),
//     )
   
//   );
// }
Widget gradientRoundedBorderButton({
  required String title,
  required VoidCallback onPressed,
  required FontWeight fontWeight,
  bool isSelected = false,
   
  double containerVerticalPadding = 6.0,
  double containerHorizontalPadding = 10.0,
  double containerborderWidth = 2.0,
  double containerBorderRadius = 18.0,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
         color: isSelected ? Colors.transparent : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(containerBorderRadius),
        gradient: isSelected
            ? MyColors.buttonBackground
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: paddingVertical8, horizontal: paddingHorizontal12),
      child: Text(
        title,
        style: FontUtil.customStyle(
            fontSize: 12,
             fontWeight: fontWeight,
             textColor: MyColors.boldTextColor,
           ),
      ),
    ),
  );
}
