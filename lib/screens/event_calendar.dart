import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/calendar_event/calendar_event_cubit.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({
    super.key,
  });

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<CalendarEventCubit>().getCalendarEvent(_focusedDay.month);
  }

  @override
  Widget build(BuildContext context) {
    List<CalendarEventList> calendarEventList = [];
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          AppGapping.padding30,
          _buildMonthSelector(),
          AppGapping.padding20,
          BlocConsumer<CalendarEventCubit, CalendarEventState>(
              // listenWhen: (previous, current) =>
              //     previous != current, // Trigger only on state change
              listener: (context, state) {
                // Set myVariable only once when transitioning to CalendarEventSuccessState
                // if (state is CalendarEventSuccessState &&
                //     state.myVariable == null) {
                //   context
                //       .read<CalendarEventCubit>()
                //       .setMyVariable(calendarEventList);
                // }
              },
              builder: (context, state) {
                if (state is CalendarEventInitialState) {
                  return TableCalendar(
                    rowHeight: 45,
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
                    calendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: MyColors.calendarDateColor),
                      weekendTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: MyColors.fadedTextColor),
                      selectedTextStyle: FontUtil.customStyle(
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
                  );
                }

                if (state is CalendarEventSuccessState) {
                  return TableCalendar(
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        // Determine the index of the day in the month
                        final dayIndex = day.day - 1; // 0-based index

                        //  Apply different styling based on the day index
                        Color textColor = Colors.black;
                        TextStyle defaultStyle = FontUtil.customStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            textColor: MyColors.calendarDateColor);

                        int attendanceStatus =
                            state.calendarEventList?[dayIndex].status ?? 0;
                        //  log("${attendanceStatus} ");

                        // status == 3 not showing anything even in quick school app

                        if (attendanceStatus == 3) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.buildLegendColor_1);
                          textColor = MyColors.buildLegendColor_1;
                        } else if (attendanceStatus == 2) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.buildLegendColor_5);
                          textColor = MyColors.buildLegendColor_5;
                        } else if (attendanceStatus == 1) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.pinkShade_1);
                          textColor = MyColors.pinkShade_1;
                          calendarEventList
                              .add(state.calendarEventList![dayIndex]);
                        } else if (attendanceStatus == 0) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.buildLegendColor_1);
                          textColor = MyColors.buildLegendColor_1;
                        } else {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.greyShade_7);
                          textColor = MyColors.greyShade_7;
                        }
                        return Center(
                          child: Text(
                            '${day.day}',
                            style: defaultStyle ??
                                TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        );
                      },
                    ),
                    rowHeight: 45,
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
                    calendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: MyColors.calendarDateColor),
                      weekendTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: MyColors.fadedTextColor),
                      selectedTextStyle: FontUtil.customStyle(
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
                  );
                } else if (state is CalendarEventErrorState) {
                  return Center(
                    child: Text(
                      state.message?? "",
                      style: FontUtil.customStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.boldTextColor),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      MyStrings.undefinedState,
                      style: FontUtil.customStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.boldTextColor),
                    ),
                  );
                }
              }),
          const SizedBox(height: 10),
          _buildLegend(),
          //  const SizedBox(height: 10,),
          //    customAttendenceFooterCard(context),
        ],
      ),
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
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                context
                    .read<CalendarEventCubit>()
                    .getCalendarEvent(_focusedDay.month);
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
        _buildLegendItem("Holiday", MyColors.pinkShade_1),
        _buildLegendItem("Week Offs", MyColors.greyShade_7),
        _buildLegendItem("Events", MyColors.buildLegendColor_5),
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
