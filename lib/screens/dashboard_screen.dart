import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_card.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class NguruDashboardScreen extends StatefulWidget {
  const NguruDashboardScreen({super.key});

  @override
  State<NguruDashboardScreen> createState() => _NguruDashboardScreenState();
}

class _NguruDashboardScreenState extends State<NguruDashboardScreen> {
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: dashboardAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customCard(
                  context: context,
                  title: 'Your Title',
                  content: 'Your Content',
                  titleSize: 20.0,
                  contentSize: 10.0,
                  icon: Icons.arrow_forward,
                  onIconPressed: () {
                    print("forward");
                  },
                  cardHeight: screenHeight * 0.16,
                  cardWidth: screenWidth * 0.52,
                ),
                customCard(
                  context: context,
                  title: 'Your Title',
                  content: 'Your Content',
                  titleSize: 20.0,
                  contentSize: 16.0,
                  icon: Icons.arrow_forward,
                  cardHeight: screenHeight * 0.16,
                  cardWidth: screenWidth * 0.40,
                  onIconPressed: () {
                    print("forward");
                  },
                ),
              ],
            ),

            SizedBox(height: 10,),


            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                 customCard(
                  context: context,
                  title: 'Your Title',
                  content: 'Your Content',
                  titleSize: 20.0,
                  contentSize: 16.0,
                  icon: Icons.arrow_forward,
                  cardHeight: screenHeight * 0.16,
                  cardWidth: screenWidth * 0.40,
                  onIconPressed: () {
                    print("forward");
                  },
                ),
            
                customCard(
                context: context,
                title: 'Your Title',
                content: 'Your Content',
                titleSize: 20.0,
                contentSize: 10.0,
                icon: Icons.arrow_forward,
                onIconPressed: () {
                  print("forward");
                },
                cardHeight: screenHeight * 0.16,
                cardWidth: screenWidth * 0.52,
              ),
                
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customCard({
  
    required BuildContext context,
    required String title,
    required String content,
    required double titleSize,
    required double contentSize,
    required IconData icon,
    required VoidCallback onIconPressed,
    double? cardHeight, // Default height
    double? cardWidth, // Default width
  }) {
    return Container(
      
      height: cardHeight,
      width: cardWidth,
      
      decoration: BoxDecoration(
          gradient: MyColors.cardColors,
          borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: onIconPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  fontSize: contentSize,
                  color: Colors.black54,
                ),
              ),
              IconButton(
                icon: Icon(icon),
                onPressed: onIconPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
