import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_state.dart';
import 'package:nguru/logic/infirmary_all/infirmary/infirmary_cubit.dart';
import 'package:nguru/logic/infirmary_all/infirmary/infirmary_state.dart';
import 'package:nguru/logic/student_profile/student_profile_cubit.dart';
import 'package:nguru/logic/student_profile/student_profile_state.dart';
import 'package:nguru/screens/settings/setting_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class InfirmaryScreen extends StatefulWidget {
  const InfirmaryScreen({super.key});

  @override
  State<InfirmaryScreen> createState() => _InfirmaryScreenState();
}

class _InfirmaryScreenState extends State<InfirmaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> months = [
    "Illness",
    "Vaccination",
    "Body Details",
  ];
  int seletedIndex = 0;

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    context.read<InfirmaryCubit>().getInfirmary();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                20.heightBox,
                dashboardAppBar(),
                CustomSearchBar(controller: _searchController),
                20.heightBox,
                screenTitleHeader(MyStrings.infirmary,
                    onPressed: () => Navigator.pop(context)),
                20.heightBox,
                BlocBuilder<StudentProfileCubit, StudentProfileState>(
                    builder: (context, state) {
                  if (state is StudentProfileLoadingState) {
                    return customSettingProfileWidget(context, screenWidth,
                        screenHeight, "name:", "class:", "Admission no:",
                        bloodGroup: "Blood group:", gender: "Gender:",
                        studentPicture: "");
                  } else if (state is StudentProfileSuccessState) {
                  return  customSettingProfileWidget(
                          context,
                          screenWidth,
                          screenHeight,
                          state.studentProfileState.personalInfo?.studentName ?? "",
                          "${state.studentProfileState.personalInfo?.className ?? ""} ${state.studentProfileState.personalInfo?.section ?? ""}",
                          state.studentProfileState.personalInfo?.admissionNumber ?? "",
                         bloodGroup: state.studentProfileState.personalInfo?.bloodGroup ?? "",
                         gender: state.studentProfileState.personalInfo?.gender ?? "", 
                          studentPicture:   state.studentProfileState.personalInfo?.studentPicture ?? "", 
);
                  } else if (state is StudentProfileErrorState) {
                    return customSettingProfileWidget(
                        context, screenWidth, screenHeight, ": ", "", "",
                        bloodGroup: "", gender: "");
                  } else {
                    return customSettingProfileWidget(context, screenWidth,
                        screenHeight, "name:", "class:", "Admission no:", 
                        bloodGroup: "Blood group:", gender: "Gender:",studentPicture: "");
                  }
                }),
                20.heightBox,
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<InfirmaryCubit, InfirmaryState>(
                      builder: (context, state) {
                    if (state is InfirmaryLoadingState) {
                      return RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${MyStrings.dailyEntries} ",
                              style: FontUtil.customStyle(
                                  fontSize: 17.h,
                                  fontWeight: FontWeight.w700,
                                  textColor: MyColors.boldTextColor),
                            ),
                            TextSpan(
                              text: "( )",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  textColor:
                                      MyColors.monthNameColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }

                    if (state is InfirmarySuccessState) {
                      return RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${MyStrings.dailyEntries} ",
                              style: FontUtil.customStyle(
                                  fontSize: 17.h,
                                  fontWeight: FontWeight.w700,
                                  textColor: MyColors.boldTextColor),
                            ),
                            TextSpan(
                              text: "(${state.infirmary.length})",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  textColor:
                                      MyColors.monthNameColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }

                    if (state is InfirmaryErrorState) {
                      return RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${MyStrings.dailyEntries} ",
                              style: FontUtil.customStyle(
                                  fontSize: 17.h,
                                  fontWeight: FontWeight.w700,
                                  textColor: MyColors.boldTextColor),
                            ),
                            TextSpan(
                              text: "(_ _)",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  textColor:
                                      MyColors.monthNameColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    } else {
                      return RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${MyStrings.dailyEntries} ",
                              style: FontUtil.customStyle(
                                  fontSize: 17.h,
                                  fontWeight: FontWeight.w700,
                                  textColor: MyColors.boldTextColor),
                            ),
                            TextSpan(
                              text: "(_ _)",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  textColor:
                                      MyColors.monthNameColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }
                  }),
                ),
                15.heightBox,
                Expanded(
                  child: SizedBox(
                    child: BlocConsumer<InfirmaryCubit, InfirmaryState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is InfirmaryLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is InfirmarySuccessState) {
                            return
                            state.infirmary.isEmpty ?
                           Center(
                              child: Column(
                              children: [
                                160.heightBox,
                                SvgPicture.asset(
                                  MyAssets.noDataFound,
                                  height: height150,
                                ),
                                5.heightBox,
                                Text(
                                  MyStrings.noInfirmaryFound,
                                  style: FontUtil.customStyle(
                                      fontSize: 14.h,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: APP_FONT,
                                      textColor: MyColors.noDataFoundTitle),
                                ),
                              ],
                            ))
                            :
                             ListView.builder(
                                itemCount: state.infirmary.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      customInfirmaryItems(context,
                                          illnessHeading: state.infirmary[index]
                                                  .illnessHeading ??
                                              "",
                                          illnessDetails: state.infirmary[index]
                                                  .illnessDetails ??
                                              "",
                                          medicine:
                                              state.infirmary[index].medicine ??
                                                  "",
                                          dosage: state.infirmary[index]
                                                  .amountofDose ??
                                              "",
                                          remarks:
                                              state.infirmary[index].remarks ??
                                                  "",
                                          date: state.infirmary[index]
                                                  .illnessDate ??
                                              ""),
                                      15.heightBox
                                    ],
                                  );
                                });
                          } else if (state is InfirmaryErrorState) {
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
                                "${{MyStrings.undefinedState}}",
                                style: FontUtil.customStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor: MyColors.boldTextColor),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          bool isSelected = _focusedDay.month == months.indexOf(month) + 1;
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
                seletedIndex = months.indexOf(month);
                log("selected: ${months.indexOf(month)}");
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

