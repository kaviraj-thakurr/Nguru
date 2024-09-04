import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/notification_list/notification_list_cubit.dart';
import 'package:nguru/logic/notification_list/notification_list_state.dart';
import 'package:nguru/models/notificationlist_model.dart';
import 'package:nguru/screens/Examination/examination_screen.dart';
import 'package:nguru/screens/assignment_screen.dart';
import 'package:nguru/screens/attendance/attendence_screen.dart';
import 'package:nguru/screens/circular_screen.dart';
import 'package:nguru/screens/discipline_screen.dart';
import 'package:nguru/screens/gallery_screen.dart';
import 'package:nguru/screens/time_table_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart';


class NotificationScreen extends StatefulWidget {

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController searchController = TextEditingController();
  List<NotificationList> filteredNotifications = [];
    DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

    Future<void> getSessionDates() async {
    startDate = DateFormat("dd-MMM-yyyy")
        .parse(await SharedPref.getStartDateOfSession() ?? "");
    endDate = DateFormat("dd-MMM-yyyy")
        .parse(await SharedPref.getEndDateOfSession() ?? "");
    log(" init call from notification screen:  $startDate $endDate");
  }

  @override
  void initState() {
    super.initState();
    getSessionDates();
    context.read<NotificationListCubit>().getNotificationList();
    searchController.addListener(_filterNotifications);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterNotifications);
    searchController.dispose();
    super.dispose();
  }

  void _filterNotifications() {
    setState(() {
      final query = searchController.text.toLowerCase();
      final notificationCubit = context.read<NotificationListCubit>();
      final currentState = notificationCubit.state;
      if (currentState is NotificationListSuccessState) {
        filteredNotifications = currentState.notificationListModel.notificationList!.where((notification) {
          final title = notification.notificationHeader?.toLowerCase() ?? '';
          return title.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                MyAssets.bg,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  customAppBar(),
                  CustomSearchBar(controller: searchController),
                  8.heightBox,
                  screenTitleHeader(MyStrings.notification,
                      onPressed: () => Navigator.pop(context)),
                      8.heightBox,
                  Expanded(
                    child: BlocBuilder<NotificationListCubit, NotificationListState>(
                      builder: (context, state) {
                        if (state is NotificationListLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is NotificationListSuccessState) {
                          final notificationsToShow = searchController.text.isEmpty
                              ? state.notificationListModel.notificationList!
                              : filteredNotifications;
                          return buildNotificationList(notificationsToShow);
                        } else if (state is NotificationListErrorState) {
                          return Center(child: Text(state.message));
                        }
                        return const Center(child: Text(MyStrings.noNotificationFound));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // This method for notificationList

Widget buildNotificationList(List<NotificationList> notifications) {
  return ListView.builder(
    itemCount: notifications.length + 1, // Adding 1 to include the loading indicator
    itemBuilder: (context, index) {
      if (index == notifications.length) {
        // Show loading indicator if at the end of the list
        return const Padding(
          padding: EdgeInsets.all(padding8),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final notification = notifications[index];
      return Padding(
        padding: const EdgeInsets.all(padding5),
        child: GestureDetector(
          onTap: () => handleNotificationTap(notification),
          child: cardDesign(
            context,
            notification.notificationHeader,
            notification.createdOn,
            notification.notificationDetail,
          ),
        ),
      );
    },
  );
}


// This method for Navigating to particular screen of particular Notification

  void handleNotificationTap(NotificationList notification) {
    if (notification.notificationHeader == MyStrings.assignmentNotification) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentScreen(isNotificationScreen: true,notificationScreenDate: notification.createdOn,)));
    } else if (notification.notificationHeader == MyStrings.circularNotification) {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  CircularScreen(isNotificationScreen: true,notificationScreenDate: notification.createdOn?.month,)));
    } else if (notification.notificationHeader == "Discipline Notification") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DisciplineScreen(startDate: startDate,endDate: endDate,)));
    }else if (notification.notificationHeader == "TimeTable Notification") {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>const TimetableScreen()));
      }
      else if(notification.notificationHeader == MyStrings.photoNotification){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const GalleryScreen()));
      }

      else if(notification.notificationHeader == MyStrings.attendanceNotification){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendenceScreen(month: notification.createdOn?.month,)));
      }

      else if(notification.notificationHeader == MyStrings.examReportNotification){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ExaminationScreen()));
      }


      

      
  }

  // This method for UI design card for notification

  Widget cardDesign(BuildContext context, String? title, DateTime? createdOn, String? subtitle) {
    String formattedDate = createdOn != null 
        ? DateFormat('dd MMM ').format(createdOn) 
        : MyStrings.noData;

    return Stack(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.searchBackGroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SvgPicture.asset(MyAssets.notification_icon, height: height28),
                12.widthBox,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(padding8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title ??"",
                              style: FontUtil.customStyle(
                                fontSize: 17.h,
                                fontWeight: FontWeight.w500,
                                textColor: MyColors.teacherNameColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              formattedDate,
                              style: FontUtil.customStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.w500,
                                textColor: MyColors.periodOrTimeColor,
                              ),
                            ),
                          ],
                        ),
                        5.heightBox,
                        Text(
                          subtitle ?? MyStrings.noDescription,
                          style: FontUtil.customStyle(
                            fontSize: 14.h,
                            fontWeight: FontWeight.w400,
                            textColor: MyColors.periodOrTimeColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}