import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_progress_bar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/discipline/descipline_cubit.dart';
import 'package:nguru/logic/discipline/descipline_state.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/screens/circular_calendar.dart';
import 'package:nguru/screens/discipline_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/app_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class DisciplineScreen extends StatefulWidget {
  const DisciplineScreen({super.key});

  @override
  State<DisciplineScreen> createState() => _DisciplineScreenState();
}

class _DisciplineScreenState extends State<DisciplineScreen> {
  TextEditingController searchController = TextEditingController();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<DisciplineCubit>().getDiscipline(type: 1).then((value) =>
        context
            .read<DisciplineCubit>()
            .filterDisciplineListByDate(focusedDay, true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                dashboardAppBar(),

                screenTitleHeader("Discipline"),

                59.heightBox,

                disciplineCalendar(),
                15.heightBox,
                BlocConsumer<DisciplineCubit, DisciplineState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is DisciplineLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DisciplineSuccessState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${MyStrings.positivePoints}: 00.00",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.monthNameColor),
                            ),
                            Text(
                              "${MyStrings.negativePoints}: 00.00",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.monthNameColor),
                            ),
                          ],
                        );
                      } else if (state is DisciplineFilteredState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${MyStrings.positivePoints}: 00.00",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.monthNameColor),
                            ),
                            Text(
                              "${MyStrings.negativePoints}: 00.00",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.monthNameColor),
                            ),
                          ],
                        );
                      } else if (state is DisciplineErrorState) {
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

                BlocConsumer<DisciplineCubit, DisciplineState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is DisciplineLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DisciplineSuccessState) {
                        return Flexible(
                          child: PageView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) => ListView.builder(
                              itemCount: state.disciplineList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    cardDesign(
                                        context, state.disciplineList[index]),
                                    10.heightBox
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      } else if (state is DisciplineFilteredState) {
                        return state.filteredList.isEmpty
                            ? SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.474,
                                child: Center(
                                  child: Text(
                                   MyStrings.noData,
                                    style: FontUtil.customStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textColor: MyColors.boldTextColor),
                                  ),
                                ),
                              )
                            : Flexible(
                                child: PageView.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index) =>
                                      ListView.builder(
                                    itemCount: state.filteredList.length,
                                    itemBuilder: (context, index) {
                                      state.filteredList.isEmpty
                                          ? log(
                                              "logg ${state.filteredList.length}")
                                          : null;
                                      return state.filteredList.isEmpty
                                          ? const Center(
                                              child: Text(MyStrings.noData),
                                            )
                                          : Column(
                                              children: [
                                                cardDesign(context,
                                                    state.filteredList[index]),
                                                10.heightBox
                                              ],
                                            );
                                    },
                                  ),
                                ),
                              );
                      } else if (state is DisciplineErrorState) {
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     IconButton(
                //         onPressed: () {},
                //         icon: SvgPicture.asset(MyAssets.back_arrow)),
                //     IconButton(
                //         onPressed: () {},
                //         icon: SvgPicture.asset(MyAssets.front_arrow)),
                //   ],
                // ),
                // Text('asdasdas')
                // const CustomProgressBar(
                //   progress: 0.3,
                //   dotCount: 0,
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget cardDesign(BuildContext context, DisciplineList discipline) {
  return Container(
    height: MediaQuery.sizeOf(context).height * 0.15,
    // width: MediaQuery.sizeOf(context).width * 0.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: discipline.cardtype == "red"
          ? MyColors.redShade_1.withOpacity(0.8)
          : discipline.cardtype == "yellow"
              ? MyColors.yellowShade_1.withOpacity(0.8)
              : MyColors.greyShade_3.withOpacity(0.2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.06,
                height: MediaQuery.sizeOf(context).height * 0.04,
                decoration: BoxDecoration(
                    color: discipline.cardtype == "red"
                        ? MyColors.redShade_1
                        : discipline.cardtype == "yellow"
                            ? MyColors.yellowShade_1
                            : MyColors.white,
                    borderRadius: BorderRadius.circular(3)),
              ),
              10.widthBox,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat("MMM dd, yyyy").format(DateFormat("dd/MM/yyyy")
                          .parse(discipline.actionDate!)),
                      style: FontUtil.customStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.boldTextColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${MyStrings.disciplineGroup}: ",
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor),
                              ),
                              TextSpan(
                                text: "${discipline.reason}",
                                //    overflow: TextOverflow.ellipsis,
                                //    maxLines: 3,
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.monthNameColor
                                        .withOpacity(0.8)),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          // style: FontUtil.circularsubttile,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${discipline.teacherName}",
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.monthNameColor),
              ),
              Text(
                "${discipline.points}",
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.monthNameColor),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

GradientBorderButton animatedbutton() {
  return const GradientBorderButton();
}

class GradientBorderButton extends StatelessWidget {
  const GradientBorderButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the button width and height based on screen size
    final buttonWidth = screenWidth * 0.12;
    final buttonHeight = screenHeight * 0.03;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      padding: const EdgeInsets.all(1), // Border width
      decoration: BoxDecoration(
        gradient: MyColors.arrowColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.close,
              color: Colors.black,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
