import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_cubit.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_state.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_cubit.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_state.dart';
import 'package:nguru/models/attendance_bar_chart_model.dart';
import 'package:nguru/models/particular_month_attendance_model.dart';
import 'package:nguru/screens/attendance/attendence_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class BarChartExample extends StatefulWidget {
  const BarChartExample({super.key});

  @override
  State<BarChartExample> createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  final TextEditingController _searchController = TextEditingController();
  DateTime _focusedDay = DateTime.now();




 @override
  void initState() {
    super.initState();
    context.read<AttendanceBarChartCubit>().getAttendanceBarChart();
    context.read<ParticularMonthAttendanceCubit>().getParticularMonthAttendance(_focusedDay.month);
  }





  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomAppBar(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchBar(controller: _searchController),
                  ),
                  screenTitleHeader("Attendance",
                      onPressed: ()=> Navigator.pop(context)),
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
                          Text(
                            "220",
                            style: FontUtil.customStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                textColor: MyColors.boldTextColor),
                          ),
                        ]),
                  ),
                  15.heightBox,
                  _buildMonthSelector(),
                  BlocConsumer<ParticularMonthAttendanceCubit,ParticularMonthAttendanceState>(
                    listener: (context, state) {},
                    builder: (context,state) {
                      if(state is ParticularMonthAttendanceLoadingState)
                      {
                     return  const Center(child:  CircularProgressIndicator(),);
                      }

                     else if(state is ParticularMonthAttendanceSuccessState){
                        return attendanceStatusTopGraph(state.particularMonthAttendanceModel);
                      }
                      else if(state  is ParticularMonthAttendanceErrorState)
                      {
                        return  Center( child:  Text(state.message, style:  FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),);
                      }
                      else {
                      return   Center(child:  Text(MyStrings.undefinedState, style:  FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),);
                      }
                    }
                  ),
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
                  GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendenceScreen())),
                    child: attendanceVerticalBarChartGraph())
                ],
              )),
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
          int selectdIndex=0;
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
                context.read<ParticularMonthAttendanceCubit>().getParticularMonthAttendance(_focusedDay.month);
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
}

Widget attendanceStatusTopGraph(ParticularMonthAttendanceModel particularMonthAttendanceModel) {
  return SizedBox(
    height: 200,
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
                              child:
                               Text(
                               value.toInt() == 0 ?
                                "${particularMonthAttendanceModel.presentCount} Days" 
                                : value.toInt() == 1 ? "${particularMonthAttendanceModel.absentCount} Days" 
                                : "${particularMonthAttendanceModel.holidayCount} Days"
                                ),
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
                        toY: double.parse(particularMonthAttendanceModel.presentCount.toString()), // Position on the y-axis (0-based index)
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
                        toY: double.parse(particularMonthAttendanceModel.absentCount.toString()), // Position on the y-axis (0-based index)
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
                        toY: double.parse(particularMonthAttendanceModel.holidayCount.toString()), // Position on the y-axis (0-based index)
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

Widget attendanceVerticalBarChartGraph() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: 700,
      height: 330,
      child: BlocConsumer<AttendanceBarChartCubit,AttendanceBarChartState>(
        listener: (context, state) {

        },
        builder: (context,state) {

          if(state is AttendanceBarChartLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }

        else  if(state is AttendanceBarChartSuccessState){

          return BarChart(
            BarChartData(
              maxY: 100,
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: false),
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
                              textColor: MyColors.boldTextColor.withOpacity(0.5)),
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
                              textColor: MyColors.boldTextColor.withOpacity(0.5)),
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
              barGroups: barChartGroupData(state.attendanceBarChart)
            ),
          );
          }
         else if(state is AttendanceBarChartErrorState){
            return Center( 
              child:Text(state.message,
              style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),);
          }
          else {
            return  Center( 
              child:Text(MyStrings.error,
              style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),);
         }

        }
      ),
    ),
  );
}

List<BarChartGroupData> barChartGroupData(List<AttendanceBarChart> attendanceBarChart){

  List<BarChartGroupData> barChartGroupDataList = [];
  for(int i=0;i<attendanceBarChart.length;i++){
                  barChartGroupDataList.add(
                    BarChartGroupData(
                  x: attendanceBarChart[i].month! -1,
                  barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        gradient: MyColors.buttonColors,
                        width: 39,
                        toY: double.parse(attendanceBarChart[i].attendancePercent!)),
                  ],
                )
                    );
                }
  
  return barChartGroupDataList;
}