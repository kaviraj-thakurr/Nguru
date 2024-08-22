import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/screens/assignment_screen.dart';
import 'package:nguru/screens/circular_screen.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/discipline_screen.dart';
import 'package:nguru/screens/story/story_description.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/custom_download_file.dart';
import 'package:nguru/utils/remove_html_tags.dart';
import 'package:velocity_x/velocity_x.dart';

/// Story class represents a single story item
class Story {
  final String base64Image;
  final Duration? duration;

  Story({required this.base64Image, this.duration});
}

/// StoryView class manages the overall story view
class StoryView extends StatefulWidget {
  final List<Story>? stories;
  final bool isGalleryWidget;
  final bool isAssignmentWidget;
  final bool isCircularWidget;
  final bool isDisciplineWidget;
  final List<SubjectList>? subjectList;
  final List<CircularList>? circularList;
  final List<DisciplineList>? disciplineList;

  const StoryView({
    super.key,
    this.stories,
    required this.isGalleryWidget,
    required this.isAssignmentWidget,
    required this.isCircularWidget,
    required this.isDisciplineWidget,
    this.subjectList,
    this.circularList,
    this.disciplineList,
  });

  @override
  StoryViewState createState() => StoryViewState();
}

class StoryViewState extends State<StoryView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeAnimationController();
  }

  void _initializeAnimationController() {
    if (widget.isGalleryWidget) {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.stories?[_currentIndex].duration ??
            const Duration(seconds: 3),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _nextStory();
          }
        });
    } else if (widget.isAssignmentWidget) {
      _animationController = AnimationController(
        vsync: this,
        duration:
            //  widget.subjectList[_currentIndex].duration ??
            const Duration(seconds: 3),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _nextStory();
          }
        });
    } else if (widget.isCircularWidget) {
      _animationController = AnimationController(
        vsync: this,
        duration:
            //  widget.subjectList[_currentIndex].duration ??
            const Duration(seconds: 3),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _nextStory();
          }
        });
    } else if (widget.isDisciplineWidget) {
      _animationController = AnimationController(
        vsync: this,
        duration:
            //  widget.subjectList[_currentIndex].duration ??
            const Duration(seconds: 3),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _nextStory();
          }
        });
    }

    _animationController.forward();
  }

  void _nextStory() {
    if (widget.isGalleryWidget) {
      if (_currentIndex < widget.stories!.length - 1) {
        setState(() {
          _currentIndex++;
        });
        _animationController.reset(); // Reset the controller
        _animationController.duration =
            widget.stories?[_currentIndex].duration ??
                const Duration(seconds: 3);
        _animationController.forward(); // Restart the animation
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        //  _animationController.dispose();
          //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen())); // Close the StoryView when done
     Navigator.pop(context);
      }
    } else if (widget.isAssignmentWidget) {
      if (widget.subjectList!.isEmpty) {
        if (_currentIndex < 1) {
          setState(() {
            _currentIndex++;
          });
          _animationController.reset(); // Reset the controller
          _animationController.duration =
              //  widget.subjectList![_currentIndex].duration ??
              const Duration(seconds: 3);
          _animationController.forward(); // Restart the animation
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          //  _animationController.dispose();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen())); // Close the StoryView when done
        }
      } else {
        if (_currentIndex < widget.subjectList!.length - 1) {
          setState(() {
            _currentIndex++;
          });
          _animationController.reset(); // Reset the controller
          _animationController.duration =
              //  widget.subjectList![_currentIndex].duration ??
              const Duration(seconds: 3);
          _animationController.forward(); // Restart the animation
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          //  _animationController.dispose();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen()));// Close the StoryView when done
        }
      }
    } else if (widget.isCircularWidget) {
      if (widget.circularList!.isEmpty) {
        if (_currentIndex < 1) {
          setState(() {
            _currentIndex++;
          });
          _animationController.reset(); // Reset the controller
          _animationController.duration =
              //  widget.subjectList![_currentIndex].duration ??
              const Duration(seconds: 3);
          _animationController.forward(); // Restart the animation
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          //  _animationController.dispose();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen())); // Close the StoryView when done
        }
      } else {
        if (_currentIndex < widget.circularList!.length - 1) {
          setState(() {
            _currentIndex++;
          });
          _animationController.reset(); // Reset the controller
          _animationController.duration =
              //  widget.subjectList![_currentIndex].duration ??
              const Duration(seconds: 3);
          _animationController.forward(); // Restart the animation
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          //  _animationController.dispose();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen())); // Close the StoryView when done
        }
      }
    } else if (widget.isDisciplineWidget) {
      if (widget.disciplineList!.isEmpty) {
        if (_currentIndex < 1) {
          setState(() {
            _currentIndex++;
          });
          _animationController.reset(); // Reset the controller
          _animationController.duration =
              //  widget.subjectList![_currentIndex].duration ??
              const Duration(seconds: 3);
          _animationController.forward(); // Restart the animation
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          //  _animationController.dispose();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen())); // Close the StoryView when done
        }
      } else {
        if (_currentIndex < widget.disciplineList!.length - 1) {
          setState(() {
            _currentIndex++;
          });
          _animationController.reset(); // Reset the controller
          _animationController.duration =
              //  widget.subjectList![_currentIndex].duration ??
              const Duration(seconds: 3);
          _animationController.forward(); // Restart the animation
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          //  _animationController.dispose();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen()));// Close the StoryView when done
        }
      }
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _animationController.reset(); // Reset the controller
      if (widget.isGalleryWidget) {
        _animationController.duration =
            widget.stories?[_currentIndex].duration ??
                const Duration(seconds: 3);
      } else {
        _animationController.duration = const Duration(seconds: 3);
      }
      _animationController.forward(); // Restart the animation
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _pauseAnimation() {
    _animationController.stop();
  }

  void _resumeAnimation() {
    _animationController.forward();
  }

  DateTime todaysDate = DateTime.now();

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  int currentStoryItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isGalleryWidget
          ? GestureDetector(
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
                    if (widget.isGalleryWidget)
                      {
                        onSaveWithDialogPressed(
                            widget.stories![_currentIndex].base64Image),
                      }
                  })
          : GestureDetector(
              onTap: () => {
                    widget.isAssignmentWidget
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AssignmentScreen()))
                        : widget.isCircularWidget
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CircularScreen()))
                            : widget.isDisciplineWidget
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DisciplineScreen()))
                                : null
                  },
              child: SvgPicture.asset(
                MyAssets.backArrow,
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            widget.isGalleryWidget ? Navigator.pop(context) :
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const NguruDashboardScreen()));
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.isAssignmentWidget == true &&
                      widget.subjectList!.isEmpty
                  ? 1
                  : widget.isAssignmentWidget == true &&
                          widget.subjectList!.isNotEmpty
                      ? widget.subjectList?.length

                      : widget.isCircularWidget == true &&
                              widget.circularList!.isEmpty
                          ? 1
                          : widget.isCircularWidget == true &&
                                  widget.circularList!.isNotEmpty
                              ? widget.circularList?.length

                              : widget.isDisciplineWidget == true &&
                                      widget.disciplineList!.isEmpty
                                  ? 1
                                  : widget.isDisciplineWidget == true &&
                                          widget.disciplineList!.isNotEmpty
                                      ? widget.disciplineList?.length
                                      : widget.stories?.length,
              itemBuilder: (context, index) {
                return CustomStoryWidget(
                  story: widget.stories?[index],
                  onNext: _nextStory,
                  onPrevious: _previousStory,
                  onHold: _pauseAnimation,
                  onRelease: _resumeAnimation,
                  isGalleryWidget: widget.isGalleryWidget,
                  isAssignmentWidget: widget.isAssignmentWidget,
                  isCircularWidget: widget.isCircularWidget,
                  isDisciplineWidget: widget.isDisciplineWidget,
                  subjectList: widget.subjectList!.isNotEmpty
                      ? widget.subjectList![index]
                      : null,
                  circularList: widget.circularList!.isNotEmpty
                      ? widget.circularList![index]
                      : null,
                  disciplineList: widget.disciplineList!.isNotEmpty
                      ? widget.disciplineList![index]
                      : null,
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  log("current index for download story: $_currentIndex");
                });
                _animationController.reset(); // Reset animation on page change

                if (widget.isGalleryWidget) {
                  _animationController.duration =
                      widget.stories?[_currentIndex].duration ??
                          const Duration(seconds: 5);
                } else {
                  _animationController.duration = const Duration(seconds: 5);
                }

                _animationController.forward(); // Restart the animation
              },
            ),
            Positioned(
              top: 40.0,
              left: 16.0,
              right: 16.0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return GradientIndicator(
                    itemCount: widget.isGalleryWidget
                        ? widget.stories!.length
                        : widget.isAssignmentWidget == true &&
                                widget.subjectList!.isEmpty
                            ? 1
                            : widget.isAssignmentWidget == true &&
                                    widget.subjectList!.isNotEmpty
                                ? widget.subjectList!.length
                                : widget.isDisciplineWidget == true &&
                                        widget.disciplineList!.isEmpty
                                    ? 1
                                    : widget.isDisciplineWidget == true &&
                                            widget.disciplineList!.isNotEmpty
                                        ? widget.disciplineList!.length
                                        : widget.isCircularWidget == true &&
                                                widget.circularList!.isEmpty
                                            ? 1
                                            : widget.isCircularWidget == true &&
                                                    widget.circularList!
                                                        .isNotEmpty
                                                ? widget.circularList!.length
                                                : 0,
                    currentIndex: _currentIndex,
                    progress: _animationController.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CustomStoryWidget displays an individual story
class CustomStoryWidget extends StatelessWidget {
  final Story? story;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onHold;
  final VoidCallback onRelease;

  final bool isGalleryWidget;
  final bool isAssignmentWidget;
  final bool isCircularWidget;
  final bool isDisciplineWidget;

  final SubjectList? subjectList;
  final CircularList? circularList;
  final DisciplineList? disciplineList;

  CustomStoryWidget({
    this.story,
    required this.onNext,
    required this.onPrevious,
    required this.onHold,
    required this.onRelease,
    required this.isGalleryWidget,
    required this.isAssignmentWidget,
    required this.isCircularWidget,
    required this.isDisciplineWidget,
    this.subjectList,
    this.circularList,
    this.disciplineList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Detects a tap on the screen to navigate forward or backward
      onTapUp: (details) {
        if (details.localPosition.dx > MediaQuery.of(context).size.width / 2) {
          onNext();
        } else {
          onPrevious();
        }
      },

      /// Detects a long press start event to pause the story
      onLongPressStart: (details) {
        onHold();
      },

      /// Detects the end of a long press event to resume the story
      onLongPressEnd: (details) {
        onRelease();
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// Display the story content (image)
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: isGalleryWidget ? Colors.white : MyColors.greenShade_1,
            ),

            /// Download button for the story
            Align(
              alignment: Alignment.center,
              child: isGalleryWidget
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 1,
                      width: double.infinity,
                      child: Image.memory(
                        base64Decode(story!.base64Image),
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  : isAssignmentWidget == true && subjectList == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25, left: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      MyAssets.assignmentIcon,
                                      width: 35,
                                      height: 35,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Text(
                                      MyStrings.assignment,
                                      style: FontUtil.customStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          textColor: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            200.heightBox,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  subjectList?.subjectName != null
                                      ? "Subject Name: ${subjectList?.subjectName}"
                                      : MyStrings.notAvailable,
                                  textAlign: TextAlign.center,
                                  style: FontUtil.customStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      textColor: Colors.black),
                                ),
                                10.heightBox,
                                const SizedBox(
                                  height: 210,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text("No Assignments for today!"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : isAssignmentWidget == true && subjectList != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 25, left: 15),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          MyAssets.assignmentIcon,
                                          width: 35,
                                          height: 35,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                        ),
                                        Text(
                                          MyStrings.assignment,
                                          style: FontUtil.customStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              textColor: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                200.heightBox,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      subjectList?.subjectName != null
                                          ? "Subject Name: ${subjectList?.subjectName}"
                                          : MyStrings.notAvailable,
                                      textAlign: TextAlign.center,
                                      style: FontUtil.customStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black),
                                    ),
                                    10.heightBox,
                                    SizedBox(
                                      height: 210,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              subjectList?.assignments?.length,
                                          itemBuilder: (context, index) {
                                            return assignmentItem(
                                                context,
                                                subjectList
                                                    ?.assignments?[index]);
                                            //  return Center(child: Text("data"),);
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : isCircularWidget == true && circularList == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25, left: 15),
                                      child: SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.45,
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.1,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              MyAssets.assignmentIcon,
                                              width: 35,
                                              height: 35,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Text(
                                                                                            MyStrings.circular,
                                                                                            style: FontUtil.customStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              textColor: Colors.black),
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                          ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          circularList?.subject != null
                                              ? "Subject : ${circularList?.subject}"
                                              : MyStrings.notAvailable,
                                          textAlign: TextAlign.center,
                                          style: FontUtil.customStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              textColor: Colors.black),
                                        ),
                                        10.heightBox,
                                        const SizedBox(
                                          height: 210,
                                          width: double.infinity,
                                          child: Center(
                                              child: Text(
                                                  "No circular for today!")),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : isCircularWidget == true && circularList != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, left: 15),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  MyAssets.assignmentIcon,
                                                  width: 35,
                                                  height: 35,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                ),
                                                Text(
                                                  MyStrings.circular,
                                                  style: FontUtil.customStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textColor: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        200.heightBox,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              circularList?.subject != null
                                                  ? "Subject : ${circularList?.subject}"
                                                  : MyStrings.notAvailable,
                                              textAlign: TextAlign.center,
                                              style: FontUtil.customStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black),
                                            ),
                                            10.heightBox,
                                            Text(
                                              circularList?.description != null
                                                  ? "Description : ${circularList?.description}"
                                                  : "Description : ${MyStrings.notAvailable}",
                                              textAlign: TextAlign.center,
                                              style: FontUtil.customStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: Colors.black),
                                            ),
                                            
                                            10.heightBox,
                                            SizedBox(
                                              height: 210,
                                              width: double.infinity,
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return circularItem(
                                                        context, circularList);
                                                    //  return Center(child: Text("data"),);
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : isDisciplineWidget == true &&
                                          disciplineList == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25, left: 15),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      MyAssets.assignmentIcon,
                                                      width: 35,
                                                      height: 35,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                    ),
                                                    Text(
                                                      MyStrings.discipline,
                                                      style:
                                                          FontUtil.customStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              textColor:
                                                                  Colors.black),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            200.heightBox,
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  disciplineList?.teacherName !=
                                                          null
                                                      ? "Teacher Name: ${disciplineList?.teacherName}"
                                                      : MyStrings.notAvailable,
                                                  textAlign: TextAlign.center,
                                                  style: FontUtil.customStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textColor: Colors.black),
                                                ),
                                                10.heightBox,
                                                const SizedBox(
                                                    height: 210,
                                                    width: double.infinity,
                                                    child: Center(
                                                        child: Text(
                                                            "No discipline for today!"))),
                                              ],
                                            ),
                                          ],
                                        )
                                      : isDisciplineWidget == true &&
                                              disciplineList != null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25, left: 15),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.45,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          MyAssets
                                                              .assignmentIcon,
                                                          width: 35,
                                                          height: 35,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03,
                                                        ),
                                                        Text(
                                                          MyStrings.discipline,
                                                          style: FontUtil
                                                              .customStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textColor:
                                                                      Colors
                                                                          .black),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                200.heightBox,
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      disciplineList
                                                                  ?.teacherName !=
                                                              null
                                                          ? "Teacher Name: ${disciplineList?.teacherName}"
                                                          : MyStrings
                                                              .notAvailable,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FontUtil.customStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              textColor:
                                                                  Colors.black),
                                                    ),
                                                    10.heightBox,
                                                    SizedBox(
                                                      height: 210,
                                                      width: double.infinity,
                                                      child: ListView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          itemCount: 1,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return disciplineItem(
                                                                context,
                                                                disciplineList);
                                                            //  return Center(child: Text("data"),);
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : IconButton(
                                              icon: const Icon(Icons.download,
                                                  color: Colors.black),
                                              onPressed: () {
                                                log("Story downloaded"); // Log download action
                                                // Implement download functionality here
                                              },
                                            ),
            ),
          ],
        ),
      ),
    );
  }
}

