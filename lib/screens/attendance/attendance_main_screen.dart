
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_cubit.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_state.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_cubit.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_state.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_cubit.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_state.dart';
import 'package:nguru/models/attendance_bar_chart_model.dart';
import 'package:nguru/models/cumulative_attendance_model.dart';
import 'package:nguru/models/particular_month_attendance_model.dart';
import 'package:nguru/screens/attendance/attendence_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendanceMainScreen extends StatefulWidget {
    final DateTime startDate;
  final DateTime endDate;
  const AttendanceMainScreen({super.key, required this.startDate, required this.endDate});

  @override
  State<AttendanceMainScreen> createState() => _AttendanceMainScreenState();
}

class _AttendanceMainScreenState extends State<AttendanceMainScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime _focusedDay = DateTime.now();

  int? attendanceBarCharMonth;
  List monthMap = [
    "",
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
    "Dec",
  ];
  AttendanceCumulativeModel? attendanceCumulativeModel;

  @override
  void initState() {
     log("the start and end dates are: ${widget.startDate} ${widget.endDate}");
    super.initState();
    context
                    .read<CumulativeAttendanceCubit>()
                    .getCumulativeAttendance();
    context.read<AttendanceBarChartCubit>().getAttendanceBarChart();
    context
        .read<ParticularMonthAttendanceCubit>()
        .getParticularMonthAttendance(_focusedDay.month);
    attendanceBarCharMonth = _focusedDay.month;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
              padding: const EdgeInsets.all(padding18),
              child: Column(
                children: [
                  10.heightBox,
                  dashboardAppBar(),
                  10.heightBox,
                  CustomSearchBar(controller: _searchController),
                  10.heightBox,
                  screenTitleHeader("Attendance",
                      onPressed: () => Navigator.pop(context)),
                      20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    height: screenHeight * 0.067,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: MyColors.white,
                      border: Border.all(
                        color: Colors.grey
                            .withOpacity(0.3), // This color is not visible
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total working days",
                            style: FontUtil.customStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: MyColors.boldTextColor),
                          ),
                          BlocConsumer<CumulativeAttendanceCubit,
                                  CumulativeAttendanceState>(
                              listener: (context, state) {
                            // if (state is CumulativeAttendanceSuccessState) {
                            //   attendanceCumulativeModel = state
                            //       .attendanceCumulativeModel!
                            //       .where((item) =>
                            //           item.monthName ==
                            //           monthMap[currentMonthNumber ??
                            //               _focusedDay.month ??
                            //               1])
                            //       .first;
                            // }
                          }, builder: (context, state) {
                            if (state is CumulativeAttendanceLoadingState) {
                              return const Center(
                                child: SizedBox.shrink(),
                              );
                            } else if (state
                                is CumulativeAttendanceSuccessState) {
                              int totalWorkingDays = 0;

                              for (int i = 0;
                                  i < state.attendanceCumulativeModel!.length;
                                  i++) {
                                totalWorkingDays = totalWorkingDays +
                                    int.parse(state
                                        .attendanceCumulativeModel![i]
                                        .workingDays
                                        .toString());
                              }
                              return Text(
                                "$totalWorkingDays",
                                style: FontUtil.customStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor),
                              );
                            } else if (state
                                is CumulativeAttendanceErrorState) {
                              return Center(
                                child: Text(
                                  state.message,
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
                        ]),
                  ),
                  15.heightBox,
                  _buildMonthSelector(),

                  BlocConsumer<CumulativeAttendanceCubit,
                      CumulativeAttendanceState>(listener: (context, state) {
                    if (state is CumulativeAttendanceSuccessState) {
                      try{
                        log("from listner: ${_focusedDay.month}");

                          attendanceCumulativeModel = state
                          .attendanceCumulativeModel!
                          .where((item) =>
                              item.monthName ==
                              monthMap[_focusedDay.month])
                          .first;

                      }
                      catch(e){
                          log("errorrr $e ");
                      }
                    
                    }
                    
                  }, builder: (context, state) {
                    if (state is CumulativeAttendanceLoadingState) {
                       return attendanceStatusTopGraph(
                          context, null);
                    } else if (state is CumulativeAttendanceSuccessState) {

                      try{

                         attendanceCumulativeModel =  state
                          .attendanceCumulativeModel!
                          .where((item) =>
                              item.monthName ==
                              monthMap[_focusedDay.month])
                          .first ;

                      }
                      catch(e){
                        attendanceCumulativeModel=null;

                      }
                      
                     
                      return attendanceStatusTopGraph(
                          context, attendanceCumulativeModel);
                    } else if (state is CumulativeAttendanceErrorState) {
                      log("errrorrrrrrrrr");
                      return Center(
                        child: Text(
                          state.message,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Total Present Days",
                        style: FontUtil.customStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.boldTextColor),
                      )
                    ],
                  ),
                  10.heightBox,
                  // GestureDetector(
                  //     onTap: () => Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AttendenceScreen())),
                  //     child: attendanceVerticalBarChartGraph(context))
                  attendanceVerticalBarChartGraph(context, _focusedDay,widget.startDate,widget.endDate),
                ],
              )),
        ],
      ),
    );
  }

    Widget _buildMonthSelector() {
    List<String> months = [];
    DateTime current = widget.startDate;
    while (current.isBefore(widget.endDate) || current.isAtSameMomentAs(widget.endDate)) {
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
            widget.startDate.year,
            widget.startDate.month + monthIndex,
          );
          bool isSelected = _focusedDay.year == monthDate.year &&
              _focusedDay.month == monthDate.month;
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
                });
                context
                    .read<CumulativeAttendanceCubit>()
                    .getCumulativeAttendance();
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
}

