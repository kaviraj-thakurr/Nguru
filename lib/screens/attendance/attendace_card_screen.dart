import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

class AttendaceCardScreen extends StatefulWidget {
  const AttendaceCardScreen({super.key});

  @override
  State<AttendaceCardScreen> createState() => _AttendaceCardScreenState();
}

class _AttendaceCardScreenState extends State<AttendaceCardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: screenHeight * 1,
              child: Column(
                children: [
                  screenTitleHeader("Attendance"),
                  Container(
                    height: screenHeight * 0.8,
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: 12,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: attendanceMonthCard(
                              context,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )));
  }
}

Widget attendanceMonthCard(
  BuildContext context,
  {String? monthName,String? attendancePercentage, String? workingDaysCount, String? presentCount, String? absentCount}
) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    // constraints: BoxConstraints(
    //   maxHeight: MediaQuery.of(context).size.height * 0.1,
    //   maxWidth: MediaQuery.of(context).size.width * 0.28,
    // ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "January",
              style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.textColors),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            Text(
              "53%",
              style: FontUtil.customStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.textColors),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Working Days",
                style: FontUtil.customStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey!),
              ),
            ),
            Flexible(
              child: Text(
                "12",
                style: FontUtil.customStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey!),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Flexible(
              
              child: Text(
                "Preset",
                style: FontUtil.customStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey),
              ),
            ),
            Flexible(
              child: Text(
                "28",
                style: FontUtil.customStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey!),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Absent",
                style: FontUtil.customStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey!),
              ),
            ),
            Flexible(
              child: Text(
                "38",
                style: FontUtil.customStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.grey!),
              ),
            )
          ],
        )
      ],
    ),
  );
}
