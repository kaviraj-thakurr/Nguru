import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_state.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';

import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

class AssignmentCalendar extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final bool? isNotificationScreen;
  final DateTime? notificationScreenDate;
  const AssignmentCalendar(
      {super.key,
      this.isNotificationScreen,
      this.notificationScreenDate,
      required this.startDate,
      required this.endDate});

  @override
  _CircularScreenState createState() => _CircularScreenState();
}

class _CircularScreenState extends State<AssignmentCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String dateString = "03-Jun-2024";
  DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
  @override
  void initState() {
    if (widget.notificationScreenDate == null) {
      null;
    } else {
      _focusedDay = widget.notificationScreenDate ?? _focusedDay;
    }

    context.read<AssignmentListCubit>().getAssignmentList(_focusedDay.month,
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(_focusedDay).toString());
    context
        .read<AssignmentMonthListCubit>()
        .getAssignmentMonthList(_focusedDay.month);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMonthSelector(),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<AssignmentMonthListCubit, AssignmentMonthListState>(
            builder: (context, state) {
          if (state is AssignmentMonthListLoadingState) {
            return Center(child: SizedBox.shrink());
          } else if (state is AssignmentMonthListErrorState) {
            return Center(
              child: Text("error"),
            );
          } else if (state is AssignmentMonthListSuccessState) {
            return TableCalendar(
              onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                     

                                context.read<AssignmentMonthListCubit>()
        .getAssignmentMonthList(_focusedDay.month);

                  context.read<AssignmentListCubit>().getAssignmentList(
                      _focusedDay.month,
                      DateFormat('yyyy-MM-ddTHH:mm:ss')
                          .format(_focusedDay)
                          .toString());
                    },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final dayIndex = day.day - 1;

                  Color textColor = Colors.black;
                  TextDecoration textDecoration = TextDecoration.none;
                  log("qwertyyyyyyyy: ${_focusedDay.month}");

                  int? status =
                   state.assignmentMonthList[dayIndex].assignmentStatus ?? 99 ;
                  if (status == 1) {
                    textColor = Colors.blue;
                    textDecoration = TextDecoration.underline;
                  }
                  else if (status == 99) {
                    log("9999999999");
                    textColor = Colors.blue;
                    textDecoration = TextDecoration.underline;
                  }

                  return Center(
                    child: Text(
                      "${day.day}",
                      style: FontUtil.customStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        textColor: textColor,
                        decoration: textDecoration,
                      ),
                    ),
                  );
                },
              ),
              rowHeight: 55,
              daysOfWeekHeight: 25,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: FontUtil.customStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black),
                weekendStyle: FontUtil.customStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w200,
                    textColor: Colors.black),
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
                context.read<AssignmentListCubit>().getAssignmentList(
                    _focusedDay.month,
                    DateFormat('yyyy-MM-ddTHH:mm:ss')
                        .format(_focusedDay)
                        .toString());
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
                    textColor: Colors.black),
                todayDecoration: BoxDecoration(
                  gradient: MyColors.bgDateColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.white),
                ),
              ),
              headerVisible: false,
              startingDayOfWeek: StartingDayOfWeek.monday,
            );
          } else {
            return Center(
              child: Text("Undifined"),
            );
          }
        }),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildMonthSelector() {
    List<String> months = [];
    DateTime current = widget.startDate;
    log(" init call from _buildMonthSelector :  ${widget.startDate} ${widget.endDate}");
    while (current.isBefore(widget.endDate) ||
        current.isAtSameMomentAs(widget.endDate)) {
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
                  log("qwertyyyyy from build month selecter: ${_focusedDay.month}");
                      context.read<AssignmentMonthListCubit>()
        .getAssignmentMonthList(_focusedDay.month);

                  context.read<AssignmentListCubit>().getAssignmentList(
                      _focusedDay.month,
                      DateFormat('yyyy-MM-ddTHH:mm:ss')
                          .format(_focusedDay)
                          .toString());
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
              textColor: MyColors.textColors),
        ),
      ],
    );
  }
}
