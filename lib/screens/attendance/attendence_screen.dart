import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_attendence_footer_card.dart';
import 'package:nguru/custom_widgets/custom_calendar.dart';
import 'package:nguru/custom_widgets/custom_search_bar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_cubit.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_state.dart';
import 'package:nguru/models/particular_month_attendance_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendenceScreen extends StatefulWidget {

  final int? month;


  const AttendenceScreen({super.key, this.month});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  final TextEditingController searchBarController = TextEditingController();
  final DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
             Positioned.fill(
            child: Image.asset(
          MyAssets.bg,
          fit: BoxFit.fill,
        )),
            
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
                    screenTitleHeader(MyStrings.attendanceDetails,
                        onPressed: () => Navigator.pop(context)),
                     CustomCalendar(month: widget.month,),
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
                            return BlocConsumer<ParticularMonthAttendanceCubit,
                                    ParticularMonthAttendanceState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state
                                      is ParticularMonthAttendanceLoadingState) {
                                    return const Center(
                                      child: SizedBox.shrink(),
                                    );
                                  } else if (state
                                      is ParticularMonthAttendanceSuccessState) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: footer(index, context,
                                          state.particularMonthAttendanceModel),
                                    );
                                  } else if (state
                                      is ParticularMonthAttendanceErrorState) {
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
          ]
        )
        );
  }

  Widget footer(int index, BuildContext context,
      ParticularMonthAttendanceModel particularMonthAttendanceModel) {
    switch (index) {
      case 0:
        return customAttendenceFooterCard(context,
            headerText: MyStrings.totalWorkingDays,
            footerText:
                "${particularMonthAttendanceModel.presentCount! + particularMonthAttendanceModel.absentCount! + particularMonthAttendanceModel.holidayCount!}",
            footerColor: MyColors.buildLegendColor_4);
      case 1:
        return customAttendenceFooterCard(context,
            headerText: MyStrings.absent,
            footerText: "${particularMonthAttendanceModel.absentCount}",
            footerColor: MyColors.buildLegendColor_5);
      case 2:
        return customAttendenceFooterCard(context,
            headerText: MyStrings.present,
            footerText: "${particularMonthAttendanceModel.presentCount}",
            footerColor: MyColors.buildLegendColor_6);
      default:
        return const Text(
          MyStrings.unknownOption,
          style: TextStyle(fontSize: 24),
        );
    }
  }
}
