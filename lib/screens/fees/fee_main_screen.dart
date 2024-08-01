import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class FeesMainScreen extends StatefulWidget {
  const FeesMainScreen({super.key});

  @override
  State<FeesMainScreen> createState() => _FeesMainScreenState();
}

class _FeesMainScreenState extends State<FeesMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 230, height: 230, child: doughnutChart(context)),
              SizedBox(
                height: 100,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    circularChartTags(
                        context,
                        "Total Fee",
                        const LinearGradient(
                            colors: [MyColors.arc_1, MyColors.arc_2])),
                    10.heightBox,
                    circularChartTags(
                        context,
                        "Due Fee",
                        const LinearGradient(
                            colors: [MyColors.arc_3, MyColors.arc_4])),
                    10.heightBox,
                    circularChartTags(
                        context,
                        "Paid Fee",
                        const LinearGradient(
                            colors: [MyColors.arc_5, MyColors.arc_6])),
                  
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customFeeCard(context, "₹1,95,600", "Total Fee",
                  MyColors.blueShade_3, MyColors.blueShade_3.withOpacity(0.7)),
              customFeeCard(
                  context,
                  "₹1,46,600",
                  "Total Due",
                  MyColors.yellowShade_3,
                  MyColors.yellowShade_3.withOpacity(0.7)),
            ],
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Fee History",
                textAlign: TextAlign.start,
                style: FontUtil.customStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
            ],
          ),
            Container(
                     width: double.infinity,
                     height: 100,
                     decoration: BoxDecoration(
                     color: MyColors.greyShade_3.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(20)),
                     child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                                  "November",
                                  style: FontUtil.customStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.w500,
                                   textColor: MyColors.boldTextColor),
                                  ),
                            Text(
                                  "24k",
                                  style: FontUtil.customStyle(
                                   fontSize: 36,
                                   fontWeight: FontWeight.w500,
                                   textColor: MyColors.greenShade_2),
                                  ),
                                  
                                  ShaderMask(
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
                          "Receipt",
                          style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w500,
                            textColor: MyColors.blueShade,
                          ),
                        ),
                      ),
                    )


                          
                        ],),
                        5.heightBox,
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text(
                                  "November",
                                  style: FontUtil.customStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.w500,
                                   textColor: MyColors.greenShade_2),
                                  ),
                            Text(
                                  "Fee detail",
                                  style: FontUtil.customStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.w500,
                                   textColor: MyColors.boldTextColor),
                                  ),
                                  Text(
                                  "Payment Status",
                                  style: FontUtil.customStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.w500,
                                   textColor: MyColors.boldTextColor),
                                  ),


                          
                        ],),

                      ]),
                    )
        ],
      ),
    );
  }
}

Widget customFeeCard(BuildContext context, String value, String title,
    Color valueColor, Color titleColor) {
  return Container(
    width: 180,
    height: 180,
    decoration: BoxDecoration(
        color: valueColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: EdgeInsets.all(14),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: FontUtil.customStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  textColor: valueColor),
            ),
            Text(
              title,
              style: FontUtil.customStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  textColor: titleColor),
            )
          ]),
    ),
  );
}

Widget circularChartTags(
    BuildContext context, String title, LinearGradient gradient) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(gradient: gradient),
      ),
      5.widthBox,
      Text(
        title,
        style: FontUtil.customStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: MyColors.textcolors),
      )
    ],
  );
}

Widget doughnutChart(BuildContext context) {
  final List<ChartData> chartData = [
    ChartData('Category B', 20, [MyColors.arc_4, MyColors.arc_3]),
    ChartData('Category C', 20, [MyColors.arc_6, MyColors.arc_5]),
    ChartData('Category A', 20, [MyColors.arc_2, MyColors.arc_1]),
  ];

  final double total = chartData.map((e) => e.y).reduce((a, b) => a + b);

  return Center(
    child: Stack(
      children: [
        Center(
            child: Image.asset(
                "assets/images/circular_graph/circular_gradient.png")),
        Center(
            child: Image.asset(
          "assets/images/circular_graph/circular_arc.png",
          scale: 0.9,
        )),
        SfCircularChart(
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointShaderMapper:
                  (dynamic data, int index, Color color, Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: data.gradientColors,
                  stops: const [0.0, 1],
                ).createShader(rect);
              },
              dataLabelMapper: (ChartData data, _) {
                final percentage = (data.y / total) * 100;
                return '${percentage.toStringAsFixed(1)}%';
              },
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(fontSize: 14, color: Colors.black),
              ),
              cornerStyle: CornerStyle.bothCurve,
              radius: '80%',
              innerRadius: '70%',
              explode: true,
              explodeOffset: '3%',
              explodeAll: true,
            )
          ],
        ),
      ],
    ),
  );
}

class ChartData {
  ChartData(this.x, this.y, this.gradientColors);
  final String x;
  final double y;
  final List<Color> gradientColors;
}
