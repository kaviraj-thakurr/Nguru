import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/custom_widgets/gradient_rounded_border_button.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/fee/fee_list_cubit.dart';
import 'package:nguru/logic/fee/fee_list_state.dart';
import 'package:nguru/models/get_fee_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

class FeesMainScreen extends StatefulWidget {
  const FeesMainScreen({super.key});

  @override
  State<FeesMainScreen> createState() => _FeesMainScreenState();
}

class _FeesMainScreenState extends State<FeesMainScreen> {
  final TextEditingController _searchController = TextEditingController();
  int totalFee = 0;
  int paidFee = 0;

  @override
  void initState() {
    super.initState();
    context.read<FeeListCubit>().getFeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          BlocConsumer<FeeListCubit, FeeListState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FeeListLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is FeeListSuccessState) {
                  totalFee = 0;
                  paidFee = 0;
                  for (int i = 0; i < state.feeListModel.length; i++) {
                    totalFee =
                        totalFee + int.parse(state.feeListModel[i].amount!);
                    paidFee =
                        paidFee + int.parse(state.feeListModel[i].paidAmount!);
                  }
                  log("$totalFee $paidFee");

                  return Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1,
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomAppBar(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                CustomSearchBar(controller: _searchController),
                          ),
                          screenTitleHeader("Fees Summery",
                              onPressed: () => Navigator.pop(context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 280,
                                  height: 230,
                                  child: doughnutChart(
                                      context, totalFee, paidFee)),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      circularChartTags(
                                          context,
                                          MyStrings.totalFee,
                                          const LinearGradient(colors: [
                                            MyColors.arc_3,
                                            MyColors.arc_4
                                          ])),
                                      10.heightBox,
                                      circularChartTags(
                                          context,
                                          MyStrings.dueFee,
                                          const LinearGradient(colors: [
                                            MyColors.arc_5,
                                            MyColors.arc_6
                                          ])),
                                      10.heightBox,
                                      circularChartTags(
                                          context,
                                          MyStrings.paidFee,
                                          const LinearGradient(colors: [
                                            MyColors.arc_1,
                                            MyColors.arc_2
                                          ])),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          15.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customFeeCard(
                                  context,
                                  "₹$totalFee",
                                  MyStrings.totalFee,
                                  MyColors.blueShade_3,
                                  MyColors.blueShade_3.withOpacity(0.7)),
                              customFeeCard(
                                  context,
                                  "₹${totalFee - paidFee}",
                                  MyStrings.dueFee,
                                  MyColors.yellowShade_3,
                                  MyColors.yellowShade_3.withOpacity(0.7)),
                            ],
                          ),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                MyStrings.feeHistory,
                                textAlign: TextAlign.start,
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor),
                              ),
                            ],
                          ),
                          15.heightBox,
                          customFeeHistoryCard(context,
                              totalFeeModel: state.feeListModel[0]),
                          10.heightBox,
                          customFeeHistoryCard(context,
                              totalFeeModel: state.feeListModel[1])
                        ],
                      ),
                    ),
                  );
                } else if (state is FeeListErrorState) {
                  return Text(
                    MyStrings.undefinedState,
                    style: FontUtil.customStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.boldTextColor),
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
        ],
      ),
    );
  }
}

Widget customFeeHistoryCard(BuildContext context, {FeeList? totalFeeModel}) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.13,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: MyColors.greyShade_3.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('MMMM').format(totalFeeModel!.date!),
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
              Text(
                totalFeeModel.type == 1
                    ? totalFeeModel.paidAmount!
                    : totalFeeModel.amount!,
                style: FontUtil.customStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    textColor: totalFeeModel.type == 1
                        ? MyColors.greenShade_2
                        : MyColors.yellowShade_4),
              ),
              gradientRoundedBorderButton(
                  title: totalFeeModel.type == 1 ? MyStrings.receipt : MyStrings.pay,
                  fontColor: MyColors.blueShade_3)
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: totalFeeModel.type == 1
                  ? MyColors.blueGreenGradient
                  : MyColors.blueYellowGradient,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${DateFormat('MMMM').format(totalFeeModel.date!)} ${totalFeeModel.date!.day}, ${totalFeeModel.date!.year} ",
                style: FontUtil.customStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.greenShade_2),
              ),
              60.widthBox,
              Text(
                MyStrings.feeDetail,
                style: FontUtil.customStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
              30.widthBox,
              Text(
                MyStrings.paymentStatus,
                style: FontUtil.customStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
            ],
          ),
        ]),
  );
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
      padding: const EdgeInsets.all(14),
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
                  fontSize: 15,
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

Widget doughnutChart(BuildContext context, int totalFee, int paidFee) {
  final List<ChartData> chartData = [
    ChartData(
        'Category B', totalFee.toDouble(), [MyColors.arc_4, MyColors.arc_3]),
    ChartData('Category C', (totalFee - paidFee).toDouble(),
        [MyColors.arc_6, MyColors.arc_5]),
    ChartData(
        'Category A', paidFee.toDouble(), [MyColors.arc_2, MyColors.arc_1]),
  ];

  final double total = chartData.map((e) => e.y).reduce((a, b) => a + b);

  return Center(
    child: Stack(
      children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$paidFee\n',
                  style: const TextStyle(
                    color: MyColors.boldTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: MyStrings.paidFee,
                  style: TextStyle(
                      color: MyColors.boldTextColor.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        Center(
            child: Image.asset(
                MyAssets.circularGradient)),
        Center(
            child: Image.asset(
          MyAssets.circularArc,
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
