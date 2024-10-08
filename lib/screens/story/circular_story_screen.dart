import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:story_view/controller/story_controller.dart';

class CircularStoryScreen extends StatefulWidget {
  final CircularList? circularList;
  final StoryController? storyController;
  const CircularStoryScreen(
      {super.key, this.circularList, this.storyController});

  @override
  State<CircularStoryScreen> createState() => _CircularStoryScreenState();
}

class _CircularStoryScreenState extends State<CircularStoryScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.greenShade_1,
          floatingActionButton: GestureDetector(
              onTap: () => widget.storyController!.next(),
              child: SvgPicture.asset(
                MyAssets.backArrow,
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          MyAssets.assignmentIcon,
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Flexible(
                            child: Text(
                          MyStrings.circular,
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.circularList!.subject != null
                              ? "${widget.circularList!.subject}"
                              : MyStrings.notAvailable,
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black),
                        ),
                        Text(
                          widget.circularList!.noOfcirculars != null
                              ? "${widget.circularList!.noOfcirculars}"
                              : MyStrings.notAvailable,
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.fadedTextColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.9,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(MyAssets.assignmentImage),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Flexible(
                                          child: Text(
                                        widget.circularList!.circularNo != null
                                            ? "${widget.circularList!.circularNo}"
                                            : MyStrings.notAvailable,
                                        style: FontUtil.customStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: MyColors.fadedTextColor),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 11,
                                            color: MyColors.greyShade_3,
                                          ),
                                          Text(
                                            widget.circularList!.circularDate !=
                                                    null
                                                ? "${widget.circularList!.noOfcirculars}"
                                                : MyStrings.notAvailable,
                                            style: FontUtil.customStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                textColor:
                                                    MyColors.greyShade_3),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Spacer(),
                                      SvgPicture.asset(
                                        MyAssets.downloadIcon,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
