import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';
import 'package:nguru/screens/addSchool_screen.dart';
import 'package:nguru/screens/attendence_screen.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/theme/app_theme.dart';
import 'screens/login_screen.dart';


//creds- school url: https://quickschool.niitnguru.com/demoschool , password: google1s

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
       create: (context) => AddSchoolCubit(AuthRepo())),
        BlocProvider(
       create: (context) => LoginCubit(AuthRepo())),

      ],
      child: ScreenUtilInit(
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        home:
        
             const AttendenceScreen()
        // CalendarScreen(),
        //AddSchool(),
            //  home: NguruDashboardScreen(),
        ),
      ),
    );
  }
}
