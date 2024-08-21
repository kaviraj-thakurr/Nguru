import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignments_list/assignment_list_state.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'package:nguru/logic/circular/circular_cubit.dart';
import 'package:nguru/logic/circular/circular_state.dart';
import 'package:nguru/logic/discipline/descipline_cubit.dart';
import 'package:nguru/logic/discipline/descipline_state.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/screens/assignment_screen.dart';
import 'package:nguru/screens/circular_screen.dart';
import 'package:nguru/screens/discipline_screen.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/border_painter.dart';
import 'package:nguru/utils/story.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with TickerProviderStateMixin {
  late final AnimationController _assignmentAnimationController;
  late final AnimationController _circularAnimationController;
  late final AnimationController _disciplineAnimationController;
  late final StoryController _storyController = StoryController();
  List<SubjectList> subjectList = [];
  List<CircularList> circularList = [];
  List<DisciplineList> disciplineList = [];

  DateTime todaysDate = DateTime.now();
  bool todayAssignmentAdded = false;
  bool _isNavigating = false;
  DateTime focusedDay = DateTime.now();
  final int currentDate = DateTime.now().month;
  DateTime selectedDate = DateTime(2024, 8, 14);
  DateTime selectedDateForDiscipline = DateTime(2024, 8, 6);

  @override
  void initState() {
    super.initState();

    _assignmentAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _circularAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _disciplineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Trigger fetching the lists
    //  context.read<AssignmentListCubit>().getAssignmentList(todaysDate.month,DateFormat('yyyy-MM-ddTHH:mm:ss').format(todaysDate).toString());
    //  context.read<CircularCubit>().getCurrentCircular();
    //  context.read<DisciplineCubit>().getDiscipline(type: 0);

    context
        .read<AssignmentListCubit>()
        .getAssignmentList(todaysDate.month, "2024-08-14T00:00:00");

    context.read<CircularCubit>().getCurrentCircular(month: 8);

    context
        .read<AssignmentMonthListCubit>()
        .getAssignmentMonthList(todaysDate.month);
    context.read<DisciplineCubit>().getDiscipline(type: 0);
    // .then((value) =>
    // context
    //     .read<DisciplineCubit>()
    //     .filterDisciplineListByDate(focusedDay, false));
  }

  @override
  void dispose() {
    // _assignmentAnimationController.dispose();
    // _circularAnimationController.dispose();
    //  _disciplineAnimationController.dispose();
    super.dispose();
  }

