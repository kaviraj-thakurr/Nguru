import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignments_list/assignment_list_state.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    context
        .read<AssignmentMonthListCubit>()
        .getAssignmentMonthList(todaysDate.month);

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
          _storyWidget(screenHeight, screenWidth, true,
              _circularAnimationController, "Circular", context),
          10.widthBox,
          _storyWidget(screenHeight, screenWidth, true,
              _disciplineAnimationController, "Discipline", context)
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
  }) {
     final assignmentCubit = BlocProvider.of<AssignmentListCubit>(context);

    log("subject list: ${subjectList?.length}");
    return GestureDetector(
      onTap: () async{
        
      
     

        if (!_isNavigating) {
          _isNavigating = true;
          if (animationController.isAnimating) {
            animationController.stop();
          } else {
            animationController.repeat(reverse: false);
          }
          

          if(title == "Assignment"){
            await assignmentCubit.getAssignmentList(todaysDate.month, "2024-08-14T00:00:00") ;
            Future.delayed(const Duration(seconds: 1)).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoryView(
                        isAssignmentWidget: true,
                        isGalleryWidget: false,
                        isCircularWidget: false,
                        isDisciplineWidget: false,
                        subjectList: subjectList ?? [],
                      )),
            ).then((_) {
              _isNavigating = false;
            });
            // _isNavigating=false;
            animationController.stop();
          });
          }

         else if(title == "Circular"){
            Future.delayed(const Duration(seconds: 1)).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoryView(
                      isCircularWidget: true,
                      isDisciplineWidget: false,
                        isAssignmentWidget: false,
                        isGalleryWidget: false,
                        subjectList: subjectList ?? [],
                      )),
            ).then((_) {
              _isNavigating = false;
            });
            // _isNavigating=false;
            animationController.stop();
          });
          }

         else if(title == "Discipline"){
            Future.delayed(const Duration(seconds: 1)).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoryView(
                    isDisciplineWidget: true,
                        isCircularWidget: true,
                        isAssignmentWidget: false,
                        isGalleryWidget: false,
                        subjectList: subjectList ?? [],
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
                child: const Center(
                  child: Text(
                      //  listData.isNotEmpty ? '${listData.length}'
                      //   :
                      '0'),
                ),
              ),
            ],
          ),
          AppGapping.padding3,
          InkWell(
            onTap: () {
              title == "Assignment"
                  ? NavigationService.navigateTo(AssignmentScreen(), context)
                  : title == "Circular"
                      ? NavigationService.navigateTo(CircularScreen(), context)
                      : NavigationService.navigateTo(
                          DisciplineScreen(), context);
            },
            child: Text(
              title,
              style: FontUtil.storyTitle,
            ),
          ),
        ],
      ),
    );
  }
}
