import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_progress_bar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/screens/circular_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';

import 'package:velocity_x/velocity_x.dart';

class CircularScreen extends StatefulWidget {
  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
  TextEditingController searchController = TextEditingController();

  bool isSeen = true;
  int selectedcolor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child: Image.asset(
          MyAssets.bg,
          fit: BoxFit.fill,
        )),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              customappbar(),
              CustomSearchBar(controller: searchController),

              screenTitleHeader("Circular",onPressed: () => Navigator.pop(context)),

              5.heightBox,

              circularCalendar(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedcolor = 1;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                          gradient: selectedcolor == 1
                              ? MyColors.arrowColor
                              : MyColors.animatedborder,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selectedcolor == 1
                                ? Colors.green
                                : Color.fromARGB(0, 230, 225, 225), 
                            width: 1.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "All",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    10.widthBox,
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedcolor = 2;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                          color: selectedcolor == 2
                              ? Colors.lightBlue[50]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            // color:selectedcolor==1?Colors.green: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Read",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.widthBox,

                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedcolor = 3;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          color: selectedcolor == 3
                              ? Colors.lightBlue[50]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            // color:selectedcolor==1?Colors.green: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Unread ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // animatedbutton(context, "All"),
                    // 10.widthBox,
                    // animatedbutton(context, "Read"),
                    // 10.widthBox,
                    // animatedbutton(context, "Unread"),
                  ],
                ),
              ),
              //3.heightBox,

              Expanded(
                child: PageView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardDesign(
                            context: context,
                            isViewed: isSeen,
                            onTap: () {
                              setState(() {
                                isSeen = !isSeen;
                              });
                            },
                          ),
                          AppGapping.padding10
                        ],
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
                  Text(
                    "Page 1 of 2",
                    style: FontUtil.customStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.pageNoColor,
                        fontFamily: APP_FONT),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(MyAssets.front_arrow)),
                ],
              ),
              // Text('asdasdas')
              const CustomProgressBar(
                progress: 0.3,
                dotCount: 0,
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget CardDesign(
      {required BuildContext context,
      required bool isViewed,
      required VoidCallback onTap}) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.11,
      // width: MediaQuery.sizeOf(context).width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MyColors.searchBackGroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(MyAssets.bookz),
            12.widthBox,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Important Reminders for Students..",
                    style: FontUtil.circularTitle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet consectetur.\n Eros eget posuere faucibus lectus congue.",
                        style: FontUtil.circularsubttile,
                      ),
                      IconButton(
                          onPressed: onTap,
                          icon: isViewed
                              ? SvgPicture.asset(MyAssets.download)
                              : SvgPicture.asset(MyAssets.seen)),
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

  Widget animatedbutton(BuildContext context, String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth * 0.13;
    final buttonHeight = screenHeight * 0.03;

    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        padding: const EdgeInsets.all(1), // Border width
        decoration: BoxDecoration(
          gradient: MyColors.arrowColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
