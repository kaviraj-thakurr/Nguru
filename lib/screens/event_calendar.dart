import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/logic/calendar_event/calendar_event_cubit.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  const EventCalendar({
    super.key, required this.startDate, required this.endDate,
  });

  @override
  EventCalendarState createState() => EventCalendarState();
}

class EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  void initState() {
    
   // getSessionDates();
    super.initState();
     _focusedDay.isAfter(widget.endDate)
        ? _focusedDay = widget.endDate
        : _focusedDay = _focusedDay;
   _focusedDay.isAfter(widget.endDate) ? context.read<CalendarEventCubit>().getCalendarEvent(widget.endDate.month):  context.read<CalendarEventCubit>().getCalendarEvent(_focusedDay.month);
   
  }

  // Future<void> getSessionDates() async {
  //   _startDate = DateFormat("dd-MMM-yyyy")
  //       .parse(await SharedPref.getStartDateOfSession() ?? "");
  //   _endDate = DateFormat("dd-MMM-yyyy")
  //       .parse(await SharedPref.getEndDateOfSession() ?? "");
  //   log(" init call :  $_startDate $_endDate");
  // }

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
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CalendarEventInitialState) {
                  return TableCalendar(
                    rowHeight: 45,
                    daysOfWeekHeight: 20,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: FontUtil.customStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          textColor: MyColors.greyShade_7),
                      weekendStyle: FontUtil.customStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          textColor: MyColors.greyShade_7),
                    ),
                    firstDay: widget.startDate,
                    lastDay: widget.endDate,
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

                if (state is CalendarEventLoadingState) {
                  return TableCalendar(
                    rowHeight: 45,
                    daysOfWeekHeight: 20,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: FontUtil.customStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          textColor: MyColors.greyShade_7),
                      weekendStyle: FontUtil.customStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          textColor: MyColors.greyShade_7),
                    ),
                    firstDay: widget.startDate,
                    lastDay: widget.endDate,
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
                          textColor: MyColors.greenShade_2),
                      todayTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          textColor: MyColors.arc_1),
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
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                      isParticularEventDateSelected = false;

                      context
                          .read<CalendarEventCubit>()
                          .getCalendarEvent(focusedDay.month);
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final dayIndex = day.day - 1; // 0-based index

                        TextStyle defaultStyle = FontUtil.customStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            textColor: MyColors.greyShade_7);
                        int attendanceStatus = 99;
                        try {
                          attendanceStatus =
                              state.calendarEventList?[dayIndex].status == null
                                  ? 99
                                  : state.calendarEventList?[dayIndex].status ??
                                      99;
                        } catch (e) {
                          attendanceStatus = 99;
                        }

                        if (attendanceStatus == 3) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w200,
                              textColor: MyColors.greyShade_7);
                        } else if (attendanceStatus == 2) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.buildLegendColor_5);
                        } else if (attendanceStatus == 1) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.pinkShade_1);

                          calendarEventList
                              .add(state.calendarEventList![dayIndex]);
                        } else if (attendanceStatus == 0) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.buildLegendColor_1);
                        } else if (attendanceStatus == 99) {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.greyShade_7);
                        } else {
                          defaultStyle = FontUtil.customStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.greyShade_7);
                        }
                        return Center(
                          child: Text(
                            '${day.day}',
                            style: defaultStyle,
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
                          textColor: MyColors.greyShade_7),
                      weekendStyle: FontUtil.customStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          textColor: MyColors.greyShade_7),
                    ),
                    firstDay: widget.startDate,
                    lastDay: widget.endDate,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      context
                          .read<CalendarEventCubit>()
                          .filterEventListByDate(_focusedDay, false);
                      isParticularEventDateSelected = true;
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
                          textColor: MyColors.greyShade_7),
                      weekNumberTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          textColor: MyColors.greyShade_7),
                      selectedTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          textColor: MyColors.greenShade_2),
                      todayTextStyle: FontUtil.customStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          textColor: MyColors.arc_1),
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
                      state.message ?? "",
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
    List<String> months = [];
    DateTime current = widget.startDate;
        log(" init call from _buildMonthSelector :  ${widget.startDate} ${widget.endDate}");
    while (current.isBefore(widget.endDate) || current.isAtSameMomentAs(widget.endDate)) {
      months.add(DateFormat('MMM').format(current));
      current = DateTime(current.year, current.month + 1, 1);
    }
    log("months list: $months");

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          int monthIndex = months.indexOf(month);
          log("months index: $monthIndex");
          DateTime monthDate = DateTime(
            widget.startDate.year,
            widget.startDate.month + monthIndex,
          );
          log("logic: ${widget.startDate.month} $monthIndex");
          log("monthDate  object: ${monthDate.year} ${monthDate.month} ${monthDate.day}");

          bool isSelected = _focusedDay.year == monthDate.year &&
              _focusedDay.month == monthDate.month;
          log("currentt yearr: ${_focusedDay.year} ${monthDate.year}");
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Update the focused day
                  _focusedDay = DateTime(
                    widget.startDate.year,
                    widget.startDate.month + monthIndex,
                    1, // Default day to 1
                  );

                  log("focus  yearrr: ${_focusedDay.year} ${_focusedDay.month} ${_focusedDay.day}");
                });
                context
                    .read<CalendarEventCubit>()
                    .getCalendarEvent(_focusedDay.month);
                isParticularEventDateSelected = false;
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

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem("Holiday", MyColors.pinkShade_1),
        _buildLegendItem("Week Offs", MyColors.greyShade_7),
        _buildLegendItem("Events", MyColors.buildLegendColor_5),
        _buildLegendItem("Today", MyColors.arc_1),
        _buildLegendItem("Selected", MyColors.greenShade_2),
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
