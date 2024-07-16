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

class CircularScreen extends StatefulWidget {
  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
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
            
            screenTitleHeader("Circular"),
            
            5.widthBox,
            Row(
           //   mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                animatedbutton(),
                10.widthBox,
                animatedbutton(),
              10.widthBox,
              animatedbutton(),

             
              ],
            ),
            10.heightBox,

           

           circularCalendar(),
          
             
            Flexible(
              child: PageView.builder(
               itemCount: 6,
               itemBuilder:(context, index) => ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CardDesign(context);
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
    height: MediaQuery.sizeOf(context).height * 0.10,
    // width: MediaQuery.sizeOf(context).width * 0.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: MyColors.searchbackgroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(MyAssets.bookz),
          10.widthBox,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Important Reminders for Students..",
                  style: FontUtil.circularTitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lorem ipsum dolor sit amet consectetur.\n Eros eget posuere faucibus lectus congue.",
                      style: FontUtil.circularsubttile,
                    ),
                    IconButton(
                        onPressed: () {}, icon: SvgPicture.asset(MyAssets.seen))
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


GradientBorderButton animatedbutton(){
  return GradientBorderButton();
}
class GradientBorderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the button width and height based on screen size
    final buttonWidth = screenWidth * 0.12;
    final buttonHeight = screenHeight * 0.03;

    return Container(
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
            Text(
              'All',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.close,
              color: Colors.black,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
