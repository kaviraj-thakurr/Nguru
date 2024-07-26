import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/fees/fees_cubit.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';
import 'package:nguru/screens/addSchool_screen.dart';
import 'logic/assignment/assignment_month_list/assignment_month_list_cubit.dart';
import 'logic/assignment/assignments_list/asssignment_list_cubit.dart';
import 'logic/circular/circular_cubit.dart';
import 'logic/contact_us_cubit/contact_us_cubit.dart';
import 'logic/dashboard/dashboard_cubit.dart';
import 'logic/descipline/descipline_cubit.dart';
import 'logic/forgot_password/forgot_password_cubit.dart';
import 'logic/gallery_cubit/gallery_cubit.dart';
import 'logic/notification/notification_cubit.dart';
import 'logic/push_notification/push_notification_cubit.dart';
import 'logic/reset_password/reset_password_cubit.dart';
import 'logic/signout/signout_cubit.dart';


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
          create: (context) => FeesCubit(AuthRepo()),
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
            home:
              //  ContactScreen()
                //    TimetableScreen()
                //   CircularScreen()
                //  CircularCalendar()
                //AssignmentScreen()
               AddSchool()
         //  const SettingScreen()


        //  AddSchool(),
            ),
      ),
    );
  }
}
