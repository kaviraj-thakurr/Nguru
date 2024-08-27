import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/activity/activity_cubit.dart';
import 'package:nguru/logic/activity/activity_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
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
  ];
  DateTime _focusedDay = DateTime.now();
  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _focusedDay = selectedDay;
    });
  }

  @override
  void initState() {
    context.read<ActivityCubit>().getActivity();
    // TODO: implement initState
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
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: dashboardAppBar(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: CustomSearchBar(controller: _searchController),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: screenTitleHeader("Activity",onPressed: ()=>Navigator.pop(context)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildSelector(selecterItems, _focusedDay, _onDaySelected),
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
                          return Padding(
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
                                          eventDate: DateFormat("MMM dd").format(
                                              DateFormat("dd-MMM-yyyy").parse(
                                                  items.eventDate ??
                                                      "dd-MMM-yyyy")),
                                          points: items.points.toString()),
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

Widget buildSelector(
  List<String> selecterItems,
  DateTime focusedDay,
  Function(DateTime) onDaySelected,
) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(right: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: selecterItems.map((month) {
        bool isSelected = focusedDay.month == selecterItems.indexOf(month) + 1;
        isSelected=true;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            onTap: () {
              onDaySelected(
                DateTime(
                  focusedDay.year,
                  selecterItems.indexOf(month) + 1,
                ),
              );
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
            SvgPicture.asset("assets/icons/activity.svg"),
            15.widthBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName ?? "Event Name: N/A",
                  style: FontUtil.customStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                Text(
                  houseName ?? "House Name: N/A",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                Text(
                  eventLevel ?? "Event Level: N/A",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                Text(
                  "Position: ${position ?? "N/A"}",
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
              eventDate ?? "Date: N/A",
              style: FontUtil.customStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor),
            ),
            Text(
              points ?? "Points: N/A",
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
