import 'package:flutter/material.dart';

import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:table_calendar/table_calendar.dart';


CircularCalendar circularCalendar() {
  return CircularCalendar();
}

class CircularCalendar extends StatefulWidget {
  const CircularCalendar({super.key});

  @override
 
  _CircularScreenState createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          _buildMonthSelector(),
          const SizedBox(
            height: 20,
          ),
          TableCalendar(
            rowHeight: 55,
            
            daysOfWeekHeight: 20,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: FontUtil.customStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  textColor: MyColors.calendarDateColor),
              weekendStyle: FontUtil.customStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  textColor: MyColors.calendarDateColor),
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.week,
            calendarStyle: CalendarStyle(
              
              defaultTextStyle: FontUtil.customStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  textColor: MyColors.calendarDateColor),
              weekendTextStyle: FontUtil.customStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  textColor: MyColors.fadedTextColor),
              selectedTextStyle: FontUtil.customStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.blue),
              todayTextStyle: FontUtil.customStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.pink),
              todayDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
              ),
            ),
            headerVisible: false,
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
          const SizedBox(height: 10),
       //   _buildLegend(),
          //  const SizedBox(height: 10,),
          //    customAttendenceFooterCard(context),
        ],
      );
  }

  Widget _buildMonthSelector() {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding:const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          bool isSelected = _focusedDay.month == months.indexOf(month) + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    months.indexOf(month) + 1,
                  );
                });
              },
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
                            color: Colors.white, // This color is not visible
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
                          color: Colors.grey, // This color is not visible
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

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem("Present", MyColors.buildLegendColor_6),
        _buildLegendItem("Absent", MyColors.buildLegendColor_5),
        _buildLegendItem("Half Day", MyColors.buildLegendColor_4),
        _buildLegendItem("Late", MyColors.buildLegendColor_3),
        _buildLegendItem("Leave", MyColors.buildLegendColor_2),
        _buildLegendItem("Holiday", MyColors.buildLegendColor_1),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 8),
        const SizedBox(width: 3),
        Text(
          text,
          style: FontUtil.customStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              textColor: MyColors.textcolors),
        ),
      ],
    );
  }
}