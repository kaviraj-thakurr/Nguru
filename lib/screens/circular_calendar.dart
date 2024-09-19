import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/logic/circular/circular_list/circular_cubit.dart';

import 'package:nguru/models/circular_model/circular_model.dart';

import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:table_calendar/table_calendar.dart';




class CircularCalendar extends StatefulWidget {
   final DateTime startDate;
  final DateTime endDate;
  final  bool ? isNotificationScreen  ;
final  int? notificationScreenDate;
  const CircularCalendar({super.key, this.isNotificationScreen, this.notificationScreenDate, required this.startDate, required this.endDate});

  @override
 
  _CircularScreenState createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
 final ScrollController buildMonthSelecterController= ScrollController();


  String dateString = "03-Jun-2024";
  DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
 // DateTime dateTime = DateFormat("dd-MMM-yyyy").parse(dateString);

 @override
  void initState() {

    if(widget.notificationScreenDate == null){

    }
    else{
        _focusedDay= DateTime(_focusedDay.year,widget.notificationScreenDate?? _focusedDay.month,_focusedDay.day);

    }


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          _buildMonthSelector(),
          const SizedBox(
            height: 20,
          ),
        ],
      );
  }



    void _scrollToCenter(int index, double itemWidth, double viewportWidth) {
    // Calculate the offset to center the selected item
    double offset = index * itemWidth - (viewportWidth / 2) + (itemWidth / 2);
    
    // Ensure the offset doesn't scroll out of bounds
    double maxScrollExtent = buildMonthSelecterController.position.maxScrollExtent;
    double minScrollExtent = buildMonthSelecterController.position.minScrollExtent;
    double finalOffset = offset.clamp(minScrollExtent, maxScrollExtent);

    // Animate the scroll to the calculated offset
    buildMonthSelecterController.animateTo(
      finalOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
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
    //  controller: buildMonthSelecterController,
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
                 context.read<CircularCubit>().getCurrentCircular(month: _focusedDay.month);
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