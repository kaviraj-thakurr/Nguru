import 'package:flutter/material.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget customTabSelector(
  List<String> selecterItems,
  int currentTab,
  Function(int) onTabSelected,
  bool isMonthSelector,
) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(right: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: selecterItems.map((item) {
        bool isSelected =isMonthSelector ?currentTab == selecterItems.indexOf(item) + 1 : currentTab == selecterItems.indexOf(item);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            onTap: () {
         isSelected =isMonthSelector ?currentTab == selecterItems.indexOf(item) + 1 : currentTab == selecterItems.indexOf(item);

              onTabSelected(
                isMonthSelector ?  selecterItems.indexOf(item) + 1 :  selecterItems.indexOf(item),
              );
            },
            child: isSelected == true
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return MyColors.buttonColors.createShader(bounds);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.white, 
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        item,
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight: isSelected == true
                              ? FontWeight.w500
                              : FontWeight.w400,
                          textColor: MyColors.monthNameColor,
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      item,
                      style: FontUtil.customStyle(
                        fontSize: 10,
                        fontWeight: isSelected == true
                            ? FontWeight.w500
                            : FontWeight.w400,
                        textColor: MyColors.monthNameColor,
                      ),
                    ),
                  ),
          ),
        );
      }).toList(),
    ),
  );
}