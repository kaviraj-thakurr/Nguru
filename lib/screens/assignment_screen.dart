import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/screens/assignment_calendar.dart';
import 'package:nguru/screens/story/story_description.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/logic/assignment/assignments_list/assignment_list_state.dart';
import 'package:nguru/utils/custom_download_file.dart';
import 'package:nguru/utils/remove_html_tags.dart';
import 'package:velocity_x/velocity_x.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context
        .read<AssignmentMonthListCubit>()
        .getAssignmentMonthList(currentDate.month);
  }

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
            padding: const EdgeInsets.all(padding20),
            child: Column(children: [
              10.heightBox,
              dashboardAppBar(),
              10.heightBox,
              screenTitleHeader("Assignment",
                  onPressed: () => Navigator.pop(context)),
              20.heightBox,
              assignmentCalendar(),
              Expanded(
                child: BlocBuilder<AssignmentListCubit, AssignmentListState>(
                  builder: (context, state) {
                    if (state is AssignmentListLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AssignmentListSuccessState) {
                      if (state.subjectList.isEmpty) {
                        return Center(
                            child: Column(
                          children: [
                            160.heightBox,
                            SvgPicture.asset(
                              MyAssets.noDataFound,
                              height: height150,
                            ),
                            5.heightBox,
                            Text(
                              MyStrings.assignmentTitle,
                              style: FontUtil.customStyle(
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: APP_FONT,
                                  textColor: MyColors.noDataFoundTitle),
                            ),
                            Text(
                              MyStrings.assignmentSub,
                              style: FontUtil.customStyle(
                                  fontSize: 10.h,
                                  fontWeight: FontWeight.w400,
                                  textColor: MyColors.noDataFoundSubtitle),
                            )
                          ],
                        ));
                      }
                      return PageView.builder(
                        controller: _pageController,
                        itemCount: state.subjectList.length,
                        onPageChanged: (index) {},
                        itemBuilder: (context, index) {
                           final subjects = state.subjectList;
                        
                          return ListView.builder(
                          //  physics: const NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                            itemCount: subjects.length,
                            itemBuilder: (context,index) {
                                final assignments = state.subjectList[index];
                              return ListView.builder(
                                itemCount: assignments.assignments?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final assignment = assignments.assignments![index];
                                  return 
                                  Padding(
                                    padding: const EdgeInsets.all(padding3),
                                    child: 
                                    cardDesign(
                                        context,
                                        assignment.assignmentName,
                                        assignments.subjectName,
                                        removeHtmlTags(
                                            "${assignment.assignmentDetail}"),
                                        assignment.assignmentDate,
                                        assignment),
                                  );
                                },
                              );
                            }
                          );
                        },
                      );
                    } else if (state is AssignmentListErrorState) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text(MyStrings.undefinedState));
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget cardDesign(BuildContext context, String? title, String? subject,
    String? description, String? date, Assignment? assignment) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  final buttonWidth = screenWidth * 0.25;
  final buttonHeight = screenHeight * 0.03;
  return Container(
    height: screenHeight * 0.140,
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius8),
      color: MyColors.searchBackGroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(padding8),
      child: Row(
        children: [
          Image.asset(MyAssets.books, height: height80),
          10.widthBox,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: FontUtil.circularTitle,
                ),
                Text(
                  subject ?? "",
                  style: FontUtil.circularSubtitle,
                ),
                Text(
                  description ?? "",
                  style: FontUtil.circularSubtitle,
                  maxLines: 1,
                ),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: buttonWidth,
                      height: buttonHeight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: paddingHorizontal2),
                      padding: const EdgeInsets.all(padding1),
                      decoration: const BoxDecoration(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: MyColors.assignmentDate,
                          borderRadius: BorderRadius.circular(borderRadius5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(padding5),
                              child: Text(
                                date ?? "",
                                style: TextStyle(
                                  color: MyColors.assignmentDateColor,
                                  fontSize: 12.h,
                                ),
                              ),
                            ),
                            8.widthBox
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => {
                              assignment?.fileContent != null
                                  ? onSaveWithDialogPressed(
                                      assignment?.fileContent ?? "")
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoryDescription(
                                                isCircular: false,
                                                isAssignment: true,
                                                isDiscipline: false,
                                                circularList: null,
                                                assignmentList: assignment,
                                                disciplineList: null,
                                              ))),
                            },
                        child: assignment?.fileContent != null
                            ? SvgPicture.asset(
                                MyAssets.downloadIcon,
                                height: 25,
                                width: 25,
                              )
                            : SvgPicture.asset(
                                MyAssets.seen,
                                height: 18,
                                width: 18,
                                color: MyColors.greyShade_7,
                              )),
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
