import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/remove_html_tags.dart';
import 'package:story_view/controller/story_controller.dart';

class AssignmentStoryScreen extends StatefulWidget {
  final SubjectList? subject;
  final StoryController? storyController;
  const AssignmentStoryScreen({super.key, this.subject, this.storyController});

  @override
  State<AssignmentStoryScreen> createState() => _AssignmentStoryScreenState();
}

class _AssignmentStoryScreenState extends State<AssignmentStoryScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.greenShade_1,
          floatingActionButton: GestureDetector(
              onTap: () => widget.storyController?.next(),
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
                          MyStrings.asssignment,
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
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
                          widget.subject?.assignments?.first.assignmentName !=
                                  null
                              ? "${widget.subject?.assignments?.first.assignmentName}"
                              : MyStrings.notAvailable,
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              textColor: Colors.black),
                        ),
                        Text(
                          widget.subject?.assignments?.first.assignmentDetail !=
                                  null
                              ? removeHtmlTags(
                                  "${widget.subject?.assignments?.first.assignmentDetail}")
                              : MyStrings.notAvailable,
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.fadedTextColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.9,
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(padding8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(MyAssets.assignmentImage),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: screenHeight * 0.01,
                                        ),
                                        Flexible(
                                            child: Text(
                                          widget.subject?.assignments?.first
                                                      .assignmentDetail !=
                                                  null
                                              ? removeHtmlTags(
                                                  "${widget.subject?.assignments?.first.assignmentDetail}")
                                              : MyStrings.notAvailable,
                                          style: FontUtil.customStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              textColor:
                                                  MyColors.boldTextColor),
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
                                              widget.subject?.assignments?.first
                                                          .endDate !=
                                                      null
                                                  ? " ${MyStrings.endDate}: ${widget.subject?.assignments?.first.endDate}"
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
