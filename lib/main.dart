import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_cubit.dart';
import 'package:nguru/logic/calendar_event/calendar_event_cubit.dart';
import 'package:nguru/logic/circular/circular_cubit.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/discipline/descipline_cubit.dart';
import 'package:nguru/logic/fee/fee_list_cubit.dart';
import 'package:nguru/logic/forgot_password/forgot_password_cubit.dart';
import 'package:nguru/logic/gallery_cubit/gallery_cubit.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_cubit.dart';
import 'package:nguru/logic/push_notification/push_notification_cubit.dart';
import 'package:nguru/logic/reset_password/reset_password_cubit.dart';
import 'package:nguru/logic/signout/signout_cubit.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/screens/addSchool_screen.dart';
import 'package:nguru/screens/attendance/attendace_card_screen.dart';
import 'package:nguru/screens/attendance/attendance_bar_graph_screen.dart';
import 'package:nguru/screens/attendance/attendence_screen.dart';
import 'package:nguru/screens/calendar_screen.dart';
import 'package:nguru/screens/contact_screen.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/discipline_screen.dart';
import 'package:nguru/screens/event_calendar.dart';
import 'package:nguru/screens/fees/fee_detail_screen.dart';
import 'package:nguru/screens/fees/fee_main_screen.dart';
import 'package:nguru/screens/library_screen.dart';
import 'package:nguru/screens/setting_screen.dart';
import 'package:nguru/screens/testing_story.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddSchoolCubit(AuthRepo())),
        BlocProvider(create: (context) => LoginCubit(AuthRepo())),
        BlocProvider(create: (context) => DashboardCubit(AuthRepo())),
        BlocProvider(create: (context) => NotificationCubit(AuthRepo())),
        BlocProvider(
          create: (context) => AssignmentMonthListCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => AssignmentListCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ContactUsCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => GalleryPhotosCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => CircularCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => DisciplineCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ForgetPassCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ResetPasswordCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => PushNotificationCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => SignoutCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => AttendanceBarChartCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ParticularMonthAttendanceCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => FeeListCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => CalendarEventCubit(AuthRepo()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const LibraryScreen()
            // const NguruDashboardScreen()
            //   const BarChartExample()
            ),
      ),
    );
  }
}
