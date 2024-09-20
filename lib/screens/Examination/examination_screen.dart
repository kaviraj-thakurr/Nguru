import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/examination/exam_marks/exam_marks_cubit.dart';
import 'package:nguru/logic/examination/exam_marks/exam_marks_state.dart';
import 'package:nguru/logic/examination/exam_sehedule/exam_sehedule_cubit.dart';
import 'package:nguru/logic/examination/exam_sehedule/exam_sehedule_state.dart';
import 'package:nguru/logic/examination/report_card/report_card_cubit.dart';
import 'package:nguru/logic/examination/report_card/report_card_state.dart';
import 'package:nguru/models/exam_sehedule_model.dart';
import 'package:nguru/screens/Examination/examination_marks.dart';
import 'package:nguru/screens/Examination/examination_schedule_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/examMarksModel.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  // List of categories
  List<String> buttons = ["Report Cards", "Schedule", "Exam Marks"];

  // Initially selected category
  int selectedCategoryIndex = 0;

  // List of data for each category (this can be populated with API data or dynamic content)

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    context.read<ExamScheduleListCubit>().getScheduleList();
    context.read<ReportCardListCubit>().getReportCardList();
    context.read<ExamMarksListCubit>().getExamMarks();
    super.initState();
  }

  String removeHttpPrefix(String url) {
    if (url.startsWith('http://')) {
      return url.replaceAll('http://', '');
    }
    return url;
  }

  void launchBrowser(String? url) async {
    if (url != null && selectedCategoryIndex == 0) {
      try {
        Uri link = Uri(scheme: 'http', path: removeHttpPrefix(url));
        await launchUrl(link, mode: LaunchMode.externalApplication);
        print(link);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              MyAssets.bg,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(padding18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               10.heightBox,
                              dashboardAppBar(),
                              CustomSearchBar(controller: searchController),
                              10.heightBox,
                screenTitleHeader("Examination",
                    onPressed: () => Navigator.pop(context)),
            
                5.heightBox,
            
                // Category selector
                buildSelector(buttons, selectedCategoryIndex, (int index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                }),
                10.heightBox,
            
                // List of items based on the selected category
                Expanded(
                  child: Builder(builder: (context) {
                    if (selectedCategoryIndex == 1) {
                      return BlocBuilder<ExamScheduleListCubit,
                          ExamScheduleListState>(
                        builder: (context, state) {
                          if (state is ExamScheduleListLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ExamScheduleListSuccessState) {
                            return ListView.builder(
                              itemCount: state.scheduleModel
                                      .examinationschedulemodel?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return timeCard1(
                                        context: context,
                                        scheduleModel: state.scheduleModel,
                                        subject: state.scheduleModel
                                                .examinationschedulemodel
                                                ?.elementAt(index)
                                                .examName ??
                                            "",
                                        selectedCategoryIndex:
                                            selectedCategoryIndex,
                                        onTap: () {
                                          if (selectedCategoryIndex == 1) {
                                            NavigationService.navigateTo(
                                                ExamSchedule(
                                                  scheduleModel:
                                                      state.scheduleModel,
                                                  subjectName: state
                                                      .scheduleModel
                                                      ?.examinationschedulemodel?[
                                                          index]
                                                      .subjectName,
                                                  examDate: state
                                                      .scheduleModel
                                                      ?.examinationschedulemodel?[
                                                          index]
                                                      .examdate,
                                                ),
                                                context);
                                          }
                                        })
                                    .pSymmetric(
                                        v: 8); // Padding between cards
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else if (selectedCategoryIndex == 0) {
                      return BlocBuilder<ReportCardListCubit,
                          ReportCardListState>(
                        builder: (context, state) {
                          if (state is ReportCardListLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ReportCardListSuccessState) {
                            return ListView.builder(
                              itemCount:
                                  state.reportCardModel.report?.length ?? 0,
                              itemBuilder: (context, index) {
                                return timeCard1(
                                  context: context,
                                  url: state.reportCardModel.report
                                          ?.elementAt(index)
                                          .reportUrl ??
                                      "",
                                  subject: state.reportCardModel.report
                                          ?.elementAt(index)
                                          .reportName ??
                                      "",
                                  selectedCategoryIndex:
                                      selectedCategoryIndex,
                                  onTap: () {
                                    if (selectedCategoryIndex == 0) {
                                      return launchBrowser(state
                                          .reportCardModel
                                          .report?[index]
                                          .reportUrl);
                                    }
                                  },
                                ).pSymmetric(v: 8); // Padding between cards
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else if (selectedCategoryIndex == 2) {
                      return BlocBuilder<ExamMarksListCubit,
                          ExamMarksListState>(
                        builder: (context, state) {
                          if (state is ExamMarksListLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ExamMarksListSuccessState) {
                            return ListView.builder(
                              itemCount: state.examMarksModel
                                      .examinationmarksmodel?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return timeCard1(
                                        context: context,
                                        examinationmarksmodel:
                                            state.examMarksModel,
                                        subject: state.examMarksModel
                                                .examinationmarksmodel
                                                ?.elementAt(index)
                                                .examName ??
                                            "",
                                        selectedCategoryIndex:
                                            selectedCategoryIndex,
                                        onTap: () {
                                          if (selectedCategoryIndex == 2) {
                                            NavigationService.navigateTo(
                                                ExaminationScreenMarks(
                                                    examinationmarksmodel:
                                                        state.examMarksModel),
                                                context);
                                          }
                                        })
                                    .pSymmetric(
                                        v: 8); // Padding between cards
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No data available for this category.'),
                      );
                    }
                  }),
                ),
              ],
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
    String? url,
    String? examID,
    required int selectedCategoryIndex,
    ExamMarksModel? examinationmarksmodel,
    ScheduleModel? scheduleModel,
    required void Function() onTap,
    required BuildContext context,
  }) {
    String removeHttpPrefix(String url) {
      if (url.startsWith('http://')) {
        return url.replaceAll('http://', '');
      }
      return url;
    }

    void launchBrowser(String? url) async {
      if (url != null && selectedCategoryIndex == 0) {
        try {
          Uri link = Uri(scheme: 'http', path: removeHttpPrefix(url));
          await launchUrl(link, mode: LaunchMode.externalApplication);
          print(link);
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }

    String iconAsset = '';
    if (selectedCategoryIndex == 1) {
      iconAsset = MyAssets.examDown; // Example icon for Schedule category
    } else if (selectedCategoryIndex == 2) {
      iconAsset = MyAssets.homeIcon; // Example icon for Exam Marks category
    } else {
      iconAsset = MyAssets.callIcon; // Example icon for Report Cards category
    }

    return Container(
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
                fontSize: 14.h,
                fontWeight: FontWeight.w500,
                textColor: MyColors.addButtonColor,
              ),
            ),
                          const  SizedBox(height: 2),
            Text(
              term ?? "",
              style: FontUtil.customStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textColor: MyColors.teacherNameColor,
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(
                selectedCategoryIndex == 0
                    ? Icons.arrow_downward
                    : selectedCategoryIndex == 1
                        ? Icons.arrow_forward
                        : Icons.arrow_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for building the category selector
Widget buildSelector(List<String> selecterItems, int selectedIndex,
    Function(int) onCategorySelected) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(right: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: selecterItems.map((category) {
        int index = selecterItems.indexOf(category);
        bool isSelected = index == selectedIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            onTap: () => onCategorySelected(index),
            child: isSelected
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return MyColors.buttonColors.createShader(bounds);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        category,
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                          textColor: MyColors.monthNameColor,
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      category,
                      style: FontUtil.customStyle(
                        fontSize: 10,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.w400,
                        textColor: MyColors.monthNameColor,
                      ),
                    ),
                  ),
          ),
        );
      }).toList(),
    ),
  );
}
