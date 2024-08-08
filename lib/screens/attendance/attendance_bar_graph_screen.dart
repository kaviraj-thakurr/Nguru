import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

class BarChartExample extends StatelessWidget {
  const BarChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child:
          Container(
            width: double.infinity,
            height: 300,
            child: BarChart(
              BarChartData(
                maxY: 100,
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(

                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
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
                            style: style,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                          gradient: MyColors.buttonColors, width: 30, toY: 85),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData( borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                          gradient: MyColors.buttonColors, width: 30, toY: 85),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData( borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                          gradient: MyColors.buttonColors, width: 30, toY: 85),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData( borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                          gradient: MyColors.buttonColors, width: 30, toY: 0),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData( borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                          gradient: MyColors.buttonColors, width: 30, toY: 12),
                    ],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                  BarChartGroupData(
                    x: 6,
                    barRods: [
                      BarChartRodData( borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ), gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                  BarChartGroupData(
                    x: 7,
                    barRods: [
                      BarChartRodData(borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ), gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                  BarChartGroupData(
                    x: 8,
                    barRods: [
                      BarChartRodData(borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ), gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                   BarChartGroupData(
                    x: 9,
                    barRods: [
                      BarChartRodData(borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ), gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                   BarChartGroupData(
                    x: 10,
                    barRods: [
                      BarChartRodData(borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ), gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                   BarChartGroupData(
                    x: 11,
                    barRods: [
                      BarChartRodData(borderRadius:BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ), gradient: MyColors.buttonColors, width: 30, toY: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class HorizontalBarChartExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Horizontal Bar Chart Example")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Transform.rotate(
//             angle: 90 * 3.1415927 / 180,
//             child:

//             Container(
//               width:200,
//               height: 350,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceEvenly,
//                   maxY: 30, // Maximum value on the x-axis
//                   barTouchData: BarTouchData(enabled: false),
//                   titlesData: const FlTitlesData(
//                     // leftTitles: AxisTitles(
//                     //   sideTitles: SideTitles(
//                     //     showTitles: true,
//                     //     getTitlesWidget: (double value, TitleMeta meta) {
//                     //       final titles = ['Present', 'Absent', 'Holiday'];
//                     //       if (value < 0 || value > titles.length - 1) {
//                     //         return SizedBox.shrink();
//                     //       }
//                     //       return Padding(
//                     //         padding: const EdgeInsets.only(right: 8.0),
//                     //         child: Row(
//                     //           children: [
//                     //             Container(
//                     //               width: 10,
//                     //               height: 10,
//                     //               decoration: BoxDecoration(
//                     //                 color: value == 0
//                     //                     ? Colors.green
//                     //                     : value == 1
//                     //                         ? Colors.red
//                     //                         : Colors.blue,
//                     //                 shape: BoxShape.circle,
//                     //               ),
//                     //             ),
//                     //             SizedBox(width: 8),
//                     //             Text(
//                     //               titles[value.toInt()],
//                     //               style: TextStyle(color: Colors.black, fontSize: 14),
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       );
//                     //     },
//                     //     reservedSize: 100,
//                     //   ),
//                     // ),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                    // bottomTitles: AxisTitles(sideTitles: SideTitles(getTitlesWidget: )),
//                    // rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     // bottomTitles: AxisTitles(
//                     //   sideTitles: SideTitles(
//                     //     showTitles: true,
//                     //     // getTitlesWidget: (double value, TitleMeta meta) {
//                     //     //   return Text(
//                     //     //     '${value.toInt()} days',
//                     //     //     style: TextStyle(color: Colors.black, fontSize: 14),
//                     //     //   );
//                     //     // },
//                     //   ),
//                     // ),
//                   ),
//                 //  borderData: FlBorderData(show: false),
//                   gridData: FlGridData(show: false),
//                   barGroups: [
//                     BarChartGroupData(
//                       x: 0,
//                       barRods: [
//                         BarChartRodData(
//                           toY: 3, // Position on the y-axis (0-based index)
//                           width: 8,
//                           rodStackItems: [
//                             BarChartRodStackItem(0, 15, Colors.green),
//                           ],
//                           borderRadius: BorderRadius.circular(4),
//                           backDrawRodData: BackgroundBarChartRodData(
//                             show: true,
//                             toY: 20, // Maximum value for the background rod
//                             color: Colors.green.withOpacity(0.1),
//                           ),
//                         ),
//                       ],
//                     ),
//                     BarChartGroupData(
//                       x: 1,
//                       barRods: [
//                         BarChartRodData(
//                           toY: 1.6, // Position on the y-axis (0-based index)
//                           width: 8,
//                           rodStackItems: [
//                             BarChartRodStackItem(0, 5, Colors.red),
//                           ],
//                           borderRadius: BorderRadius.circular(4),
//                           backDrawRodData: BackgroundBarChartRodData(
//                             show: true,
//                             toY: 20, // Maximum value for the background rod
//                             color: Colors.red.withOpacity(0.1),
//                           ),
//                         ),
//                       ],
//                     ),
//                     BarChartGroupData(
//                       x: 2,
//                       barRods: [
//                         BarChartRodData(
//                           toY: 2.6, // Position on the y-axis (0-based index)
//                           width: 8,
//                           rodStackItems: [
//                             BarChartRodStackItem(0, 2, Colors.blue),
//                           ],
//                           borderRadius: BorderRadius.circular(4),
//                           backDrawRodData: BackgroundBarChartRodData(
//                             show: true,
//                             toY: 20, // Maximum value for the background rod
//                             color: Colors.blue.withOpacity(0.1),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class HorizontalBarChartExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Horizontal Bar Chart Example")),
//       body: attendanceStatusTopGraph(),
//     );
//   }
// }

class CircularChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   '48900\nPaid Fee',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // SizedBox(height: 20),
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.greenAccent,
                  value: 45,
                  title: '45%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.orangeAccent,
                  value: 35,
                  title: '35%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.deepPurpleAccent,
                  value: 20,
                  title: '20%',
                  radius: 60,
                  titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 60,
            ),
          ),
        ],
      ),
    );
  }
}

Widget attendanceStatusTopGraph() {
  return Center(
    child: Transform.rotate(
      angle: 90 * 3.1415927 / 180,
      child: Container(
        width: 230,
        height: 350,
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
                    switch (value) {
                      case 0:
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("${value.toInt()} Days"),
                            ));
                      case 1:
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("${value.toInt()} Days"),
                            ));
                      case 2:
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("${value.toInt()} Days"),
                            ));

                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Text("${value.toInt()}"));
                      })),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 60,
                  showTitles: true,
                  interval: 100,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    switch (value) {
                      case 0:
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("Preset"),
                            ));
                      case 1:
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("Absent"),
                            ));
                      case 2:
                        return Transform.rotate(
                            angle: 270 * 3.1415927 / 180,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("Holiday"),
                            ));

                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 3, // Position on the y-axis (0-based index)
                    width: 8,
                    rodStackItems: [
                      BarChartRodStackItem(0, 15, Colors.green),
                    ],
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 20, // Maximum value for the background rod
                      color: Colors.green.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 1.6, // Position on the y-axis (0-based index)
                    width: 8,
                    rodStackItems: [
                      BarChartRodStackItem(0, 5, Colors.red),
                    ],
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 20, // Maximum value for the background rod
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 2.6, // Position on the y-axis (0-based index)
                    width: 8,
                    rodStackItems: [
                      BarChartRodStackItem(0, 2, Colors.blue),
                    ],
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 20, // Maximum value for the background rod
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
