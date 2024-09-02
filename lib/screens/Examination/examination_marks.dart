import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/models/examMarksModel.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class ExaminationScreenMarks extends StatefulWidget {
  
  ExamMarksModel ? examinationmarksmodel;

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Column(
                              children: [
                                // Header row for the table
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
                                // Marks rows
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.examinationmarksmodel?.examinationmarksmodel?.length,

                                  itemBuilder: (context, index) {
                                    final marks = widget.examinationmarksmodel?.examinationmarksmodel?.elementAt(index);
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          marks?.subjectName ?? "",
                                          style: FontUtil.subName,
                                        ),
                                        Text(
                                          "${marks?.writtenObtainMarks}/${marks?.maxWrittenMarks}",
                                          style: FontUtil.subMarks,
                                        ),
                                        Text(
                                          "${marks?.practicalObtainMarks}/${marks?.practicalObtainMarks}",
                                          style: FontUtil.subMarks,
                                        ),
                                        Text(
                                          "${marks?.oralObtainMarks}/${marks?.maxOralMarks}",
                                          style: FontUtil.subMarks,
                                        ),
                                        Text(
                                          "${marks?.practicalObtainMarks}/${marks?.maxProjectMarks}",
                                          style: FontUtil.subMarks,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                    ]
                  )
                    ]
                  )
                                )
            )
        
  ]
  )
          );
                
                          }

                        
}         
