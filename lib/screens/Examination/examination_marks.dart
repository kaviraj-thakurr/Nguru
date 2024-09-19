import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/models/examMarksModel.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class ExaminationScreenMarks extends StatefulWidget {
  final ExamMarksModel? examinationmarksmodel;

  ExaminationScreenMarks({super.key, required this.examinationmarksmodel});

  @override
  State<ExaminationScreenMarks> createState() => _ExaminationScreenMarksState();
}

class _ExaminationScreenMarksState extends State<ExaminationScreenMarks> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              MyAssets.bg,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                children: [
                  dashboardAppBar(),
                  5.heightBox,
                  CustomSearchBar(controller: searchController),
                  12.heightBox,
                  screenTitleHeader(
                    "Examination",
                    onPressed: () => Navigator.pop(context),
                  ),
                  20.heightBox,
                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Subject",
                                      style: FontUtil.subHeader,
                                    ),
                                    Text(
                                      "Theory",
                                      style: FontUtil.subHeader,
                                    ),
                                    Text(
                                      "Practical",
                                      style: FontUtil.subHeader,
                                    ),
                                    Text(
                                      "Oral",
                                      style: FontUtil.subHeader,
                                    ),
                                    Text(
                                      "Project",
                                      style: FontUtil.subHeader,
                                    ),
                                  ],
                                ),


                                20.heightBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Subject Column
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // Text("Subject", style: FontUtil.subHeader),
                            10.heightBox,
                            ...widget.examinationmarksmodel?.examinationmarksmodel
                                    ?.map((marks) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(marks.subjectName ?? "", style: FontUtil.subName),
                                        ))
                                    .toList() ??
                                [],
                          ],
                        ),
                      ),
                      // Theory Column
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: MyColors.examMarksBg,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             //   Text("Theory", style: FontUtil.subHeader),
                                10.heightBox,
                                ...widget.examinationmarksmodel?.examinationmarksmodel
                                        ?.map((marks) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(
                                                marks.writtenObtainMarks != null
                                                    ? "${marks.writtenObtainMarks}/${marks.maxWrittenMarks}"
                                                    : "-",
                                                style: FontUtil.subMarks,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Practical Column
                      Expanded(
                        flex: 2,
                        child: Container(
                          
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             //   Text("Practical", style: FontUtil.subHeader),
                                10.heightBox,
                                ...widget.examinationmarksmodel?.examinationmarksmodel
                                        ?.map((marks) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(
                                                marks.practicalObtainMarks != null
                                                    ? "${marks.practicalObtainMarks}/${marks.maxPracticalMarks}"
                                                    : "-",
                                                style: FontUtil.subMarks,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Oral Column
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: MyColors.examMarksBg,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                           //     Text("Oral", style: FontUtil.subHeader),
                                10.heightBox,
                                ...widget.examinationmarksmodel?.examinationmarksmodel
                                        ?.map((marks) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(
                                                marks.oralObtainMarks != null
                                                    ? "${marks.oralObtainMarks}/${marks.maxOralMarks}"
                                                    : "-",
                                                style: FontUtil.subMarks,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Project Column
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            //  Text("Project", style: FontUtil.subHeader),
                              10.heightBox,
                              ...widget.examinationmarksmodel?.examinationmarksmodel
                                      ?.map((marks) => Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Text(
                                              marks.projectObtainMarks != null
                                                  ? "${marks.projectObtainMarks}/${marks.maxProjectMarks}"
                                                  : "-",
                                              style: FontUtil.subMarks,
                                            ),
                                          ))
                                      .toList() ??
                                  [],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
