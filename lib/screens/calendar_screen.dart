import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_attendence_footer_card.dart';
import 'package:nguru/custom_widgets/custom_search_bar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/calendar_event/calendar_event_cubit.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/screens/event_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TextEditingController searchBarController = TextEditingController();
  final DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<CalendarEventCubit>().getCalendarEvent(_focusedDay.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(MyAssets.background_2),
        Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: double.infinity,
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomAppBar(),
                  CustomSearchBar(
                    controller: searchBarController,
                    hintText: MyStrings.search,
                  ),
                  screenTitleHeader(MyStrings.calender,
                      onPressed: () => Navigator.pop(context)),
                  const EventCalendar(),
                  20.heightBox,
                  Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.12,
                          maxWidth: double.infinity),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return BlocConsumer<CalendarEventCubit,
                                  CalendarEventState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is CalendarEventLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is CalendarEventSuccessState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: footer(index, context,
                                        state.calendarEventListData!),
                                  );
                                } else if (state is CalendarEventErrorState) {
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
                              });
                        },
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            )),
      ],
    ));
  }

  Widget footer(int index, BuildContext context,
      List<CalendarEventList> calendarEventList) {
   // log("${MyStrings.eventDate}: ${calendarEventList.length}");
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ListView.builder(
          itemCount: calendarEventList.length,
          itemBuilder: (context, index) {
            return customAttendenceFooterCard(context);
          }),
    );
  }
}

Widget customCalendarEventFooterCard(BuildContext context,
    {String? headerText, String? footerText, Color? footerColor}) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.1,
      maxWidth: MediaQuery.of(context).size.width * 0.28,
    ),
    decoration: BoxDecoration(
      color: MyColors.calendarFooterCard,
      borderRadius: BorderRadius.circular(
          5.0), // Half of the width/height for a perfect circle
      border: Border.all(
        color: MyColors.calendarFooterCard,
        width: 2.0,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.23,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Text(
                  headerText ?? MyStrings.totalWorkingDays,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.textcolors),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              footerText ?? "30",
              style: FontUtil.customStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  textColor: footerColor!),
            )
          ],
        )
      ],
    ),
  );
}
