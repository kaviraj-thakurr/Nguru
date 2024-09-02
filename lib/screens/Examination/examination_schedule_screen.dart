import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/models/exam_sehedule_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamSchedule extends StatefulWidget {
  final ScheduleModel? scheduleModel;
  final String ? subjectName;
  final String ? examDate;

  ExamSchedule({super.key, required this.scheduleModel, this.subjectName,this.examDate});

  @override
  State<ExamSchedule> createState() => _ExaminationScreenMarksState();
}

class _ExaminationScreenMarksState extends State<ExamSchedule> {
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
                  timeCard1(subject: widget.examDate??"",term: widget.subjectName??"", context: context)
              
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeCard1({
    required String subject,
    String? term,
    String? time,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.092,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.searchBox,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: FontUtil.customStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.addButtonColor,
                ),
              ),
              SizedBox(height: 2),
              Text(
                term ?? "",
                textAlign:TextAlign.right ,
                style: FontUtil.customStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.subHeader,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
