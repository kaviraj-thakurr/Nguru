import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_utils.dart';

class CircularScreen extends StatefulWidget {
  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      height:MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
        child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: dashboardAppBar(),
              ),
        Positioned(
          top: -150,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
           //   color: Colors.white.withOpacity(0.1), // Semi-transparent color
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColors.appColor2.withOpacity(0.28), // Shadow color
                  spreadRadius: 0,
                  blurRadius: 100,
                  
                 // offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
          Positioned(
          top: -150,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
           //   color: Colors.white.withOpacity(0.1), // Semi-transparent color
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MyColors.appColor1.withOpacity(0.28), // Shadow color
                  spreadRadius: 0,
                  blurRadius: 100,
                  
                 // offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
        
        
            ],
            ),
      )
    );
  }
}