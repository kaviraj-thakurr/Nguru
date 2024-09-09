
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/month_selector.dart';
import 'package:nguru/logic/discipline/descipline_cubit.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:table_calendar/table_calendar.dart';

class DisciplineCalendar extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  const DisciplineCalendar(
      {super.key, required this.startDate, required this.endDate});

  @override
  _DisciplineCalendarState createState() => _DisciplineCalendarState();
}

class _DisciplineCalendarState extends State<DisciplineCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        monthSelector(
          widget.startDate,
          widget.endDate,
          _focusedDay,
          (selectedDate) {
            setState(() {
              _focusedDay = selectedDate;
            });
            context
                .read<DisciplineCubit>()
                .filterDisciplineListByDate(_focusedDay, true);
          },
        ),
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
                .read<DisciplineCubit>()
                .filterDisciplineListByDate(_focusedDay, false);
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
      ],
    );
  }
}
