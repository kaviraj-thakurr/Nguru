import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:nguru/utils/app_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class DisciplineScreen extends StatefulWidget {
  const DisciplineScreen({super.key});

  @override
  State<DisciplineScreen> createState() => _DisciplineScreenState();
}

class _DisciplineScreenState extends State<DisciplineScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            dashboardAppBar(),
           

            screenTitleHeader("Discipline"),

            59.heightBox,
            

            circularCalendar(),
            15.heightBox,
                Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Positive Points: 00.00",
                style:FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.monthNameColor),
              ),
              Text(
                "Negative Points: 00.00",
                style:FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.monthNameColor),
              ),
            ],
          ),
         

            Flexible(
              child: PageView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [cardDesign(context), 10.heightBox],
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
            // Text('asdasdas')
            const CustomProgressBar(
              progress: 0.3,
              dotCount: 0,
            )
          ],
        ),
      ),
    );
  }
}

Widget cardDesign(BuildContext context) {
  return Container(
    height: MediaQuery.sizeOf(context).height * 0.15,
    // width: MediaQuery.sizeOf(context).width * 0.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: MyColors.redShade_1.withOpacity(0.08),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width:  MediaQuery.sizeOf(context).width * 0.06,
                height:  MediaQuery.sizeOf(context).height * 0.04,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(3)),
              ),
              10.widthBox,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Jan 03, 2024",
                      style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Discipline Group: ",
                                style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),
                              ),
                              TextSpan(
                                text:
                                    "Academic Misconduct Bringing stationary other than prescribed / provided by school",
                                //    overflow: TextOverflow.ellipsis,
                                //    maxLines: 3,
                                style:FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.monthNameColor.withOpacity(0.8)),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          // style: FontUtil.circularsubttile,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nimisha Chauhan",
                style:FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.monthNameColor),
              ),
              Text(
                "9.00",
                style:FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.monthNameColor),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

GradientBorderButton animatedbutton() {
  return GradientBorderButton();
}

class GradientBorderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the button width and height based on screen size
    final buttonWidth = screenWidth * 0.12;
    final buttonHeight = screenHeight * 0.03;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      padding: EdgeInsets.all(1), // Border width
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
            Text(
              'All',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.close,
              color: Colors.black,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