//////////////////////////////////// new custom story /////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocConsumer<AssignmentListCubit, AssignmentListState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is AssignmentListLoadingState) {
                  return _storyWidget(screenHeight, screenWidth, true,
                      _assignmentAnimationController, "Assignment", context);
                } else if (state is AssignmentListSuccessState) {
                  return _storyWidget(screenHeight, screenWidth, true,
                      _assignmentAnimationController, "Assignment", context,
                      subjectList: state.subjectList);
                } else if (state is AssignmentListErrorState) {
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              }),
          10.widthBox,
          BlocConsumer<CircularCubit, CircularState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CircularLoadingState) {
                  return _storyWidget(screenHeight, screenWidth, true,
                      _circularAnimationController, "Circular", context);
                } else if (state is CircularSuccessState) {
                  List<CircularList> circularList = state.circularList
                      .where((item) =>
                          DateFormat("dd-MMM-yyyy")
                                  .parse(item.circularDate!)
                                  .year ==
                              selectedDate.year &&
                          DateFormat("dd-MMM-yyyy")
                                  .parse(item.circularDate!)
                                  .month ==
                              selectedDate.month &&
                          DateFormat("dd-MMM-yyyy")
                                  .parse(item.circularDate!)
                                  .day ==
                              selectedDate.day)
                      .toList();
                  log("list count of circular :$circularList");
                  return _storyWidget(screenHeight, screenWidth, true,
                      _circularAnimationController, "Circular", context,
                      circularList: circularList);
                } else if (state is CircularErrorState) {
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              }),
          10.widthBox,
          BlocConsumer<DisciplineCubit, DisciplineState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DisciplineLoadingState) {
                  return _storyWidget(screenHeight, screenWidth, true,
                      _disciplineAnimationController, "Discipline", context);
                } else if (state is DisciplineSuccessState) {
                  List<DisciplineList> disciplineList = state.disciplineList
                      .where((item) =>
                          DateFormat("dd/MM/yyyy")
                                  .parse(item.actionDate!)
                                  .year ==
                              selectedDateForDiscipline.year &&
                          DateFormat("dd/MM/yyyy")
                                  .parse(item.actionDate!)
                                  .month ==
                              selectedDateForDiscipline.month &&
                          DateFormat("dd/MM/yyyy")
                                  .parse(item.actionDate!)
                                  .day ==
                              selectedDateForDiscipline.day)
                      .toList();

                  log("discipline non filter list: $disciplineList");
                  return _storyWidget(screenHeight, screenWidth, true,
                      _disciplineAnimationController, "Discipline", context,
                      disciplineList: disciplineList);
                } else if (state is DisciplineFilteredState) {
                  List<DisciplineList> filteredList = state.filteredList
                      .where((item) =>
                          DateFormat("dd/MM/yyyy")
                                  .parse(item.actionDate!)
                                  .year ==
                              selectedDateForDiscipline.year &&
                          DateFormat("dd/MM/yyyy")
                                  .parse(item.actionDate!)
                                  .month ==
                              selectedDateForDiscipline.month &&
                          DateFormat("dd/MM/yyyy")
                                  .parse(item.actionDate!)
                                  .day ==
                              selectedDateForDiscipline.day)
                      .toList();

                  log("discipline filter list: $filteredList");

                  return _storyWidget(screenHeight, screenWidth, true,
                      _disciplineAnimationController, "Discipline", context,
                      disciplineList: filteredList);
                } else if (state is AssignmentListErrorState) {
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
    );
  }

  Widget _storyWidget(
    double screenHeight,
    double screenWidth,
    bool isColorGradient,
    AnimationController animationController,
    String title,
    context, {
    List<SubjectList>? subjectList,
    List<CircularList>? circularList,
    List<DisciplineList>? disciplineList,
  }) {
    final assignmentCubit = BlocProvider.of<AssignmentListCubit>(context);
    final circularCubit = BlocProvider.of<CircularCubit>(context);
    final disciplineCubit = BlocProvider.of<DisciplineCubit>(context);

    log("subject list: ${subjectList?.length}");
    return GestureDetector(
      onTap: () async {
        if (!_isNavigating) {
          _isNavigating = true;
          if (animationController.isAnimating) {
            animationController.stop();
          } else {
            animationController.repeat(reverse: false);
          }

          if (title == "Assignment") {
            await assignmentCubit.getAssignmentList(
                todaysDate.month, "2024-08-14T00:00:00");

            BlocConsumer<AssignmentListCubit, AssignmentListState>(
                listener: (context, state) {
              if (state is AssignmentListLoadingState) {
                null;
              } else if (state is AssignmentListSuccessState) {
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoryView(
                              isAssignmentWidget: true,
                              isGalleryWidget: false,
                              isCircularWidget: false,
                              isDisciplineWidget: false,
                              subjectList: state.subjectList ?? [],
                              circularList: [],
                              disciplineList: [],
                            )),
                  ).then((_) {
                    _isNavigating = false;
                  });
                  // _isNavigating=false;
                  animationController.stop();
                });
              } else if (state is AssignmentListErrorState) {
              } else {}
            }, builder: (context, state) {
              return SizedBox();
            });

            Future.delayed(const Duration(seconds: 1)).then((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryView(
                          isAssignmentWidget: true,
                          isGalleryWidget: false,
                          isCircularWidget: false,
                          isDisciplineWidget: false,
                          subjectList: subjectList,
                          circularList: [],
                          disciplineList: [],
                        )),
              ).then((_) {
                _isNavigating = false;
              });
              // _isNavigating=false;
              animationController.stop();
            });
          } else if (title == "Circular") {
            await circularCubit.getCurrentCircular(month: 8);

            Future.delayed(const Duration(seconds: 1)).then((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryView(
                          isAssignmentWidget: false,
                          isGalleryWidget: false,
                          isCircularWidget: true,
                          isDisciplineWidget: false,
                          subjectList: [],
                          circularList: circularList ?? [],
                          disciplineList: [],
                        )),
              ).then((_) {
                _isNavigating = false;
              });
              // _isNavigating=false;
              animationController.stop();
            });
          } else if (title == "Discipline") {
            disciplineCubit.getDiscipline();
            Future.delayed(const Duration(seconds: 1)).then((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryView(
                          isAssignmentWidget: false,
                          isGalleryWidget: false,
                          isCircularWidget: false,
                          isDisciplineWidget: true,
                          subjectList: [],
                          circularList: [],
                          disciplineList: disciplineList ?? [],
                        )),
              ).then((_) {
                _isNavigating = false;
              });
              // _isNavigating=false;
              animationController.stop();
            });
          }
        }
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: AnimatedBorderPainter(
                  gradientColors:
                      // listData.isNotEmpty
                      //    ?
                      [MyColors.appColorBlue, MyColors.appColorGreen],
                  // :
                  //  [MyColors.greyShade_3, MyColors.greyShade_4],
                  gapSize: 0,
                  radius: 150,
                  strokeWidth: 3,
                  animation: CurvedAnimation(
                    parent: Tween(begin: 0.0, end: 1.0)
                        .animate(animationController),
                    curve: Curves.linear,
                  ),
                  colorStops: [-4, 8],
                ),
                child: const SizedBox(width: 55, height: 55),
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: title == "Assignments"
                      ? MyColors.assignmentColor
                      : title == "Circular"
                          ? MyColors.circularColor
                          : MyColors.disciplineColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child:  Center(
                  child: Text(
                      //  listData.isNotEmpty ? '${listData.length}'
                      //   :
                    title=="Assignment" ? '${subjectList?.length ?? ""}'
                    :  title=="Circular" ? '${circularList?.length ?? ""}'
                    :  title=="Discipline" ? '${disciplineList?.length ?? ""}'
                    :  
                      'N/A'
                     ),
                ),
              ),
            ],
          ),
          AppGapping.padding3,
          Text(
            title,
            style: FontUtil.storyTitle,
          ),
        ],
      ),
    );
  }
}
