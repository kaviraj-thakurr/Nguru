import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_view/story_view.dart';
import 'package:pdf/widgets.dart' as pw;

class DisciplineStoryScreen extends StatefulWidget {
  final DisciplineList? disciplineList;
  final StoryController? storyController;
  const DisciplineStoryScreen({super.key, this.disciplineList, this.storyController});

  @override
  State<DisciplineStoryScreen> createState() => _DisciplineStoryScreenState();
}

class _DisciplineStoryScreenState extends State<DisciplineStoryScreen> {

  Future<void> requestPermissions() async {
  if (await Permission.storage.request().isGranted) {
    // Permissions are granted
  } else {
    // Permissions are denied
  }
}

Future<void> generateAndSavePDF(String textContent) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text(textContent),
      ),
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/example.pdf');

  await file.writeAsBytes(await pdf.save());
  print('PDF saved to ${file.path}');
}



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.greenShade_1,
          floatingActionButton: GestureDetector(
              onTap: ()=>Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/images/back.svg",
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/assignment_icon.svg",
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Flexible(
                            child: Text(
                          "Discipline",
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                     widget.disciplineList!.teacherName !=null ?    "Teacher Name: ${ widget.disciplineList!.teacherName}" : "N/A",
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              textColor: Colors.black),
                        ),
                        Text(
                     widget.disciplineList!.reason !=null ?   "Reason: ${widget.disciplineList!.reason}" :  "N/A",
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.fadedTextColor),
                        ),
                              Text(
                     widget.disciplineList!.points !=null ?   "Points: ${ widget.disciplineList!.points}" :  "N/A",
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              textColor: MyColors.fadedTextColor),
                        ),
                        SizedBox(
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.9,
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/icons/assignment.png"),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: screenHeight * 0.01,
                                        ),
                                        Flexible(
                                            child: Text(
                                         widget.disciplineList!.reason !=null ?   " Reason: ${widget.disciplineList!.reason}":   "The Oak Tree | Ch.2 | Class XI B",
                                          style: FontUtil.customStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
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
                                             widget.disciplineList!.actionDate !=null ?   " Date: ${widget.disciplineList!.actionDate}"  : "09:00 am",
                                              style: FontUtil.customStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  textColor:
                                                      MyColors.greyShade_3),
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
                                      Spacer(),
                                      GestureDetector(
                                         
                                         onTap: ()=>requestPermissions().then((value) => generateAndSavePDF(widget.disciplineList.toString())),
                                        child: SvgPicture.asset(
                                          "assets/icons/download.svg",
                                          height: 25,
                                          width: 25,
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
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
