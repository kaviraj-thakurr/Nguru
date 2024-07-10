import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nguru/custom_widgets/attendence_and_fee_card.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_attendence_footer_card.dart';
import 'package:nguru/custom_widgets/custom_calendar.dart';
import 'package:nguru/custom_widgets/custom_search_bar.dart';
import 'package:nguru/custom_widgets/person_card.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  List<String> names = ['Anshul Goswami', 'Name Surname'];
  String personName = 'Anshul Goswami';
  TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: dashboardAppBar(),
          // floatingActionButton: customFloatingActionButton(context),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          body: SingleChildScrollView(
            child: Container(
              //    padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Column(
                children: [
                  CustomSearchBar(
                    controller: searchBarController,
                    hintText: "search",
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                      Text("Jan, 2024",
                          style: FontUtil.customStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              textColor: MyColors.boldTextColor)),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.2,
                      maxWidth: double.infinity,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        personInfoCard(
                          context,
                          "https://via.placeholder.com/150",
                          personName,
                          "XI B",
                          "1237/AA/2023B",
                          (String newName) {
                            setState(() {
                              personName = newName;
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              child: attendenceAndFeeCard(
                                context,
                                mainText: "53%",
                                footerText: "Attendence",
                                isFeeCard: false
                              ),
                            ),
                            Spacer(),
                            Flexible(
                              flex: 5,
                              child: attendenceAndFeeCard(context,
                                  headerText: "Paid 23k",
                                  mainText: "23k",
                                  footerText: "Advance 23k",
                                  isFeeCard: true),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomCalendar(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.12,
                          maxWidth: double.infinity),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: footer(index, context),
                          );
                        },
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height *0.03,),
                ],
              ),
            ),
          )),
    );
  }

  Widget footer(int index, BuildContext context) {
    switch (index) {
      case 0:
        return customAttendenceFooterCard(context,
            headerText: "Total Working Days",
            footerText: "30",
            footerColor: MyColors.buildLegendColor_4);
      case 1:
        return customAttendenceFooterCard(context,
            headerText: "Absent",
            footerText: "0",
            footerColor: MyColors.buildLegendColor_5);
      case 2:
        return customAttendenceFooterCard(context,
            headerText: "Present",
            footerText: "30",
            footerColor: MyColors.buildLegendColor_6);
      default:
        return const Text(
          'Unknown option',
          style: TextStyle(fontSize: 24),
        );
    }
  }
}
