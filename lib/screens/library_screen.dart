import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/library/history/library_history_cubit.dart';
import 'package:nguru/logic/library/history/library_history_state.dart';
import 'package:nguru/logic/library/issue_book/issue_book_cubit.dart';
import 'package:nguru/logic/library/issue_book/issue_book_state.dart';
import 'package:nguru/logic/library/search_book/search_book_cubit.dart';
import 'package:nguru/logic/library/search_book/search_book_state.dart';
import 'package:nguru/models/library_book_search_model.dart';
import 'package:nguru/models/library_history_model.dart';
import 'package:nguru/models/library_issued_book_model.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController searchBarController = TextEditingController();
  DateTime currentDateForCheckingDueDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<String> months = [
    "Issued Book",
    "Reserved",
    "History",
  ];
  int seletedIndex = 0;

  DateTime? _selectedDay;

  @override
  void initState() {
    context.read<LibraryIssueBookCubit>().getLibraryIssueBook();
    context.read<LibraryHistoryCubit>().getLibraryHistory();
  //  context.read<LibrarySearchBookCubit>().getLibrarySearchBook();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Image.asset(MyAssets.background_2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomAppBar(),
                    CustomSearchBar(
                      controller: searchBarController,
                      hintText: MyStrings.search,
                      onSubmitted:(String value)=> value.isEmpty ? null : context.read<LibrarySearchBookCubit>().getLibrarySearchBook(searchQuery: searchBarController.text.toString()),
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
                    seletedIndex == 0
                        ? issuedBook(context)
                        : seletedIndex == 1
                            ? reserveBook(context)
                            : seletedIndex == 2
                                ? historyBook(context)
                                : SizedBox(),
                    footer(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget historyBook(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.66,
      width: double.infinity,
      child: BlocConsumer<LibraryHistoryCubit, LibraryHistoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LibraryHistoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LibraryHistorySuccessState) {
              return GridView.builder(
                  itemCount: state.libraryHistory.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return book(context,
                        libraryHistory: state.libraryHistory[index]);
                  });
            } else if (state is LibraryHistoryErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            } else {
              return Center(
                child: Text(
                  MyStrings.undefinedState,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            }
          }),
    );
  }

  Widget reserveBook(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.66,
      width: double.infinity,
      child: BlocConsumer<LibrarySearchBookCubit, LibrarySearchBookState>(
          listener: (context, state) {},
          builder: (context, state) {

             if (state is LibrarySearchBookInitialState) {
              return Center(
                child: Text(
                  "No Search Yet!",
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );;
            }

           else if (state is LibrarySearchBookLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LibrarySearchBookSuccessState) {
              return state.librarySearch.isEmpty ? 
               Center(child: Text("No Book Found!",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),)) 
              :  GridView.builder(
                  itemCount: state.librarySearch.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return  book(context,
                        librarySearch: state.librarySearch[index]);
                  });
              //  return Center(child: Text("data"),);
            } else if (state is LibrarySearchBookErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            } else {
              return Center(
                child: Text(
                  MyStrings.undefinedState,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            }
          }),
    );
  }

  Widget issuedBook(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.66,
      width: double.infinity,
      child: BlocConsumer<LibraryIssueBookCubit, LibraryIssueBookState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LibraryIssueBookLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LibraryIssueBookSuccessState) {
              return GridView.builder(
                  itemCount: state.libraryIssued.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 200,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return book(context,
                        libraryIssued: state.libraryIssued[index]);
                  });
            } else if (state is LibraryIssueBookErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            } else {
              return Center(
                child: Text(
                  MyStrings.undefinedState,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
              );
            }
          }),
    );
  }

  Widget book(BuildContext context,
      {LibraryIssued? libraryIssued,
      LibraryHistory? libraryHistory,
      LibrarySearch? librarySearch}) {
    var bookName = libraryHistory?.bookName ??
        libraryIssued?.bookName ??
        librarySearch?.bookName;
    var authorName = librarySearch?.authorName;
    var accessionNo = libraryHistory?.accessionNo ??
        libraryIssued?.accessionNo ??
        librarySearch?.accessionNo;
    var dueDate = libraryHistory?.returnDate ?? libraryIssued?.dueDate;
    var issueDate = libraryHistory?.issueDate ?? libraryIssued?.issueDate;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        padding: const EdgeInsets.all(2),
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
            Text(
              bookName ?? "Book Name: N/A",
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: FontUtil.customStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: MyColors.boldTextColor),
            ),
            Text(
              //libraryIssued?.bookName ??
              authorName ?? "Author Name: N/A",
              style: FontUtil.customStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.fadedTextColor),
            ),
            Stack(
              children: [
                Image.asset(
                  MyAssets.bookCover,
                  scale: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 10),
                  child: SizedBox(
                      height: 17,
                      width: 50,
                      child: customTags(
                          verticalPadding: 0.1,
                          horizontalPadding: 0.1,
                          accessionNo.toString() ?? "0002UG092153",
                          MyColors.greenShade_4,
                          MyColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.5)),
                ),
                librarySearch?.accessionNo == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 90, left: 6),
                        child: SizedBox(
                            height: 17,
                            width: 50,
                            child: customTags(
                                //  currentDateForCheckingDueDate.isAfter(DateFormat("dd MMM yyyy").parse(libraryIssued?.dueDate ?? ""))
                                //   ? libraryIssued?.dueDate : libraryIssued?.issueDate ?? "April 24, 2024",
                                dueDate.toString() ?? "Date: N/A",

                                // currentDateForCheckingDueDate.isAfter(
                                //         DateFormat("dd MMM yyyy")
                                //             .parse(libraryIssued?.dueDate ?? ""))
                                currentDateForCheckingDueDate.isAfter(
                                        DateFormat("dd MMM yyyy")
                                            .parse(dueDate ?? ""))
                                    ? MyColors.redShade_3
                                    : MyColors.yellowShade_5,
                                MyColors.white,
                                verticalPadding: 0.1,
                                horizontalPadding: 0.1,
                                fontWeight: FontWeight.w600,
                                fontSize: 6)),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "User Accession No: ",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: FontUtil.customStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.fadedTextColor.withOpacity(0.7)),
                ),
                Flexible(
                  child: Text(
                    "$accessionNo",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: FontUtil.customStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        textColor: MyColors.fadedTextColor),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                librarySearch?.accessionNo == null
                    ? Text(
                        "Issue Date: ",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: FontUtil.customStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            textColor:
                                MyColors.fadedTextColor.withOpacity(0.7)),
                      )
                    : const SizedBox(),
                librarySearch?.accessionNo == null
                    ? Text(
                        issueDate.toString() ?? "Date: N/A",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: FontUtil.customStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            textColor: MyColors.fadedTextColor),
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget footer(BuildContext context) {
    return seletedIndex == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      color: MyColors.yellowShade_5,
                    ),
                    5.widthBox,
                    Text(
                      "Due Date",
                      style: FontUtil.customStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.boldTextColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      color: MyColors.redShade_3,
                    ),
                    5.widthBox,
                    Text(
                      "Late",
                      style: FontUtil.customStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.boldTextColor),
                    ),
                  ],
                ),
              ),
            ],
          )
        : seletedIndex == 1
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: PrimaryButton(
                    title: "Reserved",
                    onPressed: () {
                      customModalBottomSheet(context);
                    }),
              )
            : seletedIndex == 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              color: MyColors.greenShade_3,
                            ),
                            5.widthBox,
                            Text(
                              "On time submission",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.boldTextColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              color: MyColors.redShade_3,
                            ),
                            5.widthBox,
                            Text(
                              "Late Submission",
                              style: FontUtil.customStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textColor: MyColors.boldTextColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox();
  }

  Widget customCalendar(BuildContext context) {
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
            fontSize: 13, fontWeight: FontWeight.w700, textColor: Colors.blue),
        todayTextStyle: FontUtil.customStyle(
            fontSize: 13, fontWeight: FontWeight.w700, textColor: Colors.pink),
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
    // List<String> months = [
    //   "Jan",
    //   "Feb",
    //   "Mar",
    //   "Apr",
    //   "May",
    //   "Jun",
    //   "Jul",
    //   "Aug",
    //   "Sep",
    //   "Oct",
    //   "Nov",
    //   "Dec"
    // ];

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
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
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
