import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_progress_bar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/screens/circular_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:velocity_x/velocity_x.dart';

class AssignmentScreen extends StatefulWidget {
  @override
  State<AssignmentScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<AssignmentScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child: Image.asset(
          MyAssets.bg,
          fit: BoxFit.fill,
        )),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                dashboardAppBar(),
                CustomSearchBar(controller: searchController),
                screenTitleHeader("Assignment",
                    onPressed: () => Navigator.pop(context)),
                5.widthBox,
                circularCalendar(),
                Row(
                  children: [
                    animatedButton(context, "All"),
                    10.widthBox,
                    animatedButton(context, "Read"),
                    10.widthBox,
                    animatedButton(context, "Unread"),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CardDesign(context),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(MyAssets.back_arrow)),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(MyAssets.front_arrow)),
                  ],
                ),
                const CustomProgressBar(
                  progress: 0.3,
                  dotCount: 0,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Widget CardDesign(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.14,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: MyColors.searchBackGroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(MyAssets.bookz, height: 50),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The Oak Tree | Ch.2 | Class XI B",
                  style: FontUtil.circularTitle,
                ),
                AppGapping.padding5,
                Text(
                  "Lorem ipsum dolor sit amet consectetur.\nEros eget posuere faucibus lectus congue.",
                  style: FontUtil.circularsubttile,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dateWidget(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(MyAssets.seen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget animatedButton(BuildContext context, String title) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final buttonWidth = screenWidth * 0.15;
  final buttonHeight = screenHeight * 0.03;
  return InkWell(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.all(2),
      width: buttonWidth,
      height: buttonHeight,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: MyColors.arrowColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 2),
          ],
        ),
      ),
    ),
  );
}

Date dateWidget() {
  return Date();
}

class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth * 0.20;
    final buttonHeight = screenHeight * 0.03;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(1),
      decoration: const BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(
          gradient: MyColors.assignmentDate,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'July 14,2024',
                style: TextStyle(
                  color: MyColors.assignmentDateColor,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
