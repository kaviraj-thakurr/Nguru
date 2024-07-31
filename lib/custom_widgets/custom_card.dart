import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_sizebox.dart'; // Assuming this is where MyColors is imported from

Widget customCardssssss({
  required BuildContext context,
  required String title,
  required String content,
  required double titleSize,
  required double contentSize,
  required IconData icon,
  required VoidCallback onIconPressed,
required double cardHeight,
required double cardWidth// Default to full width
}) {
  return Container(
height: 10,
width: 19,
    decoration: BoxDecoration(

      gradient: MyColors.divider,
       // Assuming MyColors is defined correctly
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(icon),
                color: Colors.white,
                onPressed: onIconPressed,
              ),
            ],
          ),
        AppGapping.padding8,
          //SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: contentSize,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    ),
  );
}
