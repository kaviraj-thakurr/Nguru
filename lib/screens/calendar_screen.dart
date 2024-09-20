import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_search_bar.dart';
import 'package:nguru/logic/calendar_event/calendar_event_cubit.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/screens/event_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  const CalendarScreen(
      {super.key, required this.startDate, required this.endDate});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TextEditingController searchBarController = TextEditingController();
  DateTime _focusedDay = DateTime.now();
  late CalendarEventCubit cubit;

  void initCubit() {
    cubit = BlocProvider.of<CalendarEventCubit>(context);
    _focusedDay.isAfter(widget.endDate)
        ? cubit.getCalendarEvent(widget.endDate.month)
        : cubit.getCalendarEvent(_focusedDay.month);
  }

  @override
  void initState() {
    _focusedDay.isAfter(widget.endDate)
        ? _focusedDay = widget.endDate
        : _focusedDay = _focusedDay;
    isParticularEventDateSelected = false;
    super.initState();
    initCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(MyAssets.background_2),
        Padding(
            padding: const EdgeInsets.all(padding18),
            child: Column(
              children: [
                10.heightBox,
                dashboardAppBar(),
                CustomSearchBar(controller: searchBarController),
                10.heightBox,
                EventCalendar(
                  startDate: widget.startDate,
                  endDate: widget.endDate,
                ),
                20.heightBox,
                Expanded(
                  child: SizedBox(
                      child: BlocConsumer<CalendarEventCubit,
                              CalendarEventState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is CalendarEventLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is CalendarEventSuccessState &&
                                cubit.calendarEventList.isNotEmpty) {
                              return isParticularEventDateSelected
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: state
                                              .calendarEventListData.length,
                                          itemBuilder: (context, index) {
                                            return footer(index, context,
                                                state.calendarEventListData);
                                          }),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              cubit.calendarEventList.length,
                                          itemBuilder: (context, index) {
                                            return footer(index, context,
                                                cubit.calendarEventList);
                                          }),
                                    );
                            } else if (state is CalendarEventFilteredState) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        state.calendarEventFilteredList?.length,
                                    itemBuilder: (context, index) {
                                      return footer(
                                          index,
                                          context,
                                          state.calendarEventFilteredList ??
                                              []);
                                    }),
                              );
                            } else if (cubit.calendarEventList.isEmpty) {
                              return Center(
                                child: Text(
                                  MyStrings.noEventsForThisMonth,
                                  style: FontUtil.customStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      textColor: MyColors.boldTextColor),
                                ),
                              );
                            } else if (state is CalendarEventErrorState) {
                              return Center(
                                child: Text(
                                  "error${state.message}",
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            )),
      ],
    ));
  }

  Widget footer(int index, BuildContext context,
      List<CalendarEventList> calendarEventList) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.08,
            child: customCalendarEventFooterCard(
                context, calendarEventList[index].details,
                headerText: calendarEventList[index].eventName,
                footerText: calendarEventList[index].calendarDate.toString(),
                footerColor: MyColors.boldTextColor)),
        10.heightBox,
      ],
    );
  }
}

Widget customCalendarEventFooterCard(BuildContext context, String? details,
    {String? headerText, String? footerText, Color? footerColor}) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.07,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                headerText ?? "",
                style: FontUtil.customStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.textcolors),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              Text(
                DateFormat('EEEE')
                    .format(DateTime.parse(footerText.toString())),
                style: FontUtil.customStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.textcolors),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MMM dd, yyyy')
                  .format(DateTime.parse(footerText.toString())),
              style: FontUtil.customStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: footerColor!),
            ),
            Text(
              details == "0"
                  ? "Not working"
                  : details == "1"
                      ? "Working"
                      : "Working status: N/A",
              style: FontUtil.customStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.textcolors),
            )
          ],
        )
      ],
    ),
  );
}
