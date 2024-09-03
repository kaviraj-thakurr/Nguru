import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/logic/dashboard/dashboard_cubit.dart';
import 'package:nguru/logic/dashboard/dashboard_state.dart';
import 'package:nguru/logic/signout/signout_cubit.dart';
import 'package:nguru/logic/signout/signout_state.dart';
import 'package:nguru/screens/login/login_screen.dart';
import 'package:nguru/screens/my_profile_screen.dart';
import 'package:nguru/screens/settings/change_siblings.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/custom_flutter_switch.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> settingitems = [
    "My Profile",
    "Change Sibling",
    //  "Change Session",
    "Add School",
    "Push Notification",
    "Change Password",
    "Feedback",
    "Terms of use",
    "Privacy & Policy",
    "Support",
    "Self Declaration",
  ];

  bool toggle = false;
   var getUserName;

  @override
  void initState() {
    context.read<DashboardCubit>().dashboardGetList();
    // TODO: implement initState
    super.initState();
   
  }

 
  

  Future <String> getUerName () async{
    
   getUserName =await SharedPref.getUerName();
return getUserName;

    
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isTap = true;
  
    

    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset("assets/icons/floating_action_button.svg")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
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
              BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                if (state is DashboardLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DashboardSuccessState) {
                  return customSettingProfileWidget(
                      context,
                      screenWidth,
                      screenHeight,
                      state.studentName!,
                      "${state.qualification} ${state.section!}",
                      state.admissionNumber!);
                } else if (state is DashboardErrorState) {
                  return customSettingProfileWidget(
                      context, screenWidth, screenHeight, "", "", "");
                } else {
                  return customSettingProfileWidget(
                      context, screenWidth, screenHeight, "", "", "");
                }
              }),
              SizedBox(
                height: screenHeight * 0.58,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: settingitems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: settingItemsListTile(
                            context, "${settingitems[index]}", isTapped: isTap,
                            onToggleChanged: (bool value) {
                          setState(() {
                            isTap = !isTap;
                            log("istap $isTap");
                          });
                          return isTap;
                        },

                            // () => {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => StoryScreen()))
                            //     },
                            isNotificationTile: false),
                      );
                    }),
              ),
              20.heightBox,
              Center(
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return MyColors.buttonColors.createShader(bounds);
                  },
                  child: Builder(builder: (context) {
                    return GestureDetector(
               onTap: () => showDialog(
  context: context,
  builder: (BuildContext context) {
    return buildLogoutAlertDialog(
      context: context,
      onLogout: () => context
          .read<SignoutCubit>()
          .signout()
          .then((value) => SharedPref.saveLoggedInStatus(false))
          .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen(
                                
                                username:getUserName,
  
                              )
                
                             
                        ),
                (Route<dynamic> route) => false,
              )),
      onCancel: () => Navigator.pop(context),
    );
  },
),

                      child: Text(
                        "Sign out",
                        style: FontUtil.customStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            textColor: MyColors.boldTextColor),
                      ),
                    );
                  }),
                ),
              ),
              BlocConsumer<SignoutCubit, SignoutState>(
                  builder: (context, state) {
                return const SizedBox();
              }, listener: (context, state) {
                if (state is SignoutSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign out Successfully")));
                } else if (state is SignoutErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign out Successfully")));
                }
              })
            ]),
          ),
        ],
      ),
    );
  }

  Widget settingItemsListTile(
    BuildContext context,
    String title,
// onTap(),
    {
    bool? isNotificationTile,
    bool? isTapped,
    Function(bool)? onToggleChanged,
  }) {
//  bool toggle = isTapped??false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$title",
          style: FontUtil.customStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textColor: MyColors.fadedTextColor),
        ),
        title == "Push Notification"
            ? GestureDetector(
                onTap: () => onToggleChanged,
                child: CustomFlutterSwitch(
                  toggleSize: 8,
                  width: 30,
                  height: 20,
                  padding: 2,
                  activeColor: Colors.transparent,
                  inactiveToggleColor: Colors.grey,
                  // toggleColor: MyColors.blueShades_1,
                  //  toggleGradient: MyColors.buttonColors,
                  activeToggleGradient: MyColors.buttonColors,
                  inactiveToggleGrdient: MyColors.greyGradient,
                  inactiveColor: Colors.transparent,
                  isLoaderActive: false,
                  switchBorder: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  value: isTapped ?? false,
                  onToggle: (value) => setState(() {
                    log("$isTapped");
                    toggle = !value;
                  }),
                ),
              )
            : GestureDetector(
                onTap: () {
                  // title == "My Profile"
                  //     ? () => Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => MyProfileScreen()))
                  //     :

                  if (title == "Change Password") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyProfileScreen()));
                  } else if (title == "Change Sibling") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeSiblings()));
                  }
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ))
      ],
    );
  }
}

Widget customSettingProfileWidget(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    String name,
    String classAndSession,
    String admissionNumber,
    {String? bloodGroup,
    String? gender}) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: screenHeight * 0.1,
    child: Card(
      //  color: Color.fromARGB(255, 255, 242, 202),
      elevation: 0.1,
      color: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: Icon(Icons.person),
              // backgroundImage: NetworkImage("https://via.placeholder.com/150"),
              radius: 30,
              backgroundColor: MyColors.greyShade_4,
            ),
            10.widthBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name != null ? Text("$name") : const Text("Anshul Sharma"),
                8.heightBox,
                Row(
                  children: [
                    customTags(
                        "$classAndSession",
                        const Color.fromARGB(255, 204, 231, 255),
                        MyColors.blueShades_1),
                    5.widthBox,
                    customTags(
                        "$admissionNumber",
                        const Color.fromARGB(255, 251, 225, 218),
                        MyColors.orangeShades_1),
                    5.widthBox,
                    customTags(
                        "$bloodGroup",
                        MyColors.yellowShade_5.withOpacity(0.2),
                        MyColors.yellowShade_5),
                    5.widthBox,
                    customTags(
                        "$gender",
                        MyColors.greenShade_3.withOpacity(0.2),
                        MyColors.greenShade_3)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

AlertDialog buildLogoutAlertDialog({
  required BuildContext context,
  required VoidCallback onLogout,
  required VoidCallback onCancel,
}) {
  return AlertDialog(
    backgroundColor: MyColors.white,
    title: const Text('Sign out'),
    content: const Text('Are you sure you want to Sign out?'),
    actions: <Widget>[
      TextButton(
        onPressed: onCancel,
        child: Text(
          'Cancel',
          style: FontUtil.customStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: MyColors.boldTextColor),
        ),
      ),
      TextButton(
        onPressed: onLogout,
        child: Text(
          'Sign out',
          style: FontUtil.customStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: MyColors.boldTextColor),
        ),
      ),
    ],
  );
}
