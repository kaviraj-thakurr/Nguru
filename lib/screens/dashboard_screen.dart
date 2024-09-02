import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/attendence_and_fee_card.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';

import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/person_card.dart';
import 'package:nguru/logic/attendence/attendence_cubit.dart';
import 'package:nguru/logic/attendence/attendence_state.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_state.dart';
import 'package:nguru/logic/fees/fees_cubit.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/models/dashboard_model.dart';
import 'package:nguru/screens/Examination/examination_screen.dart';
import 'package:nguru/screens/activity_screen.dart';
import 'package:nguru/screens/assignment_screen.dart';
import 'package:nguru/screens/attendance/attendance_bar_graph_screen.dart';
import 'package:nguru/screens/calendar_screen.dart';
import 'package:nguru/screens/circular_screen.dart';
import 'package:nguru/screens/discipline_screen.dart';
import 'package:nguru/screens/gallery_screen.dart';
import 'package:nguru/screens/infirmary_screen.dart';
import 'package:nguru/screens/library_screen.dart';
import 'package:nguru/screens/settings/change_siblings.dart';
import 'package:nguru/screens/settings/setting_screen.dart';
import 'package:nguru/screens/story/story_screen.dart';
import 'package:nguru/screens/time_table_screen.dart';
import 'package:nguru/test.dart';

import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';

import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class NguruDashboardScreen extends StatefulWidget {
  const NguruDashboardScreen({super.key});

  @override
  State<NguruDashboardScreen> createState() => _NguruDashboardScreenState();
}

