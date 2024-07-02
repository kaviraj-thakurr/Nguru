import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  const CustomTextButton({
    required this.title,
    
   required this.onPressed,
    this.textStyle,

    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(onPressed: (){
      onPressed();
    }, title: title,textStyle: textStyle, );
  }
}