Widget customInfirmaryItems(BuildContext context,
    {String? illnessHeading,
    String? illnessDetails,
    String? medicine,
    String? dosage,
    String? remarks,
    String? date}) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.235,
    decoration: BoxDecoration(
      color: MyColors.greyShade_6,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          illnessHeading ?? "",
          style: FontUtil.customStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              textColor: MyColors.boldTextColor),
        ),
        10.heightBox,
        Text(
          illnessDetails ??
              "",
          style: FontUtil.customStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              textColor: MyColors.fadedTextColor),
          maxLines: 2,
        ),
        10.heightBox,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${MyStrings.medicine}: ",
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textColor: MyColors.boldTextColor),
              ),
              TextSpan(
                text: medicine ?? "",
                //    overflow: TextOverflow.ellipsis,
                //    maxLines: 3,
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: MyColors.fadedTextColor.withOpacity(0.8)),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // style: FontUtil.circularsubttile,
        ),
        10.heightBox,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${MyStrings.dosage}: ",
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textColor: MyColors.boldTextColor),
              ),
              TextSpan(
                text: dosage ?? "",
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: MyColors.fadedTextColor.withOpacity(0.8)),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // style: FontUtil.circularsubttile,
        ),
        10.heightBox,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${MyStrings.remark}: ",
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textColor: MyColors.boldTextColor),
              ),
              TextSpan(
                text: remarks ?? "",
                //    overflow: TextOverflow.ellipsis,
                //    maxLines: 3,
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: MyColors.fadedTextColor.withOpacity(0.8)),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          // style: FontUtil.circularsubttile,
        ),
        10.heightBox,
        Text(
          date ?? "",
          style: FontUtil.customStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              textColor: MyColors.fadedTextColor),
          maxLines: 2,
        ),
      ],
    ),
  );
}
