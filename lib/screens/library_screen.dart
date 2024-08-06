import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_calendar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController searchBarController = TextEditingController();
  DateTime _focusedDay = DateTime.now();

      List<String> months = [
      "Issued Book",
      "Reserved",
      "History",
    ];
    int seletedIndex=0;

    DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  CustomSearchBar(
                    controller: searchBarController,
                    hintText: "search",
                  ),
                  10.heightBox,
                  screenTitleHeader("Library",
                      onPressed: () => Navigator.pop(context)),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildCategorySelector(),
                    ],
                  ),
                
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.66,
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 200,
                          crossAxisSpacing: 10,
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: MyColors.boarderColor,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("The Blue Umbrella",style: FontUtil.customStyle(fontSize: 12, fontWeight: FontWeight.w600, textColor: MyColors.boldTextColor),),
                                  Text("Ruskin Bond",style: FontUtil.customStyle(fontSize: 10, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),),
                                  Stack(
                                    children: [
                                      Image.asset("assets/images/book_cover_2.png",scale: 4,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 28,top: 10),
                                        child: SizedBox(
                                          height: 20,
                                          width: 50,
                                          child: customTags("0002UG092153", MyColors.greenShade_4, MyColors.white,fontSize: 6)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 90,left: 6),
                                        child: SizedBox(
                                          height: 20,
                                          width: 60,
                                          child: customTags("April 24, 2024", MyColors.redShade_3, MyColors.white,fontSize: 6)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("User Accession No: ",style: FontUtil.customStyle(fontSize: 9, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),),
                                      Text("15799",style: FontUtil.customStyle(fontSize: 10, fontWeight: FontWeight.w600, textColor: MyColors.boldTextColor),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Issue Date: ",style: FontUtil.customStyle(fontSize: 9, fontWeight: FontWeight.w500, textColor: MyColors.fadedTextColor),),
                                      Text("20th Apr 2024",style: FontUtil.customStyle(fontSize: 10, fontWeight: FontWeight.w600, textColor: MyColors.boldTextColor),),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  seletedIndex == 0 ? 
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width *0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              color: MyColors.yellowShade_5,
                          ),
                          5.widthBox,
                          Text("Due  Date",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),
                        
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width *0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              color: MyColors.redShade_3,
                          ),
                          5.widthBox,
                          Text("Late",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),
                        
                          ],
                        ),
                      ),
                    ],
                  ) :


                  seletedIndex ==1 ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PrimaryButton(title: "Reserved", onPressed: (){
                     customModalBottomSheet(context);
                    }),
                  ) :

                 seletedIndex == 2 ?  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width *0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              color: MyColors.greenShade_3,
                          ),
                          5.widthBox,
                          Text("On time submission",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),
                        
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width *0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              color: MyColors.redShade_3,
                          ),
                          5.widthBox,
                          Text("Late Submission",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),),
                        
                          ],
                        ),
                      ),
                    ],
                  ) :const SizedBox()
                   
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget customCalendar (BuildContext context){
    return TableCalendar(
                // calendarBuilders: CalendarBuilders(
                //   defaultBuilder: (context, day, focusedDay) {
                //     final dayIndex = day.day - 1;            
                //     Color textColor = Colors.black;
                //     int attendanceStatus = state.particularMonthAttendanceModel
                //         .attendanceMonth![dayIndex].status!;
                //     if (attendanceStatus == 0) {
                //       textColor = Colors.green;
                //     } else if (attendanceStatus == 3) {
                //       textColor = Colors.red;
                //     } else {
                //       textColor = Colors.black;
                //     }
                //     return Center(
                //       child: Text(
                //         '${day.day}',
                //         style: TextStyle(color: textColor, fontSize: 16),
                //       ),
                //     );
                //   },
                // ),
                rowHeight: 45,
                daysOfWeekHeight: 20,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: FontUtil.customStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      textColor: MyColors.calendarDateColor),
                  weekendStyle: FontUtil.customStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w200,
                      textColor: MyColors.calendarDateColor),
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                  defaultTextStyle: FontUtil.customStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      textColor: MyColors.calendarDateColor),
                  weekendTextStyle: FontUtil.customStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      textColor: MyColors.fadedTextColor),
                  selectedTextStyle: FontUtil.customStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.blue),
                  todayTextStyle: FontUtil.customStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.pink),
                  todayDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                ),
                headerVisible: false,
                startingDayOfWeek: StartingDayOfWeek.monday,
              );
  }








    Widget buildMonthSelector() {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          bool isSelected = _focusedDay.month == months.indexOf(month) + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    months.indexOf(month) + 1,
                  );
                });
               
              },
              child: isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return MyColors.buttonColors.createShader(bounds);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white, // This color is not visible
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          month,
                          style: FontUtil.customStyle(
                            fontSize: 10,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                            textColor: MyColors.monthNameColor,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey, // This color is not visible
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        month,
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                          textColor: MyColors.monthNameColor,
                        ),
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }










  void customModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 430,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                10.heightBox,

                Container(
                  height: 8,
                  width: MediaQuery.of(context).size.width *0.3,
                  decoration: 
                  BoxDecoration(
                    gradient: MyColors.buttonColors,
                    borderRadius: BorderRadius.circular(30)),
                ),
                10.heightBox,
                buildMonthSelector(),
                10.heightBox,
                customCalendar(context),
             //   CustomCalendar(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PrimaryButton(
                   title: "Reserve",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                10.heightBox
              ],
            ),
          ),
        );
      },
    );
  }






  Widget _buildCategorySelector() {


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: months.map((month) {
          bool isSelected = _focusedDay.month == months.indexOf(month) + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    months.indexOf(month) + 1,
                  );
                });
                seletedIndex = months.indexOf(month);
                log("selected: ${months.indexOf(month)}");
              },
              child: isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return MyColors.buttonColors.createShader(bounds);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white, // This color is not visible
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          month,
                          style: FontUtil.customStyle(
                            fontSize: 10,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                            textColor: MyColors.monthNameColor,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey, // This color is not visible
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        month,
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                          textColor: MyColors.monthNameColor,
                        ),
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
