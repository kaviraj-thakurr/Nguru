import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAppBar(),
              ),
              screenTitleHeader("Activity"),
              10.heightBox,

              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  color: MyColors.greyShade_6,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/activity.svg"),
                        15.widthBox,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Painting Competition",
                              style: FontUtil.customStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.boldTextColor),
                            ),
                            Text(
                              "Satyam house",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.boldTextColor),
                            ),
                            Text(
                              "Inter School",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.boldTextColor),
                            ),
                            Text(
                              "Position: None",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.blueShade_4),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Jul 4",
                          style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.boldTextColor),
                        ),
                        Text(
                          "09",
                          style: FontUtil.customStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.blueShade_4),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