/// GradientIndicator class defines the progress indicator
class GradientIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double progress;

  GradientIndicator({
    required this.itemCount,
    required this.currentIndex,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(itemCount, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              height: 4.0,
              decoration: BoxDecoration(
                color: index < currentIndex
                    ? Colors.blue
                    : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: index == currentIndex
                  ? FractionallySizedBox(
                      widthFactor: progress,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        color: Colors.green,
                      ),
                    )
                  : Container(),
            ),
          ),
        );
      }),
    );
  }
}

////////////////////////////////////////////////////////////  WIDGETS FOR DASHBOARD STORIES /////////////////////////////////////

// ASSIGNMENT STORY ITEMS

Widget assignmentItem(BuildContext context, Assignment? assignments) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: screenHeight * 0.12,
        width: screenWidth * 0.9,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(MyAssets.assignmentImage),
                5.widthBox,
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Flexible(
                          child: Text(
                        assignments?.startDate != null
                            ? "Assignment: ${assignments?.assignmentName}"
                            : MyStrings.notAvailable,
                        style: FontUtil.customStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            textColor: MyColors.fadedTextColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Flexible(
                          child: Text(
                        assignments?.startDate != null
                            ? "Description: ${removeHtmlTags(assignments?.assignmentDetail ?? "")}"
                            : MyStrings.notAvailable,
                        style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textColor: MyColors.fadedTextColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 11,
                            color: MyColors.greyShade_3,
                          ),
                          Text(
                            assignments?.endDate != null
                                ? " ${MyStrings.date}: ${assignments?.endDate}"
                                : MyStrings.notAvailable,
                            style: FontUtil.customStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                textColor: MyColors.greyShade_3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      // on progress

                      onTap: () => {
                        assignments?.fileContent != null
                            ? onSaveWithDialogPressed(
                                assignments?.fileContent ?? "")
                            : Navigator.push(context, MaterialPageRoute(builder: (context)=>StoryDescription(
                         isCircular: false,
                          isAssignment: true,
                          isDiscipline: false,
                          circularList:null ,
                          assignmentList: assignments,
                          disciplineList: null,
                            ))),
                        log("download")
                      },

                      child: assignments?.fileContent != null
                          ? SvgPicture.asset(
                              MyAssets.downloadIcon,
                              height: 25,
                              width: 25,
                            )
                          :  SvgPicture.asset(
                              MyAssets.seen,
                              height: 18,
                              width: 18,
                              color: MyColors.greyShade_7,
                            )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

////// CIRCULAR WIDGET

Widget circularItem(BuildContext context, CircularList? circularList) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: screenHeight * 0.12,
        width: screenWidth * 0.9,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(MyAssets.assignmentImage),
                5.widthBox,
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Flexible(
                          child: Text(
                        circularList?.subject != null
                            ? "Subject: ${circularList?.subject}"
                            : MyStrings.notAvailable,
                        style: FontUtil.customStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            textColor: MyColors.fadedTextColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Flexible(
                          child: Text(
                        circularList?.description != null
                            ? "Description: ${removeHtmlTags(circularList?.description ?? "")}"
                            : MyStrings.notAvailable,
                        style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textColor: MyColors.fadedTextColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 11,
                            color: MyColors.greyShade_3,
                          ),
                          Text(
                            circularList?.circularDate != null
                                ? " ${MyStrings.date}: ${circularList?.circularDate}"
                                : MyStrings.notAvailable,
                            style: FontUtil.customStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                textColor: MyColors.greyShade_3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // for download circulars
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      // on progress

                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StoryDescription(
                          isCircular: true,
                          isAssignment: false,
                          isDiscipline: false,
                          circularList:circularList ,
                          assignmentList: null,
                          disciplineList: null,
                        ))),
                        
                      },

                      child: SvgPicture.asset(
                              MyAssets.seen,
                              height: 18,
                              width: 18,
                              color: MyColors.greyShade_7,
                            ),
                          
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

////// DISCIPLINE WIDGET

Widget disciplineItem(BuildContext context, DisciplineList? disciplineList) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: screenHeight * 0.12,
        width: screenWidth * 0.9,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(MyAssets.assignmentImage),
                5.widthBox,
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Flexible(
                          child: Text(
                        disciplineList?.teacherName != null
                            ? "Teacher Name: ${disciplineList?.teacherName}"
                            : MyStrings.notAvailable,
                        style: FontUtil.customStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            textColor: MyColors.fadedTextColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Flexible(
                          child: Text(
                        disciplineList?.reason != null
                            ? "Reason: ${removeHtmlTags(disciplineList?.reason ?? "")}"
                            : MyStrings.notAvailable,
                        style: FontUtil.customStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textColor: MyColors.fadedTextColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                      Row(
                        children: [
                          Text(
                            disciplineList?.points != null
                                ? " ${MyStrings.points}: ${disciplineList?.points}"
                                : MyStrings.notAvailable,
                            style: FontUtil.customStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                textColor: MyColors.greyShade_3),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 11,
                            color: MyColors.greyShade_3,
                          ),
                          Text(
                            disciplineList?.actionDate != null
                                ? " ${MyStrings.date}: ${disciplineList?.actionDate}"
                                : MyStrings.notAvailable,
                            style: FontUtil.customStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                textColor: MyColors.greyShade_3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // for download circulars
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      // on progress

                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StoryDescription(
                          isCircular: false,
                          isAssignment: false,
                          isDiscipline: true,
                          circularList:null ,
                          assignmentList: null,
                          disciplineList: disciplineList,
                        ))),
                      },

                      child:   SvgPicture.asset(
                              MyAssets.seen,
                              height: 18,
                              width: 18,
                              color: MyColors.greyShade_7,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
