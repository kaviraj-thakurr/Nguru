import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/screens/circular_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:velocity_x/velocity_x.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimetableScreen> {
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  customappbar(),
                  screenTitleHeader("TimeTable",onPressed: () => Navigator.pop(context),),
                  20.heightBox,
                  circularCalendar(),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.65,
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      children: [
                        timetablePage(context, 1),
                        timetablePage(context, 2),
                        timetablePage(context, 3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timetablePage(BuildContext context, int pageIndex) {
    return SingleChildScrollView(
      child: Column(
        children: [
          timetableCards(context, "1st", "Agatha D'Souza", "English"),
          12.heightBox,
          timetableCards(context, "2nd", "Agatha D'Souza", "English"),
          12.heightBox,
          breaktimecard(context),
          12.heightBox,
          timetableCards(context, "3rd", "Sumedha Rani", "Hindi"),
          12.heightBox,
          timetableCards(context, "4th", "Anjali Kapur", "Computer"),
          12.heightBox,
          breaktimecard(context),
          12.heightBox,
          timetableCards(context, "5th", "Anjali Kapur", "Computer"),
          12.heightBox,
          timetableCards(context, "6th", "Anjali Kapur", "Computer"),
          12.heightBox,
          breaktimecard(context),
          12.heightBox,
          timetableCards(context, "7th", "Anjali Kapur", "Computer"),
          12.heightBox,
          timetableCards(context, "8th", "Anjali Kapur", "Computer"),
          12.heightBox,
          breaktimecard(context),
          AppGapping.padding10,
        ],
      ),
    );
  }

  Widget timetableCards(BuildContext context, String periodNumber,
      String teachername, String subject) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.11,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: MyColors.searchbox, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  periodNumber,
                  style: FontUtil.customStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      textColor: MyColors.addButtonColor),
                ),
                Text(
                  teachername,
                  style: FontUtil.customStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.addButtonColor),
                ),
                Text(
                  subject,
                  style: FontUtil.customStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.addButtonColor),
                ),
              ],
            ),
            8.heightBox,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Period"), Text("09:00-9:30")],
            )
          ],
        ),
      ),
    );
  }

  Widget breaktimecard(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.055,
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
              "Break Time",
              style: FontUtil.customStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.appColor1),
            ),
            const Text("10:01 am - 10:30"),
          ],
        ),
      ),
    );
  }
}
