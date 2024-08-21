import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/remove_html_tags.dart';
import 'package:velocity_x/velocity_x.dart';

class StoryDescription extends StatefulWidget {
  final bool isAssignment;
  final bool isCircular;
  final bool isDiscipline;
  final Assignment? assignmentList;
  final CircularList? circularList;
  final DisciplineList? disciplineList;
  const StoryDescription({
    super.key, 
    required this.isAssignment,
     required this.isCircular,
      required this.isDiscipline,
       required this.assignmentList,
        required this.circularList,
         required this.disciplineList
         });

  @override
  State<StoryDescription> createState() => _StoryDescriptionState();
}

class _StoryDescriptionState extends State<StoryDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  screenTitleHeader("Description", onPressed: ()=> Navigator.pop(context)),
                  250.heightBox,
                  widget.isAssignment ?
                  assignmentDscriptionWidget(context, widget.assignmentList)
                  
                  : widget.isCircular ?
                  circularDscriptionWidget(context, widget.circularList)
                  : widget.isDiscipline ?
                  disciplineDscriptionWidget(context, widget.disciplineList)

                  : const SizedBox()

                ],
              ),
            ),
          ),
        ],
      )
      );
  }
}




Widget disciplineDscriptionWidget(BuildContext context, DisciplineList? disciplineList){
  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Teacher Name: ${disciplineList?.teacherName ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 20, fontWeight: FontWeight.w600, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text("Reason: ${removeHtmlTags(disciplineList?.reason?? "") ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text("Date: ${disciplineList?.actionDate ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text(" Points: ${disciplineList?.points  ?? "N/A"} ${disciplineList?.pointsType}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                       
                      ],
                    ),
                  );
}







Widget circularDscriptionWidget(BuildContext context, CircularList? circularList){
  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Subject: ${circularList?.subject ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 20, fontWeight: FontWeight.w600, textColor: MyColors.fadedTextColor),
                        textAlign: TextAlign.center,
                        ),
                        10.heightBox,
                        Text("Circular description: ${circularList?.description ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text("No of circulars: ${circularList?.noOfcirculars ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text(" Date: ${circularList?.circularDate ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                       
                      ],
                    ),
                  );
}




Widget assignmentDscriptionWidget(BuildContext context, Assignment? assignment){
  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Assignment Name: ${assignment?.assignmentName ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 20, fontWeight: FontWeight.w600, textColor: MyColors.fadedTextColor),
                        textAlign: TextAlign.center,
                        ),
                        10.heightBox,
                        Text("Assignment Details: ${removeHtmlTags(assignment?.assignmentDetail?? "") ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        textAlign: TextAlign.center,
                        ),
                        10.heightBox,
                        Text("File Description: ${assignment?.fileDescription ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text("Start Date: ${assignment?.startDate ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        ),
                        10.heightBox,
                        Text("End Date: ${assignment?.endDate ?? "N/A"}",
                        style: FontUtil.customStyle(fontSize: 16, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),
                        )
                      ],
                    ),
                  );
}