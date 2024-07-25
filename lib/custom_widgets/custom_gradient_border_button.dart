import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget customGradientBorderButton(bool isSelected,String? text){
  return ShaderMask(
              shaderCallback: (Rect bounds) {
                return isSelected? MyColors.buttonColors.createShader(bounds) : MyColors.greyGradient.createShader(bounds) ;
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white, // This color is not visible
                    width: 1.0,
                  ),
                ),
                child: Text(
                 text ?? "N/A",
                  style: FontUtil.customStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    textColor: MyColors.monthNameColor,
                  ),
                ),
              ),
            );
}