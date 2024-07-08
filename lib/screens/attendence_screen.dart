import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/attendence_and_fee_card.dart';
import 'package:nguru/custom_widgets/custom_calendar.dart';
import 'package:nguru/custom_widgets/custom_floating_action_button.dart';
import 'package:nguru/custom_widgets/person_card.dart';
import 'package:nguru/utils/my_assets.dart';
import 'package:nguru/utils/my_colors.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: customFloatingActionButton(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height *1,
              width:  double.infinity,
              child: 
              Column(
             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        personInfoCard(context, "https://via.placeholder.com/150",
                            "Anshul Goswami", "XI B", "1237/AA/2023B"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            attendenceAndFeeCard(
                              context,
                              mainText: "53%",
                              footerText: "Attendence",
                            ),
                            attendenceAndFeeCard(context,
                                headerText: "Paid 23k",
                                mainText: "23k",
                                footerText: "Advance 23k")
                          ],
                        )
                      ],
                    ),
                  ),
                   CustomCalendar(),
                
                ],
              ),
               
            ),
          )),
    );
  }
}