Widget attendanceStatusTopGraph(BuildContext context,
    AttendanceCumulativeModel? attendanceCumulativeModel) {
      log("cumulative data are ${attendanceCumulativeModel?.hoidays} ${attendanceCumulativeModel?.presentDay} ${attendanceCumulativeModel?.leaveDay}");
  return SizedBox(
    height: MediaQuery.sizeOf(context).height * 0.23,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 70,
                  height: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.greenShade_2.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.circle,
                        color: MyColors.greenShade_2.withOpacity(0.8),
                        size: 10,
                      ),
                      Text(
                        "Present",
                        style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.greenShade_2.withOpacity(0.5)),
                      ),
                    ],
                  )),
              Container(
                  width: 70,
                  height: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.redShade_1.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.circle,
                        color: MyColors.redShade_1.withOpacity(0.8),
                        size: 10,
                      ),
                      Text(
                        "Absent",
                        style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.redShade_1.withOpacity(0.5)),
                      ),
                    ],
                  )),
              Container(
                  width: 70,
                  height: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.appColor1.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.circle,
                        color: MyColors.appColor1.withOpacity(0.8),
                        size: 10,
                      ),
                      Text(
                        "Holiday",
                        style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.appColor1.withOpacity(0.5)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        10.widthBox,
        Transform.rotate(
          angle: 90 * 3.1415927 / 180,
          child: SizedBox(
            width: 180,
            height: 260,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                maxY: 30, // Maximum value on the x-axis
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 60,
                      showTitles: true,
                      interval: 100,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(value.toInt() == 0
                                  ? "${attendanceCumulativeModel?.presentDay ?? 0} Days"
                                  : value.toInt() == 1
                                      ? "${attendanceCumulativeModel?.absentDay ?? 0} Days"
                                      : "${attendanceCumulativeModel?.hoidays ?? 0} Days"),
                            ));
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Transform.rotate(
                                angle: 270 * 3.1415927 / 180,
                                child: Text("${value.toInt()}"));
                          })),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 40,
                      showTitles: false,
                      interval: 100,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        switch (value) {
                          case 0:
                            return Transform.rotate(
                                angle: 270 * 3.1415927 / 180,
                                child: Container(
                                    width: 70,
                                    height: 8,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.greenShade_2
                                          .withOpacity(0.1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: MyColors.greenShade_2
                                              .withOpacity(0.8),
                                          size: 10,
                                        ),
                                        Text(
                                          "Preset",
                                          style: FontUtil.customStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textColor: MyColors.greenShade_2
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    )));
                          case 1:
                            return Transform.rotate(
                                angle: 270 * 3.1415927 / 180,
                                child: Container(
                                    width: 70,
                                    height: 8,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          MyColors.appColor1.withOpacity(0.1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: MyColors.appColor1
                                              .withOpacity(0.8),
                                          size: 10,
                                        ),
                                        Text(
                                          "Absent",
                                          style: FontUtil.customStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textColor: MyColors.appColor1
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    )));
                          case 2:
                            return Transform.rotate(
                                angle: 270 * 3.1415927 / 180,
                                child: Container(
                                    width: 70,
                                    height: 8,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          MyColors.appColor1.withOpacity(0.1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: MyColors.appColor1
                                              .withOpacity(0.8),
                                          size: 10,
                                        ),
                                        Text(
                                          "Holiday",
                                          style: FontUtil.customStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textColor: MyColors.appColor1
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    )));

                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),

                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        color: MyColors.greenShade_2,
                        toY: double.parse(
                            attendanceCumulativeModel?.presentDay ??
                                "0.0"), // Position on the y-axis (0-based index)
                        width: 4,
                        // rodStackItems: [
                        //   BarChartRodStackItem(0, 15, Colors.green),
                        // ],
                        borderRadius: BorderRadius.circular(4),
                        // backDrawRodData: BackgroundBarChartRodData(
                        //   show: true,
                        //   toY: 30, // Maximum value for the background rod
                        //   color: Colors.green.withOpacity(0.1),
                        // ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        color: MyColors.redShade_1,
                        toY: double.parse(
                            attendanceCumulativeModel?.absentDay ??
                                "0.0"), // Position on the y-axis (0-based index)
                        width: 4,
                        // rodStackItems: [
                        //   BarChartRodStackItem(0, 5, Colors.red),
                        // ],
                        borderRadius: BorderRadius.circular(4),
                        // backDrawRodData: BackgroundBarChartRodData(
                        //   show: true,
                        //   toY: 30, // Maximum value for the background rod
                        //   color: Colors.red.withOpacity(0.1),
                        // ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        color: MyColors.appColor1,
                        toY: double.parse(attendanceCumulativeModel?.hoidays ??
                            "0.0"), // Position on the y-axis (0-based index)
                        width: 4,
                        // rodStackItems: [
                        //   BarChartRodStackItem(0, 2, Colors.blue),
                        // ],
                        borderRadius: BorderRadius.circular(4),
                        // backDrawRodData: BackgroundBarChartRodData(
                        //   show: true,
                        //   toY: 30, // Maximum value for the background rod
                        //   color: Colors.blue.withOpacity(0.1),
                        // ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget attendanceVerticalBarChartGraph(
    BuildContext context, DateTime? _focusedDay, DateTime startDate, DateTime endDate) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: 700,
      height: MediaQuery.sizeOf(context).height * 0.35,
      child: BlocConsumer<CumulativeAttendanceCubit, CumulativeAttendanceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CumulativeAttendanceLoadingState) {
              return BarChart(
                BarChartData(
                    maxY: 100,
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchCallback: (event, response) {
                        if (response != null &&
                            response.spot != null &&
                            event is FlTapUpEvent) {
                          
                        }
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 30,
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun',
                                  'Jul',
                                  'Aug',
                                  'Sep',
                                  'Oct',
                                  'Nov',
                                  'Dec'
                                ][value.toInt()],
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor
                                        .withOpacity(0.5)),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 40,
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                "${value.toInt()} %",
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor
                                        .withOpacity(0.5)),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: true),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                  //  barGroups: barChartGroupData(state.attendanceBarChart)
                    ),
              );
            } else if (state is CumulativeAttendanceSuccessState) {
              return BarChart(
                BarChartData(
                    maxY: 100,
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchCallback: (event, response) {
                        if (response != null &&
                            response.spot != null &&
                            event is FlTapUpEvent) {
                          final tappedIndex =
                              response.spot!.touchedBarGroupIndex;
                          final tappedBarData =
                              state.attendanceCumulativeModel?[tappedIndex].monthName;
                                // Map of month names to their corresponding indices
                               final Map<String, int> monthIndices = {
                                 "Jan": 1,
                                 "Feb": 2,
                                 "Mar": 3,
                                 "Apr": 4,
                                 "May": 5,
                                 "Jun": 6,
                                 "Jul": 7,
                                 "Aug": 8,
                                 "Sep": 9,
                                 "Oct": 10,
                                 "Nov": 11,
                                 "Dec": 12,
                               };
                              
                               // Get the month index from the map
                               final int? monthIndex = monthIndices[tappedBarData];

                          context
                              .read<ParticularMonthAttendanceCubit>()
                              .getParticularMonthAttendance(
                                  monthIndex ?? _focusedDay!.month)
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AttendenceScreen(
                                        month: monthIndex,
                                        startDate: startDate,
                                        endDate: endDate,
                                      ),
                                    ),
                                  ));
                        }
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 30,
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun',
                                  'Jul',
                                  'Aug',
                                  'Sep',
                                  'Oct',
                                  'Nov',
                                  'Dec'
                                ][value.toInt()],
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor
                                        .withOpacity(0.5)),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 40,
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                "${value.toInt()} %",
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor
                                        .withOpacity(0.5)),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: true),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    barGroups: barChartGroupData(state.attendanceCumulativeModel?? [])),
              );
            } else if (state is CumulativeAttendanceErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            } else {
              return Center(
                child: Text(
                  MyStrings.error,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            }
          }),
    ),
  );
}

List<BarChartGroupData> barChartGroupData(
   List<AttendanceCumulativeModel> attendanceCumulativeModel) {
  List<BarChartGroupData> barChartGroupDataList = [];
    final Map<String, int> monthIndices = {
    "Jan": 1,
    "Feb": 2,
    "Mar": 3,
    "Apr": 4,
    "May": 5,
    "Jun": 6,
    "Jul": 7,
    "Aug": 8,
    "Sep": 9,
    "Oct": 10,
    "Nov": 11,
    "Dec": 12,
  };
  

  for (int i = 0; i < attendanceCumulativeModel.length; i++) {
    barChartGroupDataList.add(BarChartGroupData(
      x: monthIndices[attendanceCumulativeModel[i].monthName!]! - 1,
      barRods: [
        BarChartRodData(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            gradient: MyColors.buttonColors,
            width: 39,
            toY: double.parse(attendanceCumulativeModel[i].monthWisePercentage!)),
      ],
    ));
  }

  return barChartGroupDataList;
}
