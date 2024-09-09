  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

Widget monthSelector(
    DateTime startDate,
    DateTime endDate,
    DateTime selectedMonth,
    Function(DateTime) onMonthSelected,
  ) {
    List<String> months = [];
    DateTime current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      months.add(DateFormat('MMM').format(current));
      current = DateTime(current.year, current.month + 1, 1);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          int monthIndex = months.indexOf(month);
          DateTime monthDate = DateTime(
            startDate.year,
            startDate.month + monthIndex,
            1, // Default day to 1
          );

          bool isSelected = selectedMonth.year == monthDate.year &&
              selectedMonth.month == monthDate.month;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => onMonthSelected(monthDate),
              child: isSelected
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
                          month,
                          style: FontUtil.customStyle(
                            fontSize: 10,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
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
                        month,
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
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