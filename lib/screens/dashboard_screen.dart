import 'package:advstory/advstory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/attendence_and_fee_card.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_card.dart';
import 'package:nguru/custom_widgets/custom_floating_action_button.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/custom_widgets/person_card.dart';
import 'package:nguru/screens/stories.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class NguruDashboardScreen extends StatefulWidget {
  const NguruDashboardScreen({super.key});

  @override
  State<NguruDashboardScreen> createState() => _NguruDashboardScreenState();
}

class _NguruDashboardScreenState extends State<NguruDashboardScreen> {
  TextEditingController searchController = TextEditingController();

  String personName = '';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: dashboardAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomSearchBar(
                  controller: searchController,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    20.heightBox,
                    personInfoCard(
                      context,
                      "https://via.placeholder.com/150",
                      personName,
                      "XI B",
                      "1237/AA/2023B",
                      (String newName) {
                        setState(() {
                          personName = newName;
                        });
                      },
                    ),
                    15.heightBox,
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.23,
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          attendenceAndFeeCard(
                            context,
                            mainText: "53%",
                            footerText: "Attendence",
                          ),
                          attendenceAndFeeCard(context,
                              headerText: "Paid 23k",
                              mainText: "23k",
                              footerText: "Advance 23k")
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GradientCircleAvatar(
                            radius: 38,
                            title: "Assignment",
                            gradient: MyColors.arrowColor,
                            child: Image.network(
                                'https://via.placeholder.com/150'),
                          ),
                          8.widthBox,
                          GradientCircleAvatar(
                            radius: 38,
                            gradient: MyColors.arrowColor,
                            title: "Circular",

                            child: Image.network(
                                'https://via.placeholder.com/150'),
                          ),
                          8.widthBox,
                          GradientCircleAvatar(
                            radius: 38,
                            title: "Discipline",
                            gradient: MyColors.arrowColor,
                            child: Image.network(
                                'https://via.placeholder.com/150'),
                          ),

                        ],
                      ),
                      18.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customCard(
                            context: context,
                            title: MyStrings.timeTable,
                            content: MyStrings.timeTablesub,
                            isPngImage: false,
                            titleSize: 20.0,
                            contentSize: 10.0,
                            icon: Icons.arrow_forward,
                            onIconPressed: () {
                              print("forward");
                            },
                            cardHeight: screenHeight * 0.14,
                            cardWidth: screenWidth * 0.50,
                            image: MyAssets.timetable_card_image,
                          ),
                          customCard(
                            context: context,
                            title: MyStrings.examination,
                            content: MyStrings.examinationsub,
                            isPngImage: true,
                            titleSize: 20.0,
                            contentSize: 16.0,
                            icon: Icons.arrow_forward,
                            cardHeight: screenHeight * 0.14,
                            cardWidth: screenWidth * 0.40,
                            image: MyAssets.exams,
                            onIconPressed: () {
                              print("forward");
                            },
                          ),
                        ],
                      ),
                      AppGapping.padding10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customCard(
                            context: context,
                            title: MyStrings.calender,
                            content: MyStrings.calendarsub,
                            isPngImage: false,
                            titleSize: 20.0,
                            contentSize: 16.0,
                            icon: Icons.arrow_forward,
                            cardHeight: screenHeight * 0.14,
                            cardWidth: screenWidth * 0.40,
                            onIconPressed: () {
                              print("forward");
                            },
                            image: MyAssets.calendar,
                          ),
                          customCard(
                            context: context,
                            title: MyStrings.activity,
                            content: MyStrings.activitysub,
                            isPngImage: false,
                            titleSize: 20.0,
                            contentSize: 10.0,
                            icon: Icons.arrow_forward,
                            onIconPressed: () {
                              print("forward");
                            },
                            cardHeight: screenHeight * 0.14,
                            cardWidth: screenWidth * 0.50,
                            image: MyAssets.activity,
                          ),
                        ],
                      ),
                      AppGapping.padding10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customCard(
                            context: context,
                            title: MyStrings.Library,
                            content: MyStrings.Librarysub,
                            titleSize: 20.0,
                            contentSize: 10.0,
                            isPngImage: false,
                            icon: Icons.arrow_forward,
                            onIconPressed: () {
                              print("forward");
                            },
                            cardHeight: screenHeight * 0.20,
                            cardWidth: screenWidth * 0.30,
                            image: MyAssets.library,
                          ),
                          customCard(
                            context: context,
                            title: MyStrings.infirmary,
                            content: MyStrings.infirmarysub,
                            titleSize: 20.0,
                            contentSize: 10.0,
                            isPngImage: false,
                            icon: Icons.arrow_forward,
                            onIconPressed: () {
                              print("forward");
                            },
                            cardHeight: screenHeight * 0.20,
                            cardWidth: screenWidth * 0.30,
                            image: MyAssets.infirmary,
                          ),
                          customCard(
                            context: context,
                            title: MyStrings.gallery,
                            content: MyStrings.gallerysub,
                            titleSize: 10.0,
                            contentSize: 10.0,
                            icon: Icons.arrow_forward,
                            isPngImage: false,
                            onIconPressed: () {
                              print("forward");
                            },
                            image: MyAssets.gallery,
                            cardHeight: screenHeight * 0.20,
                            cardWidth: screenWidth * 0.30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SvgPicture.asset(MyAssets.examination),
              ],
            ),
          ),
        ),
        // floatingActionButton: customFloatingActionButton(context),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget customCard(
      {required BuildContext context,
      required String title,
      required String content,
      required double titleSize,
      required double contentSize,
      required IconData icon,
      required VoidCallback onIconPressed,
      required String image,
      double? cardHeight, // Default height
      double? cardWidth,
      bool? isPngImage // Default width
      }) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(1),
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
            gradient: MyColors.cardColors,
            borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: onIconPressed,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, maxLines: 2, style: FontUtil.cardTitle),
                Text(content, maxLines: 2, style: FontUtil.cardsubTitle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.bottomLeft,
                      icon: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return MyColors.arrowColor.createShader(bounds);
                        },
                        child: Icon(
                          icon,
                          color: Colors
                              .white, // This color is not visible but needs to be set.
                        ),
                      ),
                      color: Colors
                          .transparent, // This ensures the IconButton itself doesn't have a color.
                      onPressed: onIconPressed,
                    ),
                    Flexible(
                        child: isPngImage == false
                            ? SvgPicture.asset(image)
                            : Image.asset(image))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showStories(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Stories'),
          ),
          body: Center(
            child: AdvStory(
              storyCount: 5,
              storyBuilder: (storyIndex) => Story(
                contentCount: 10,
                contentBuilder: (contentIndex) => const ImageContent(
                  url: "https://via.placeholder.com/150",
                ),
              ),
              trayBuilder: (index) => AdvStoryTray(
                url: "https://via.placeholder.com/150",
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget storyViewer() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.13,
      child: AdvStory(
        storyCount: 3,
        storyBuilder: (storyIndex) => Story(
          contentCount: 3,
          contentBuilder: (contentIndex) => const ImageContent(
            header: Text("data"),
            url: "https://via.placeholder.com/150",
          ),
        ),
        trayBuilder: (index) => Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                width: 2), // Change the border color and width here
            borderRadius:
                BorderRadius.circular(12), // Adjust the border radius as needed
          ),
          child: AdvStoryTray(
            url: "https://via.placeholder.com/150",
          ),
        ),
      ),
    );
  }
}