class _NguruDashboardScreenState extends State<NguruDashboardScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    //  log("school url: ${ SharedPref.getSchoolUrl()}");
    context.read<DashboardCubit>().dashboardGetList();
    context.read<NotificationCubit>().notificationCount();
    context.read<FeesCubit>().getTotalFees();
    context.read<AttendanceCubit>().fetchAttendanceData();

    super.initState();
  }

  DateTime? _lastBackPressedTime;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return WillPopScope(
      onWillPop: () {
        final currentTime = DateTime.now();

        // Check if the back button was pressed twice within 2 seconds
        if (_lastBackPressedTime == null ||
            currentTime.difference(_lastBackPressedTime!) >
                const Duration(seconds: 2)) {
          _lastBackPressedTime = currentTime;

          // Show a message to press back again to exit
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );

          return Future.value(false); // Do nothing if not double pressed
        }
        SystemNavigator.pop();

        return Future.value(true);
        ; //
      },
      child: Scaffold(
        body: BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {
            if (state is DashboardErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is DashboardLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardSuccessState) {
              List<DashboardList> filteredDashboardList =
                  state.dashboardList?.where((item) {
                        return item.dashboardItem != "Circular" &&
                            item.dashboardItem != "Assignment" &&
                            item.dashboardItem != "Discipline";
                      }).toList() ??
                      [];

              return Stack(children: [
                Positioned.fill(
                    child: Image.asset(
                  MyAssets.bg,
                  fit: BoxFit.fill,
                )),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(padding18),
                    child: Column(
                      children: [
                        10.heightBox,
                        dashboardAppBar(),
                        CustomSearchBar(controller: searchController),
                        10.heightBox,
                        Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          constraints: BoxConstraints(
                            maxHeight: screenHeight * 0.2,
                            maxWidth: double.infinity,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingScreen())),
                                child: personInfoCard(
                                  context,
                                  "${state.studentPicture}",
                                  "${state.studentName}",
                                  "${state.qualification} ${state.section}",
                                  "${state.admissionNumber}",
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BarChartExample())),
                                      child: BlocConsumer<AttendanceCubit,
                                          AttendanceState>(
                                        listener: (context, state) {
                                          if (state is AttendanceError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(state.message)),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is AttendanceLoading) {
                                            return attendenceAndFeeCard(
                                              context,
                                              mainText: "__",
                                              footerText: MyStrings.attendence,
                                              isFeeCard: false,
                                            );
                                          } else if (state
                                              is AttendanceSuccess) {
                                            return attendenceAndFeeCard(
                                              context,
                                              mainText:
                                                  "${state.overAllPercentage}%",
                                              footerText: MyStrings.attendence,
                                              isFeeCard: false,
                                            );
                                          }
                                          return attendenceAndFeeCard(
                                            context,
                                            mainText: "_ _",
                                            footerText: MyStrings.attendence,
                                            isFeeCard: false,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    flex: 5,
                                    child: GestureDetector(
                                      // onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> FeesMainScreen())),
                                      child: attendenceAndFeeCard(
                                        context,
                                        headerText: "Paid 23k",
                                        mainText: "41%",
                                        footerText: "Fees Paid",
                                        isFeeCard: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        14.heightBox,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          const  StoryScreen(),
                            18.heightBox,
                            SizedBox(
                              height: screenHeight * 0.17,
                              width: screenWidth,
                              child: Row(
                                children: [
                                  customCard(
                                    context: context,
                                    title: MyStrings.timetable,
                                    content: MyStrings.timeTablesub,
                                    isPngImage: false,
                                    onIconPressed: () {

                                      NavigationService.navigateTo(
                                           ReportCardScreen(), context);
                                    },
                                    cardWidth: screenWidth * 0.5,
                                    cardHeight: double.maxFinite,
                                    image: MyAssets.timetable_card_image,
                                  ),
                                  15.widthBox,
                                  customCard(
                                    context: context,
                                    title: MyStrings.examination,
                                    content: MyStrings.examinationSub,
                                    isPngImage: true,
                                    cardHeight: double.maxFinite,
                                    cardWidth: screenWidth * 0.35,
                                    image: MyAssets.exams,
                                    onIconPressed: () {
                                      NavigationService.navigateTo(
                                          const ExaminationScreen(), context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            14.heightBox,
                            SizedBox(
                              height: screenHeight * 0.14,
                              width: screenWidth,
                              child: Row(
                                children: [
                                  customCard(
                                    context: context,
                                    title: MyStrings.calender,
                                    content: MyStrings.calendarSub,
                                    isPngImage: false,
                                    cardHeight: double.maxFinite,
                                    cardWidth: screenWidth * 0.35,
                                    onIconPressed: () {
                                      NavigationService.navigateTo(
                                          const CalendarScreen(), context);
                                    },
                                    image: MyAssets.calendar,
                                  ),
                                  14.widthBox,
                                  Expanded(
                                    child: customCard(
                                      context: context,
                                      title: MyStrings.activity,
                                      content: MyStrings.activitySub,
                                      isPngImage: false,
                                      onIconPressed: () {
                                        NavigationService.navigateTo(
                                            const ActivityScreen(), context);
                                      },
                                      cardHeight: double.maxFinite,
                                      cardWidth: 250,
                                      image: MyAssets.activity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            14.heightBox,
                            SizedBox(
                              width: screenWidth,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: customCard(
                                      context: context,
                                      title: MyStrings.Library,
                                      content: MyStrings.librarySub,
                                      isPngImage: false,
                                      onIconPressed: () {
                                        NavigationService.navigateTo(
                                            const LibraryScreen(), context);
                                      },
                                      image: MyAssets.library,
                                    ),
                                  ),
                                  15.widthBox,
                                  Expanded(
                                    child: customCard(
                                      context: context,
                                      title: MyStrings.infirmary,
                                      content: MyStrings.infirmarysub,
                                      isPngImage: false,
                                      onIconPressed: () {
                                        NavigationService.navigateTo(
                                            const InfirmaryScreen(), context);
                                      },
                                      image: MyAssets.infirmary,
                                    ),
                                  ),
                                  15.widthBox,
                                  Expanded(
                                    child: customCard(
                                      context: context,
                                      title: MyStrings.gallery,
                                      content: MyStrings.gallerySub,
                                      isPngImage: false,
                                      onIconPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const GalleryScreen()));
                                      },
                                      image: MyAssets.gallery,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  Widget customCard({
    required BuildContext context,
    required String title,
    required String content,
    // required IconData icon,
    required VoidCallback onIconPressed,
    required String image,
    double? cardHeight,
    double? cardWidth,
    bool? isPngImage,
  }) {
    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
        gradient: MyColors.cardColors,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: onIconPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title, maxLines: 1, style: FontUtil.cardTitle),
              Text(content, maxLines: 3, style: FontUtil.cardsubTitle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.bottomLeft,
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return MyColors.arrowColor.createShader(bounds);
                      },
                      child: SvgPicture.asset(MyAssets.arrowIcon
                          // color: MyColors.white,
                          ),
                    ),
                    color: Colors.transparent,
                    onPressed: onIconPressed,
                  ),
                  Flexible(
                    child: isPngImage == false
                        ? SvgPicture.asset(image)
                        : Image.asset(image),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
