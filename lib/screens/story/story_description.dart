import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/circular/circular_detail/circular_detail_state.dart';
import 'package:nguru/logic/circular/circular_detail/curcular_detail_cubit.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/custom_download_file.dart';
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
  void initState() {
    context.read<CircularDetailsCubit>().getCurrentCircularDetails(circularID: widget.circularList?.circularId,circularNo: widget.circularList?.circularNo.toString());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isCircular
          ? BlocConsumer<CircularDetailsCubit,CircularDetailState>(
            listener: (context, state) {
              
            },
            builder: (context,state) {
              if(state is CircularDetailLoadingState){

              }

            else  if(state is CircularDetailSuccessState){

              return   GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: const Offset(0, 7), // Offset of the shadow
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(MyAssets.floatingActionDownloadButton),
                  ),
                  onTap: () => {
                       
                            onSaveWithDialogPressed(state.circularDetailList.contentData  ?? ""),
                          
                      });

              }

            else  if(state is CircularDetailErrorState){

              return const SizedBox.shrink();

              }

              return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: const Offset(0, 7), // Offset of the shadow
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(MyAssets.floatingActionDownloadButton),
                  ),
                  onTap: () => {
                       
                            // onSaveWithDialogPressed(
                            //     widget.circularList![_currentIndex].base64Image),
                          
                      });
            }
          ) : const SizedBox(),
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