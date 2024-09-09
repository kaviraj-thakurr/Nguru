import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/custom_tab_selector.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/activity/activity_cubit.dart';
import 'package:nguru/logic/activity/activity_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> selecterItems = [
    "Event Result",
    "Event Reslt",
    "Event esult",
  ];
  int currentTab = 0;
  void onTabSelection(int currentTabb) {
    setState(() {
      currentTab = currentTabb;
    });
  }

  @override
  void initState() {
    context.read<ActivityCubit>().getActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Column(
            children: [
              10.heightBox,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: dashboardAppBar(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: CustomSearchBar(controller: _searchController),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: screenTitleHeader(MyStrings.activity,
                    onPressed: () => Navigator.pop(context)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customTabSelector(selecterItems, currentTab, onTabSelection,false),
                  ],
                ),
              ),
              Expanded(
                  child: BlocConsumer<ActivityCubit, ActivityState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ActivityLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ActivitySuccessState) {
                          return state.activityList.isEmpty
                              ? Center(
                                  child: Column(
                                  children: [
                                    160.heightBox,
                                    SvgPicture.asset(
                                      MyAssets.noDataFound,
                                      height: height150,
                                    ),
                                    5.heightBox,
                                    Text(
                                      MyStrings.noActivityFound,
                                      style: FontUtil.customStyle(
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: APP_FONT,
                                          textColor: MyColors.noDataFoundTitle),
                                    ),
                                  ],
                                ))
                              : Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: state.activityList.length,
                                      itemBuilder: (context, index) {
                                        var items = state.activityList[index];
                                        return Column(
                                          children: [
                                            activityItems(context,
                                                eventName: items.activityName,
                                                eventLevel: items.eventLevel,
                                                position: items.position,
                                                eventDate: DateFormat("MMM dd")
                                                    .format(DateFormat(
                                                            "dd-MMM-yyyy")
                                                        .parse(
                                                            items.eventDate ??
                                                                "dd-MMM-yyyy")),
                                                points:
                                                    items.points.toString()),
                                            15.heightBox,
                                          ],
                                        );
                                      }),
                                );
                        } else if (state is ActivityErrorState) {
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
                      })),
            ],
          ),
        ],
      ),
    );
  }
}



Widget activityItems(BuildContext context,
    {String? eventName,
    String? houseName,
    String? eventLevel,
    String? position,
    String? eventDate,
    String? points}) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.13,
    decoration: BoxDecoration(
      color: MyColors.greyShade_6,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(MyAssets.activity_2),
            15.widthBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName ??
                      "${MyStrings.eventName}:  ${MyStrings.notAvailable}",
                  style: FontUtil.customStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                Text(
                  houseName ??
                      "${MyStrings.houseName}:  ${MyStrings.notAvailable}",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                Text(
                  eventLevel ??
                      "${MyStrings.eventLevel}: ${MyStrings.notAvailable}",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                Text(
                  "${MyStrings.position}: ${position ?? " ${MyStrings.notAvailable}"}",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.blueShade_4),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              eventDate ?? "${MyStrings.date}: ${MyStrings.notAvailable}",
              style: FontUtil.customStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor),
            ),
            Text(
              points ?? "${MyStrings.points}: ${MyStrings.notAvailable}",
              style: FontUtil.customStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.blueShade_4),
            ),
          ],
        ),
      ],
    ),
  );
}
