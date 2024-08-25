import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_gradient_button.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/timetable/timetable_cubit.dart';
import 'package:nguru/logic/timetable/timetable_state.dart';
import 'package:nguru/models/timetable_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int selectedDay = DateTime.now().weekday; 
  bool isSelected=false;

  @override
  void initState() {
    super.initState();
    context.read<TimeTableCubit>().getTimeTableList();
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              children: [
                10.heightBox,
                customAppBar(),
                screenTitleHeader(MyStrings.timeTable,
                    onPressed: () => Navigator.pop(context)),
                40.heightBox,
                weekDaysRow(),
                30.heightBox,
                Expanded(
                  child: BlocBuilder<TimeTableCubit, TimeTableState>(
                    builder: (context, state) {
                      if (state is TimeTableLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TimeTableSuccessState) {
                        return timetablePage(
                            context, state.timeTableModel.listTimeTable);
                      } else if (state is TimeTableErrorState) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget weekDaysRow() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        return gradientRoundedBorderButton(
            title: days[index],
            onPressed: () {
              setState(() {
                selectedDay = index + 1;
              });
            },
          //  fontSize: 12,
            fontWeight:
selectedDay == index + 1 ? FontWeight.bold : FontWeight.normal,
          isSelected: selectedDay == index + 1,);

      })
    );
  }


  

  Widget timetablePage(BuildContext context, List<ListTimeTable>? list) {
    if (list == null || list.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    List<ListTimeTable> filteredList = [];

    for (var item in list) {
      switch (selectedDay) {
        case DateTime.monday:
          if (item.mon != null) filteredList.add(item);
          break;
        case DateTime.tuesday:
          if (item.tues != null) filteredList.add(item);
          break;
        case DateTime.wednesday:
          if (item.wed != null) filteredList.add(item);
          break;
        case DateTime.thursday:
          if (item.thur != null) filteredList.add(item);
          break;
        case DateTime.friday:
          if (item.fri != null) filteredList.add(item);
          break;
        case DateTime.saturday:
        case DateTime.sunday:
          return Column(
            children: [
              Center(
                  child: Image.asset(
                MyAssets.noData,
                height: height300,
              )),
              Text("Happy Holiday !",
                  style: FontUtil.customStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: APP_FONT,
                      textColor: MyColors.boldTextColor))
            ],
          );
        default:
          break;
      }
    }

    if (filteredList.isEmpty) {
      return const Center(
        child: Text(
          "No data available",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: filteredList.asMap().entries.map((entry) {
          int index = entry.key;
          ListTimeTable item = entry.value;
          bool isEveryThird = (index + 1) % 3 == 0;

          return Column(
            children: [
              isEveryThird
                  ? timetableCardType1(
                      context,
                      "${item.mon}",
                      "${item.time}",
                    )
                  : timetableCardType2(
                      context,
                      item,
                    ),
              AppGapping.padding8,
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget timetableCardType1(BuildContext context, String subject, String time) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.050,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: MyColors.assignmentDate,
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: FontUtil.customStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.appColor1),
            ),
            Text(
              time,
              style: FontUtil.customStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.appColor1),
            ),
          ],
        ),
      ),
    );
  }

  Widget timetableCardType2(BuildContext context, ListTimeTable item) {
    String subject;
    String teacherName;

    switch (selectedDay) {
      case DateTime.monday:
        subject = item.mon ?? MyStrings.noSubject;
        teacherName = item.monPeriodTeacher ?? MyStrings.noTeacher;
        break;
      case DateTime.tuesday:
        subject = item.tues ?? MyStrings.noSubject;
        teacherName = item.tuesPeriodTeacher ?? MyStrings.noTeacher;
        break;
      case DateTime.wednesday:
        subject = item.wed ?? MyStrings.noSubject;
        teacherName = item.wedPeriodTeacher ?? MyStrings.noTeacher;
        break;
      case DateTime.thursday:
        subject = item.thur ?? MyStrings.noSubject;
        teacherName = item.thurPeriodTeacher ?? MyStrings.noTeacher;
        break;
      case DateTime.friday:
        subject = item.fri ?? MyStrings.noSubject;
        teacherName = item.friPeriodTeacher ?? MyStrings.noTeacher;
        break;
      case DateTime.saturday:
        subject = item.sat ?? MyStrings.holiday;
        teacherName = item.satPeriodTeacher ?? MyStrings.holiday;
        break;
      case DateTime.sunday:
        subject = item.sun ?? MyStrings.holiday;
        teacherName = item.sunPeriodTeacher ?? MyStrings.holiday;
        break;
      default:
        subject = MyStrings.holiday;
        teacherName = MyStrings.holiday;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.088,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: MyColors.searchBox, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: FontUtil.customStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.w600,
                      textColor: MyColors.addButtonColor,
                    ),
                    children: [
                      TextSpan(
                        text: "${item.periodSrNo}",
                      ),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0, -10),
                          child: Text(
                            getSuffix(int.parse("${item.periodSrNo}")),
                            style: FontUtil.customStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.teacherNameColor,
                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.widthBox,
                Text(
                 teacherName.length > 23 ? '${teacherName.substring(0, 23)}.' : teacherName,
                
                 
                  style: FontUtil.customStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.teacherNameColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Text(
                    subject,
                    style: FontUtil.customStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.teacherNameColor,
                    ),
                    textAlign: TextAlign.right,
                    // Center text if needed
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyStrings.period,
                  style: FontUtil.customStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.periodOrTimeColor),
                ),
                Text(
                  "${item.time}",
                  style: FontUtil.customStyle(
                      fontSize: 12.h,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.periodOrTimeColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String getSuffix(int number) {
    if (number == 1) {
      return "st";
    } else if (number == 2) {
      return "nd";
    } else if (number == 3) {
      return "rd";
    } else {
      return "th";
    }
  }
}
