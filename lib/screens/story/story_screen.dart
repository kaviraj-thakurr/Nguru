import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_state.dart';
import 'package:nguru/logic/assignment/assignments_list/assignment_list_state.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'package:nguru/logic/circular/circular_cubit.dart';
import 'package:nguru/logic/circular/circular_state.dart';
import 'package:nguru/logic/descipline/descipline_cubit.dart';
import 'package:nguru/logic/descipline/descipline_state.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/screens/story/assignment_story_screen.dart';
import 'package:nguru/screens/story/circular_story_screen.dart';
import 'package:nguru/screens/story/discipline_story_screen.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/border_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:velocity_x/velocity_x.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with TickerProviderStateMixin {
  late final AnimationController _assignmentAnimationController;
  late final AnimationController _circularAnimationController;
  late final AnimationController _disciplineAnimationController;
  late final StoryController _storyController = StoryController();

  int todaysDate = DateTime.now().day;
  bool todayAssignmentAdded = false;

    Future<void> requestPermissions() async {

var permission=await Permission.storage.request();
      

  if (await Permission.storage.request().isGranted) {
     log("gained");
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    await openAppSettings();
  } else if (await Permission.storage.request().isDenied) {
     log("denied");
  
  }

}

Future<void> generateAndSavePDF(String textContent) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text(textContent),
      ),
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/example.pdf');

  await file.writeAsBytes(await pdf.save());
  print('PDF saved to ${file.path}');
}


  @override
  void initState() {
    super.initState();
    context.read<AssignmentMonthListCubit>().getAssignmentMonthList();

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
    context.read<AssignmentListCubit>().getAssignmentList();
    context.read<CircularCubit>().getCircular();
    context.read<DisciplineCubit>().getDiscipline();
  }

  @override
  void dispose() {
    _assignmentAnimationController.dispose();
    _circularAnimationController.dispose();
    _disciplineAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return 
       Container(
        width: double.infinity,
        height: screenHeight*0.11,
        child: BlocConsumer<AssignmentMonthListCubit, AssignmentMonthListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AssignmentMonthListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssignmentMonthListSuccessState) {
              for (var assignment in state.assignmentMonthList) {
                if (assignment.calendarDate.day == todaysDate && assignment.assignmentStatus == 1) {
                  todayAssignmentAdded = true;
                }
              }
      
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _storyWidget<AssignmentListCubit, AssignmentListState, SubjectList>(
                    screenHeight,
                    screenWidth,
                    todayAssignmentAdded,
                    context.read<AssignmentListCubit>(),
                    _assignmentAnimationController,
                    (list) => showAssignmentStory(screenHeight, screenWidth, list),
                    'Assignment',
                  ),
                  15.widthBox,
                  _storyWidget<CircularCubit, CircularState, CircularList>(
                    screenHeight,
                    screenWidth,
                    todayAssignmentAdded,
                    context.read<CircularCubit>(),
                    _circularAnimationController,
                    (list) => showCircularStory(screenHeight, screenWidth, list),
                    'Circular',
                  ),
                  15.widthBox,
                  _storyWidget<DisciplineCubit, DisciplineState, DisciplineList>(
                    screenHeight,
                    screenWidth,
                    todayAssignmentAdded,
                    context.read<DisciplineCubit>(),
                    _disciplineAnimationController,
                    (list) => showDisciplineStory(screenHeight, screenWidth, list),
                    'Discipline',
                  ),
                ],
              );
            } else if (state is AssignmentMonthListErrorState) {
              return const Center(child: Text("Error state"));
            } else {
              return const Center(child: Text("Undefined state"));
            }
          },
        ),
      );
  }

  Widget _storyWidget<C extends Cubit<S>, S, T>(
    double screenHeight,
    double screenWidth,
    bool isColorGradient,
    C cubit,
    AnimationController animationController,
    Widget Function(List<T>) showStoryScreen,
    String title,
  ) {
    return BlocBuilder<C, S>(
      bloc: cubit,
      builder: (context, state) {
        if (state is AssignmentListLoadingState ||
            state is CircularLoadingState ||
            state is DisciplineLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AssignmentListSuccessState || state is CircularSuccessState || state is DisciplineSuccessState) {
          final List<T> listData = (state is AssignmentListSuccessState)
              ? state.subjectList.cast<T>()
              : (state is CircularSuccessState)
                  ? state.circularList.cast<T>()
                  : (state is DisciplineSuccessState)
                      ? state.disciplineList.cast<T>()
                      : [];

          return GestureDetector(
            onTap: () {
              if (listData.isNotEmpty) {
                if (animationController.isAnimating) {
                  animationController.stop();
                } else {
                  animationController.repeat(reverse: false);
                }

                Future.delayed(const Duration(seconds: 1)).then((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => showStoryScreen(listData)),
                  );
                  animationController.stop();
                });
              }
            },
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      painter: AnimatedBorderPainter(
                        gradientColors:listData.isNotEmpty ? [MyColors.appColorBlue, MyColors.appColorGreen] :  [MyColors.greyShade_3, MyColors.greyShade_4],
                        gapSize: 0,
                        radius: 150,
                        strokeWidth: 3,
                        animation: CurvedAnimation(
                          parent: Tween(begin: 0.0, end: 1.0).animate(animationController),
                          curve: Curves.linear,
                        ),
                        colorStops: [-4, 8],
                      ),
                      child: const SizedBox(width: 60, height: 60),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 221, 240),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(listData.isNotEmpty ? '${listData.length}' : 'N/A'),
                      ),
                    ),
                  ],
                ),
                Text(title),
              ],
            ),
          );
        } else if (state is AssignmenListErrorState || state is CircularErrorState || state is DisciplineErrorState) {
          return const Center(child: Text("Error state"));
        } else {
          return const Center(child: Text("Undefined state"));
        }
      },
    );
  }

  Widget showAssignmentStory(double screenHeight, double screenWidth, List<SubjectList> subjectList) {
    final stoyItems = subjectList
        .map((subject) => StoryItem(AssignmentStoryScreen(subject: subject, storyController: _storyController), duration: const Duration(seconds: 3)))
        .toList();

    return StoryView(
      indicatorForegroundColor: MyColors.appColorBlue,
      storyItems: stoyItems,
      controller: _storyController,
      repeat: true,
      onComplete: () {},
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget showCircularStory(double screenHeight, double screenWidth, List<CircularList> circularList) {
    final stoyItems = circularList
        .map((circular) => StoryItem(CircularStoryScreen(circularList: circular, storyController: _storyController), duration: const Duration(seconds: 3)))
        .toList();

    return StoryView(
      indicatorForegroundColor: MyColors.appColorBlue,
      storyItems: stoyItems,
      controller: _storyController,
      repeat: true,
      onComplete: () {},
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget showDisciplineStory(double screenHeight, double screenWidth, List<DisciplineList> disciplineList) {
    final stoyItems = disciplineList
        .map((discipline) => StoryItem(DisciplineStoryScreen(disciplineList: discipline, storyController: _storyController), duration: const Duration(seconds: 3)))
        .toList();

    return StoryView(
      indicatorForegroundColor: MyColors.appColorBlue,
      storyItems: stoyItems,
      controller: _storyController,
      repeat: true,
      onComplete: () {},
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Navigator.pop(context);
        }
      },
    );
  }
}
