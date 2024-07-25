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
import 'package:velocity_x/velocity_x.dart';


class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  List<String> names = ['Name Surname', 'Anshul Goswami'];
  String personName = 'Surname'; // Ensure this is in the list of names
  TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: double.infinity,
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomAppBar(),
                CustomSearchBar(
                  controller: searchBarController,
                  hintText: "search",
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                    Text("Attendance Details",
                        style: FontUtil.customStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            textColor: MyColors.boldTextColor)),
                  ],
                ),
             
               const CustomCalendar(),
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: footer(index, context),
                        );
                      },
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ),
        ));
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
