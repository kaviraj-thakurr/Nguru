import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nguru/local_database/add_school_list_hive_box.dart';
import 'package:nguru/logic/Chat/chat_state_cubit.dart';
import 'package:nguru/logic/activity/activity_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'package:nguru/logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_cubit.dart';
import 'package:nguru/logic/attendence/attendence_cubit.dart';
import 'package:nguru/logic/calendar_event/calendar_event_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_cubit.dart';
import 'package:nguru/logic/circular/circular_cubit.dart';
import 'package:nguru/logic/communication/communication_cubit.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_cubit.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/fee/fee_list_cubit.dart';
import 'package:nguru/logic/fees/fees_cubit.dart';
import 'package:nguru/logic/discipline/descipline_cubit.dart';
import 'package:nguru/logic/forgot_password/forgot_password_cubit.dart';
import 'package:nguru/logic/form_validation/form_validation_cubit.dart';
import 'package:nguru/logic/gallery_cubit/gallery_cubit.dart';
import 'package:nguru/logic/gallery_item_list/gallery_item_list_cubit.dart';
import 'package:nguru/logic/infirmary/infirmary_cubit.dart';
import 'package:nguru/logic/library/history/library_history_cubit.dart';
import 'package:nguru/logic/library/issue_book/issue_book_cubit.dart';
import 'package:nguru/logic/library/search_book/search_book_cubit.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/logic/main_screen/main_screen_cubit.dart';
import 'package:nguru/logic/main_screen/main_screen_state.dart';
import 'package:nguru/logic/notification/notification_cubit.dart';
import 'package:nguru/logic/notification_list/notification_list_cubit.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_cubit.dart';
import 'package:nguru/logic/push_notification/push_notification_cubit.dart';
import 'package:nguru/logic/reset_password/reset_password_cubit.dart';
import 'package:nguru/logic/signout/signout_cubit.dart';
import 'package:nguru/logic/timetable/timetable_cubit.dart';
import 'package:nguru/logic/transport/transport_cubit.dart';
import 'package:nguru/models/attendance_bar_chart_model.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/screens/activity_screen.dart';
import 'package:nguru/screens/addschool/addSchool_screen.dart';
import 'package:nguru/screens/attendance/attendace_card_screen.dart';
import 'package:nguru/screens/attendance/attendance_bar_graph_screen.dart';
import 'package:nguru/screens/calendar_screen.dart';
import 'package:nguru/screens/circular_screen.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/discipline_screen.dart';
import 'package:nguru/screens/fees/fee_main_screen.dart';
import 'package:nguru/screens/infirmary_screen.dart';
import 'package:nguru/screens/library_screen.dart';
import 'package:nguru/screens/setting_screen.dart';
import 'package:nguru/screens/story/story_screen.dart';
import 'package:nguru/screens/testing_story.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:nguru/utils/story.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('listItems');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//  Future<void> getSharedPref() async{
//    isAlreadyLoggedIn = SharedPref.getLoggedInStatus();
//  }
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
          create: (context) => FeesCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => AttendanceCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => FormValidationCubit(),
        ),
        BlocProvider(
          create: (context) => TimeTableCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => NotificationListCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => TransportCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => CommunicationCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ChatSendButtonCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => FeeListCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ParticularMonthAttendanceCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => AttendanceBarChartCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ChatCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => InfirmaryCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ActivityCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => LibraryIssueBookCubit(AuthRepo()),
        ),
        
        BlocProvider(
          create: (context) => InfirmaryCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => GalleryItemListCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => CumulativeAttendanceCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => MainScreenCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => CalendarEventCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => LibraryIssueBookCubit(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => LibraryHistoryCubit(AuthRepo()),
        ),
         BlocProvider(
          create: (context) => LibrarySearchBookCubit(AuthRepo()),
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
            home: const NguruMainScreen()),
      ),
    );
  }
}

class NguruMainScreen extends StatefulWidget {
  const NguruMainScreen({super.key});

  @override
  State<NguruMainScreen> createState() => _NguruMainScreenState();
}

class _NguruMainScreenState extends State<NguruMainScreen> {
  @override
  void initState() {
    context.read<MainScreenCubit>().mainScreenLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MainScreenCubit, MainScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MainScreenLoadingState) {
            return const Scaffold(
              body: SizedBox(),
            );
          } else if (state is MainScreenLoggedInStatusState) {
            return const NguruDashboardScreen();
          } else if (state is MainScreenAddSchoolScreenState) {
            return const AddSchool(isAddSchoolScreen: false);
          } else if (state is MainScreenErrorState) {
            return const Scaffold(
                body: Center(
              child: Text("Relaunch Please!"),
            ));
          } else {
            return const Scaffold(
                body: Center(
              child: Text("Undifined state!"),
            ));
          }
        },
      ),
    );
  }
}
