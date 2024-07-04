import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:nguru/utils/font_util.dart';
import 'package:nguru/utils/my_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class PrimaryButton extends StatelessWidget {
   final String title;
  final VoidCallback onPressed;
  final bool? isLoading;
  
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading,
  });

 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MyColors.buttonColors,
        borderRadius: BorderRadius.circular(11),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: Size(MediaQuery.of(context).size.width, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: isLoading == true
            ? const CircularProgressIndicator(
                color: MyColors.white,
              )
            : Text(title,style: FontUtil.primaryButton,),
      ),
    );
  }
}
