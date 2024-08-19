import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:velocity_x/velocity_x.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {

  List<String> buttons =[
    "Report Cards",
    "Schedule",
    "Exam Marks"
  ];
  DateTime _focusedDay = DateTime.now();
    void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _focusedDay = selectedDay;
    });
   }
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              MyAssets.bg,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(padding12),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customAppBar(),
                  5.heightBox,
                  CustomSearchBar(controller: searchController),
                  12.heightBox,

                  buildSelector(buttons,_focusedDay,_onDaySelected),
                  10.heightBox,
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return TimetableCardType1(
                          subject: "Unit $index",
                          time: "Time $index",
                          term: "Term 1",
                        ).pSymmetric(v: 8); // Padding between cards
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimetableCardType1 extends StatelessWidget {
  final String subject;
  final String  term;
  final String time;

  const TimetableCardType1({
    required this.subject,
    required this.time,
    required this .term,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: double.infinity,
      decoration: BoxDecoration(
       color: MyColors.searchBox, borderRadius: BorderRadius.circular(6)),
      
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                 Text(
                  subject,
                  style: FontUtil.customStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.w500,
                   textColor: MyColors.addButtonColor,
                  ),
                ),
                  Text(
                 term,
                 style: FontUtil.customStyle(
                   fontSize: 12,
                   fontWeight: FontWeight.w500,
                   textColor: MyColors.teacherNameColor
                 ),
                  )

              ],
            ),

            Column(
              children: [
 IconButton(onPressed: (){}, icon: SvgPicture.asset(MyAssets.examDown)),
              ],
            )
            
          
          
            
            
          ],
        ),
      ),
    );
  }
}
Widget buildSelector(List<String> selecterItems, DateTime focusedDay, Function(DateTime) onDaySelected,) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: selecterItems.map((month) {
          bool isSelected = focusedDay.month == selecterItems.indexOf(month) + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                onDaySelected(
                DateTime(
                  focusedDay.year,
                  selecterItems.indexOf(month) + 1,
                ),
              );
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