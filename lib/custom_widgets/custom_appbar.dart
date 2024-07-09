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
  List<String> dropdownItems = [
    'Session 2023-24',
    'Session 2024-25',
    'Session 2025-26'
  ];

  // Variable to keep track of the selected icon
  String selectedIcon = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: selectedValue,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    MyAssets.drop_down_arrow,
                    color: MyColors.addButtonColor,
                  ),
                ),
                underline: SizedBox.shrink(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
          92.heightBox,
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  MyAssets.school,
                  color: selectedIcon == 'school' ? MyColors.appColor1 : null,
                ),
                onPressed: () {
                  setState(() {
                    selectedIcon = 'school';
                  });
                },
              ),
              2.heightBox,
              IconButton(
                icon: SvgPicture.asset(
                  MyAssets.travel,
                  color: selectedIcon == 'travel' ? MyColors.appColor1 : null,
                ),
                onPressed: () {
                  setState(() {
                    selectedIcon = 'travel';
                  });
                },
              ),
              2.heightBox,
              IconButton(
                icon: SvgPicture.asset(
                  MyAssets.message,
                  color: selectedIcon == 'message' ? MyColors.appColor1 : null,
                ),
                onPressed: () {
                  setState(() {
                    selectedIcon = 'message';
                  });
                },
              ),
              2.heightBox,
              IconButton(
                icon: SvgPicture.asset(
                  MyAssets.notifications,
                  color: selectedIcon == 'notifications'
                      ? MyColors.appColor1
                      : null,
                ),
                onPressed: () {
                  setState(() {
                    selectedIcon = 'notifications';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
