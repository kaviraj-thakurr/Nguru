import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/screens/settings/add_feedback_screen.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  State<FeedbackListScreen> createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            MyAssets.bg,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              20.heightBox,
              dashboardAppBar(),
              10.heightBox,
              screenTitleHeader("FeedBack", onPressed: ()=> Navigator.pop(context)),
              10.heightBox,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Expanded(
                     child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context,index){
                          return const Center(child: Text("No data"),);
                     }),
                   ),
                    PrimaryButton(title: "Add Feedback", onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddFeedBackScreen())))
                  ],
                ),
              )
            ]
    )
          ),
        ]
      )
    );
  }
}