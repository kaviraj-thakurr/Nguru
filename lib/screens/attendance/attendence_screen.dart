import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_attendence_footer_card.dart';
import 'package:nguru/custom_widgets/custom_calendar.dart';
import 'package:nguru/custom_widgets/custom_search_bar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_cubit.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_state.dart';
import 'package:nguru/models/cumulative_attendance_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

int? currentMonthNumber;

class AttendenceScreen extends StatefulWidget {
  final int? month;
  final DateTime? startDate;
  final DateTime? endDate;

  const AttendenceScreen({super.key, this.month,  this.startDate,  this.endDate});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  final TextEditingController searchBarController = TextEditingController();
  final DateTime _focusedDay = DateTime.now();
  List monthMap = [
    "",
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
    "Dec",
  ];
  AttendanceCumulativeModel? attendanceCumulativeModel;

  @override
  void initState() {
    super.initState();
    context.read<CumulativeAttendanceCubit>().getCumulativeAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
          child: Image.asset(
        MyAssets.bg,
        fit: BoxFit.fill,
      )),
      SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
          child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              10.heightBox,
              dashboardAppBar(),
              10.heightBox,
              CustomSearchBar(controller: searchBarController),
              10.heightBox,
              screenTitleHeader("Attendance",
                  onPressed: () => Navigator.pop(context)),
              20.heightBox,
              CustomCalendar(
                month: widget.month,
                startDate: widget.startDate,
                endDate: widget.endDate,
              ),
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
                      return BlocConsumer<CumulativeAttendanceCubit,
                              CumulativeAttendanceState>(
                          listener: (context, state) {
                        if (state is CumulativeAttendanceSuccessState) {
                          attendanceCumulativeModel = state
                              .attendanceCumulativeModel!
                              .where((item) =>
                                  item.monthName ==
                                  monthMap[
                                      currentMonthNumber ?? widget.month ?? 1])
                              .first;
                        }
                      }, builder: (context, state) {
                        if (state is CumulativeAttendanceLoadingState) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: footer(index, context, null),
                          );
                        } else if (state is CumulativeAttendanceSuccessState) {
                          attendanceCumulativeModel = state
                              .attendanceCumulativeModel!
                              .where((item) =>
                                  item.monthName ==
                                  monthMap[
                                      currentMonthNumber ?? widget.month ?? 1])
                              .first;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: footer(
                                index, context, attendanceCumulativeModel),
                          );
                        } else if (state is CumulativeAttendanceErrorState) {
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
        ),
      ),
    ]));
  }

  Widget footer(int index, BuildContext context,
      AttendanceCumulativeModel? attendanceCumulativeModel) {
    switch (index) {
      case 0:
        return customAttendenceFooterCard(context,
            headerText: MyStrings.totalWorkingDays,
            footerText: attendanceCumulativeModel?.workingDays ?? "",
            footerColor: MyColors.buildLegendColor_4);
      case 1:
        return customAttendenceFooterCard(context,
            headerText: MyStrings.absent,
            footerText: attendanceCumulativeModel?.absentDay ?? "",
            footerColor: MyColors.buildLegendColor_5);
      case 2:
        return customAttendenceFooterCard(context,
            headerText: MyStrings.present,
            footerText: attendanceCumulativeModel?.presentDay ?? "",
            footerColor: MyColors.buildLegendColor_6);
      default:
        return const Text(
          MyStrings.unknownOption,
          style: TextStyle(fontSize: 24),
        );
    }
  }
}
