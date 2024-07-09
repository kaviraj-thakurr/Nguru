import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

class GradientCircleAvatar extends StatelessWidget {
  final double radius;
  final Gradient gradient;
  final Widget child;
  final String title;

  const GradientCircleAvatar({
    Key? key,
    required this.radius,
    required this.gradient,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4), // Padding for space between border and image
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background color for the inner circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(3), // Inner padding for the image
                child: ClipOval(child: child),
              ),
            ),
          ),
        ),
        SizedBox(height: 4), // Space between avatar and title
        Text(
          title,
          style: FontUtil.customStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            textColor: MyColors.addButtonColor,
          ),
        ),
      ],
    );
  }
}
