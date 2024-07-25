import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/attendence_and_fee_card.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';

import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/person_card.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_state.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/screens/attendence_screen.dart';
import 'package:nguru/screens/circular_screen.dart';
import 'package:nguru/screens/gallery_screen.dart';
import 'package:nguru/screens/setting_screen.dart';
import 'package:nguru/screens/story/story_screen.dart';

import 'package:nguru/screens/time_table_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';

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
    context.read<DashboardCubit>().dashboardGetList();
    context.read<NotificationCubit>().notificationCount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
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
            return Stack(
              children: [
                Container(height:  MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,color: Colors.white,child:  SvgPicture.asset(MyAssets.background,fit: BoxFit.fill,),),
                // Positioned.fill(child: SvgPicture.asset(MyAssets.background,fit: BoxFit.fill,)),
                SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      dashboardAppBar(),
                      CustomSearchBar(controller: searchController),
                      12.heightBox,
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
                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingScreen())),
                              child: personInfoCard(
                                context,
                                "${state.studentPicture}",
                                "${state.studentName}",
                                "${state.qualification} ${state.section}",
                                "${state.admissionNumber}",
                                (String newName) {
                                  setState(() {});
                                },
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: GestureDetector(
                                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendenceScreen())),
                                    child: attendenceAndFeeCard(
                                      context,
                                      mainText: "53%",
                                      footerText: "Attendance",
                                      isFeeCard: false,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Flexible(
                                  flex: 5,
                                  child: attendenceAndFeeCard(
                                    context,
                                    headerText: "Paid 23k",
                                    mainText: "41%",
                                    footerText: "Fees Paid",
                                    isFeeCard: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      20.heightBox,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           StoryScreen(),
                          18.heightBox,
                          Container(
                            height: screenHeight * 0.17,
                            width: screenWidth,
                            child: Row(
                              children: [
                                customCard(
                                  context: context,
                                  title: state.dashboardList?[5]
                                          ['dashboardItem'] ??
                                      MyStrings.timeTable,
                                  content: MyStrings.timeTablesub,
                                  isPngImage: false,
                                  icon: Icons.arrow_forward,
                                  onIconPressed: () {
                                    NavigationService.navigateTo(
                                        const TimetableScreen(), context);
                                  },
                                  cardWidth: screenWidth * 0.5,
                                  cardHeight: double.maxFinite,
                                  image: MyAssets.timetable_card_image,
                                ),
                                15.widthBox,
                                customCard(
                                  context: context,
                                  title: state.dashboardList?[6]
                                          ['dashboardItem'] ??
                                      "",
                                  content: MyStrings.examinationsub,
                                  isPngImage: true,
                                  icon: Icons.arrow_forward,
                                  cardHeight: double.maxFinite,
                                  cardWidth: screenWidth * 0.35,
                                  image: MyAssets.exams,
                                  onIconPressed: () {
                                    NavigationService.navigateTo(
                                        const TimetableScreen(), context);
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
                                  title: state.dashboardList?[8]
                                          ['dashboardItem'] ??
                                      "MyStrings.calender",
                                  content: MyStrings.calendarsub,
                                  isPngImage: false,
                                  icon: Icons.arrow_forward,
                                  cardHeight: double.maxFinite,
                                  cardWidth: screenWidth * 0.35,
                                  onIconPressed: () {
                                    NavigationService.navigateTo(
                                        CircularScreen(), context);
                                  },
                                  image: MyAssets.calendar,
                                ),
                                14.widthBox,
                                Expanded(
                                  child: customCard(
                                    context: context,
                                    title: state.dashboardList?[9]
                                            ['dashboardItem'] ??
                                        MyStrings.activity,
                                    content: MyStrings.activitysub,
                                    isPngImage: false,
                                    icon: Icons.arrow_forward,
                                    onIconPressed: () {
                                      print("forward");
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
                                    title: state.dashboardList?[10]
                                            ['dashboardItem'] ??
                                        MyStrings.Library,
                                    content: MyStrings.Librarysub,
                                    isPngImage: false,
                                    icon: Icons.arrow_forward,
                                    onIconPressed: () {
                                      print("forward");
                                    },
                                    image: MyAssets.library,
                                  ),
                                ),
                                15.widthBox,
                                Expanded(
                                  child: customCard(
                                    context: context,
                                    title: state.dashboardList?[11]
                                            ['dashboardItem'] ??
                                        MyStrings.infirmary,
                                    content: MyStrings.infirmarysub,
                                    isPngImage: false,
                                    icon: Icons.arrow_forward,
                                    onIconPressed: () {
                                      print("forward");
                                    },
                                    image: MyAssets.infirmary,
                                  ),
                                ),
                                15.widthBox,
                                Expanded(
                                  child: customCard(
                                    context: context,
                                    title: state.dashboardList?[13]
                                            ['dashboardItem'] ??
                                        MyStrings.gallery,
                                    content: MyStrings.gallerysub,
                                    icon: Icons.arrow_forward,
                                    isPngImage: false,
                                    image: MyAssets.gallery,
                                    onIconPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GalleryScreen())),
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
              ]
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget customCard({
    required BuildContext context,
    required String title,
    required String content,
    required IconData icon,
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
      child: InkWell(
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
                      child: Icon(
                        icon,
                        color: Colors.white,
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
