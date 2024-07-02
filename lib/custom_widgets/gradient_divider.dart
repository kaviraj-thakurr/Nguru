import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final LinearGradient gradient;
  
  final double ? height;

  const GradientDivider({
    Key? key,
    required this.gradient,
    this.height ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Divider(
        color: Colors.transparent,
      ),
    );
  }
}
