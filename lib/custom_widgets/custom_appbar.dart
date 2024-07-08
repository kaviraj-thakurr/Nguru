import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:velocity_x/velocity_x.dart';

CustomAppBar dashboardAppBar() {
  return CustomAppBar();
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String selectedValue = 'Session 2024-25';
  List<String> dropdownItems = ['Session 2023-24', 
  'Session 2024-25', 
  'Session 2025-26'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: selectedValue,
                icon: SvgPicture.asset(
                  MyAssets.drop_down_arrow,
                  color: MyColors.addButtonColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          92.heightBox,
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(MyAssets.school),
                onPressed: () {
                  // Add your onPressed code here
                },
              ),
              2.heightBox,
              IconButton(
                icon: SvgPicture.asset(MyAssets.travel),
                onPressed: () {
                  // Add your onPressed code here!
                },
              ),
              2.heightBox,
              IconButton(
                icon: SvgPicture.asset(MyAssets.message),
                onPressed: () {
                  // Add your onPressed code here!
                },
              ),
              2.heightBox,
              IconButton(
                icon: SvgPicture.asset(MyAssets.notifications),
                onPressed: () {
                  // Add your onPressed code here!
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
