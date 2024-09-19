import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_gradient_border_button.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/screens/settings/setting_screen.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //39.heightBox,
            screenTitleHeader("My Profile",onPressed:()=> Navigator.pop(context)),
            20.heightBox,
            customSettingProfileWidget(context, screenWidth, screenHeight,"","","",studentPicture: ""),
            14.heightBox,
            personInfoCard(context, "https://via.placeholder.com/150",
                "personName", "classAndSection", "idNo", (p0) => {}),
            12.heightBox,
            parentDetailsCard(context, "profileImage", "personName",
                "classAndSection", "idNo", (p0) => {}),
            12.heightBox,
            transportDetailsCard(context, "profileImage", "personName",
                "classAndSection", "idNo", (p0) => {}),
                12.heightBox,
                teacherDetailsCard(context, "profileImage", "personName", "classAndSection", "idNo", (p0) =>{} ),
          ],
        ),
      ),
    );
  }
}

Widget personInfoCard(
  BuildContext context,
  String profileImage,
  String personName,
  String classAndSection,
  String idNo,
  Function(String) onNameChange,
) {
  List<String> names = ['Anshul Goswami', 'Name Surname'];

  // Ensure the personName is a valid value
  if (!names.contains(personName)) {
    personName = names.first;
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.2,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: MyColors.greyShade_4,
        width: 0.5,
      ),
    ),
    child: Column(
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            flex: 2,
            child: Text(
              "Personal Information",
              style: FontUtil.customStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  textColor: MyColors.boldTextColor),
            )),
        12.heightBox,
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: MyColors.greyShade_5,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 236, 244),
                        borderRadius: BorderRadius.circular(20.0),
                        //  border: Border.all(
                        //    color: MyColors.blueShades_1,

                        //    width: 0.5,
                        //  ),
                      ),
                      child: Text(
                        "B+",
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.darkPink,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 241, 237),
                        borderRadius: BorderRadius.circular(20.0),
                        //  border: Border.all(
                        //    color: MyColors.blueShades_1,

                        //    width: 0.5,
                        //  ),
                      ),
                      child: Text(
                        "July 14, 2024",
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.orangeShades_1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 233, 255),
                        borderRadius: BorderRadius.circular(20.0),
                        //  border: Border.all(
                        //    color: MyColors.blueShades_1,

                        //    width: 0.5,
                        //  ),
                      ),
                      child: Text(
                        "Hindu",
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 227, 242, 255),
                        borderRadius: BorderRadius.circular(20.0),
                        //  border: Border.all(
                        //    color: MyColors.blueShades_1,

                        //    width: 0.5,
                        //  ),
                      ),
                      child: Text(
                        "General",
                        style: FontUtil.customStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          textColor: MyColors.skyBlue,
                        ),
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Adhaar Card",
                          style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.textColors)),
                      const Spacer(),
                      Text("1234 4567 7890",
                          style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Email ID",
                          style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.textColors)),
                      const Spacer(),
                      Text("anshulsh@gmail.com",
                          style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),
                    ],
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

Widget parentDetailsCard(
  BuildContext context,
  String profileImage,
  String personName,
  String classAndSection,
  String idNo,
  Function(String) onNameChange,
) {
 bool isSelected =false;

  return Container(
    padding: const EdgeInsets.all(16.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.3,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: MyColors.greyShade_4,
        width: 0.5,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            flex: 2,
            child: Text(
              "Parent Details",
              style: FontUtil.customStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  textColor: MyColors.boldTextColor),
            )),
        12.heightBox,
        Row(
          children: [
            GestureDetector(
              onTap: ()=>  isSelected=!isSelected,
              child: customGradientBorderButton(isSelected, "Father")),
            8.widthBox,
            customGradientBorderButton(isSelected, "Mother"),
            8.widthBox,
             customGradientBorderButton(isSelected, "Guardian"),
          ],
        ),
         5.heightBox,
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: MyColors.greyShade_5,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     const CircleAvatar(
              backgroundImage: NetworkImage("https://via..com/150"),
              radius: 14,
            ),
            5.widthBox,
                    Text(
                      "Digvijay Singhania",
                     style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.textColors),
                    ),
                  ],
                ),
               

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  
                  children: [

                     Text("Businessman",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                                 style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),
                    
                     Text("+91-123-4567-891",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                             style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),

                                 Text("digvijays123@gmail.com",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                            style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),


                  ],
                ),
              ],
            ),
          ),
        ),
        5.heightBox,
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: MyColors.greyShade_5,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address: ",
                  style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.textColors),
                ),
                8.widthBox,
                Flexible(
                  child: Text(
                      "H/no. 29/1, Tigdi, Opp. Airforce station, Tuglakabaad, New Delhi",
                      maxLines: 2,
                      //textAlign: TextAlign.end,
                      style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget transportDetailsCard(
  BuildContext context,
  String profileImage,
  String personName,
  String classAndSection,
  String idNo,
  Function(String) onNameChange,
) {
  List<String> names = ['Anshul Goswami', 'Name Surname'];

  // Ensure the personName is a valid value
  if (!names.contains(personName)) {
    personName = names.first;
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.2,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: MyColors.greyShade_4,
        width: 0.5,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            flex: 2,
            child: Text(
              "Transport Details",
              style: FontUtil.customStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  textColor: MyColors.boldTextColor),
            )),
        12.heightBox,
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: MyColors.greyShade_5,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "School bus: ",
                  style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.textColors),
                ),
               

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                     
                      children: [
                        Text("Noida ",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                           style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),
                        SvgPicture.asset("assets/icons/route.svg"),
                        Text(" Tuglakabaad",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                             style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),
                      ],
                    ),
                     Text("Devendar Pal",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                            style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),

                                 Text("+91-123-4569-781",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                           style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),

                                 Text("Tuglakabaad",
                            maxLines: 2,
                            //textAlign: TextAlign.end,
                            style: FontUtil.customStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.textColors)),

                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}







/////////////// teacher's detail card


Widget teacherDetailsCard(
  BuildContext context,
  String profileImage,
  String personName,
  String classAndSection,
  String idNo,
  Function(String) onNameChange,
) {
  List<String> names = ['Anshul Goswami', 'Name Surname'];
  bool isSelected = false;

  // Ensure the personName is a valid value
  if (!names.contains(personName)) {
    personName = names.first;
  }

  return Container(
    padding: const EdgeInsets.all(16.0),
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.15,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: MyColors.greyShade_4,
        width: 0.5,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            flex: 2,
            child: Text(
              "Teacher's details",
              style: FontUtil.customStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  textColor: MyColors.boldTextColor),
            )),
        12.heightBox,
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: MyColors.greyShade_5,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saloni Gupta",
                  style: FontUtil.customStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: MyColors.textColors),
                ),
               

            
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
