import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_progress_bar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/screens/circular_calendar.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class AssignmentScreen extends StatefulWidget {
  @override
  State<AssignmentScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<AssignmentScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            dashboardAppBar(),
            CustomSearchBar(controller: searchController),
            
            screenTitleHeader("Assignment"),
            5.widthBox,

            circularCalendar(),
            Row(
           //   mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                animatedButton(context,"All"),
                10.widthBox,
                animatedButton(context,"Read"),
              10.widthBox,
              animatedButton(context,"Unread"),
              ],
            ),
            
             
            Expanded(
              child: PageView.builder(
               itemCount: 2,
               itemBuilder:(context, index) => ListView.builder(
                  itemCount: 5,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CardDesign(context),
                    );
                  },
                ),
                  
                
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
IconButton(onPressed: (){}, icon: SvgPicture.asset(MyAssets.back_arrow)),
IconButton(onPressed: (){}, icon: SvgPicture.asset(MyAssets.front_arrow)),

              ],
            ),
            // Text('asdasdas')
            CustomProgressBar(progress: 0.3,dotCount: 0,)
           
          ],
        ),
      ),
     
    );
  }
}

Widget CardDesign(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.14,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: MyColors.searchbackgroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(MyAssets.bookz, height: 50),  // Adjust height based on requirement
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The Oak Tree | Ch.2 | Class XI B",
                  style: FontUtil.circularTitle,
                ),
                AppGapping.padding5,
                Text(
                  "Lorem ipsum dolor sit amet consectetur.\nEros eget posuere faucibus lectus congue.",
                  style: FontUtil.circularsubttile,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dateWidget(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(MyAssets.seen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



  
  Widget animatedButton(BuildContext context, String title) {
  // Get the screen width and height
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  // Calculate the button width and height based on screen size
  final buttonWidth = screenWidth * 0.15;
  final buttonHeight = screenHeight * 0.03;

  return InkWell(
    onTap: (){},
    child: Container(
      margin: EdgeInsets.all(2),
      width: buttonWidth,
      height: buttonHeight,
      padding: EdgeInsets.all(1), // Border width
      decoration: BoxDecoration(
        gradient: MyColors.arrowColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 2),
            Icon(
              Icons.close,
              color: Colors.black,
              size: 12,
            ),
          ],
        ),
      ),
    ),
  );
}


Date dateWidget(){
  return Date();
}
class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the button width and height based on screen size
    final buttonWidth = screenWidth * 0.20;
    final buttonHeight = screenHeight * 0.03;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.all(1), // Border width
      decoration: BoxDecoration(
       
        
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: MyColors.assignmentDate,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Jyly 14,2024',
                style: TextStyle(
                  color: MyColors.assignmentdateColor,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 8),
          
          ],
        ),
      ),
    );
  }
}
