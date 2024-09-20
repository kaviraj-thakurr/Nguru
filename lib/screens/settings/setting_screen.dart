import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_tags.dart';
import 'package:nguru/logic/push_notification/push_notification_cubit.dart';
import 'package:nguru/logic/setting_screen/setting_screen_cubit.dart';
import 'package:nguru/logic/setting_screen/setting_screen_state.dart';
import 'package:nguru/logic/signout/signout_cubit.dart';
import 'package:nguru/logic/signout/signout_state.dart';
import 'package:nguru/logic/student_profile/student_profile_cubit.dart';
import 'package:nguru/logic/student_profile/student_profile_state.dart';
import 'package:nguru/screens/login/login_screen.dart';
import 'package:nguru/screens/my_profile_screen.dart';
import 'package:nguru/screens/reset_password_screen.dart';
import 'package:nguru/screens/settings/add_feedback_screen.dart';
import 'package:nguru/screens/settings/change_session_screen.dart';
import 'package:nguru/screens/settings/privacy_policy_screen.dart';
import 'package:nguru/screens/settings/terms_of_use_screen.dart';
import 'package:nguru/screens/settings/change_siblings.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/constants.dart';
import 'package:nguru/utils/custom_flutter_switch.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var getUserName;

  @override
  void initState() {
    context.read<SettingScreenCubit>().initiatingValues();
    super.initState();
    getUerName();
  }

  Future<String> getUerName() async {
    getUserName = await SharedPref.getUerName();
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
          child: SvgPicture.asset(MyAssets.homeFloatingButtonIcon)),
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
              BlocBuilder<StudentProfileCubit, StudentProfileState>(
                  builder: (context, state) {
                if (state is StudentProfileLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StudentProfileSuccessState) {
                  return Column(
                    children: [
                      customSettingProfileWidget(
                        context,
                        screenWidth,
                        screenHeight,
                        state.studentProfileState.personalInfo?.studentName ??
                            "",
                        "${state.studentProfileState.personalInfo?.className ?? ""} ${state.studentProfileState.personalInfo?.section ?? ""}",
                        state.studentProfileState.personalInfo
                                ?.admissionNumber ??
                            "",
                        bloodGroup: state
                                .studentProfileState.personalInfo?.bloodGroup ??
                            "",
                        gender:
                            state.studentProfileState.personalInfo?.gender ??
                                "",
                       studentPicture:   state.studentProfileState.personalInfo?.studentPicture ?? "", 
                      ),
                    ],
                  );
                } else if (state is StudentProfileErrorState) {
                  return customSettingProfileWidget(context, screenWidth,
                      screenHeight, "Name: N/A", "N/A", "N/A",
                      bloodGroup: "N/A", gender: "N/A");
                } else {
                  return customSettingProfileWidget(
                      context, screenWidth, screenHeight, "", "", "",);
                }
              }),
              SizedBox(
                height: screenHeight * 0.58,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: SettingItem.values.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: settingItemsListTile(
                            context, SettingItem.values[index], isTapped: isTap,
                            onToggleChanged: (bool value) {
                          setState(() {
                            isTap = !isTap;
                            log("istap $isTap");
                          });
                          return isTap;
                        }, isNotificationTile: false),
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
                                .then((value) =>
                                    SharedPref.saveLoggedInStatus(false))
                                .then(
                              (value) async {
                                String schoolNickName =
                                    await SharedPref.getSchoolNickName() ?? "";
                                String schoolSubDomain =
                                    await SharedPref.getSubDomain() ?? "";
                                String schoolUrl =
                                    await SharedPref.getSchoolUrl() ?? "";
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                            username: getUserName,
                                            schoolNickName: schoolNickName,
                                            subDomain: schoolSubDomain,
                                            trimmedSchoolUrl: schoolUrl,
                                          )),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                            onCancel: () => Navigator.pop(context),
                          );
                        },
                      ),
                      child: Text(
                        MyStrings.signOut,
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(MyStrings.signOutSuccessfully)));
                } else if (state is SignoutErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(MyStrings.signOutSuccessfully)));
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
    SettingItem settingItem, {
    bool? isNotificationTile,
    bool? isTapped,
    Function(bool)? onToggleChanged,
  }) {
    return GestureDetector(
      onTap: () => navigateBasedOnTitle(context, settingItem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            settingItem.label,
            style: FontUtil.customStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textColor: MyColors.fadedTextColor),
          ),
          settingItem.label == "Push Notification"
              ? BlocConsumer<SettingScreenCubit, SettingScreenState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is SettingScreenInitialState) {
                      return notificationSwitch(false, context);
                    } else if (state is SettingScreenLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SettingScreenSuccessState) {
                      context.read<PushNotificationCubit>().pushNotification(state.toggleState);
                      return notificationSwitch(state.toggleState, context);
                    } else {
                      return notificationSwitch(false, context);
                    }
                  })
              : const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                )
        ],
      ),
    );
  }
}

Widget notificationSwitch(bool toggleValue, BuildContext context) {
  return CustomFlutterSwitch(
    toggleSize: 8,
    width: 30,
    height: 20,
    padding: 2,
    activeColor: Colors.transparent,
    inactiveToggleColor: Colors.grey,
    activeToggleGradient: MyColors.buttonColors,
    inactiveToggleGrdient: MyColors.greyGradient,
    inactiveColor: Colors.transparent,
    isLoaderActive: false,
    switchBorder: Border.all(
      color: Colors.grey,
      width: 2,
    ),
    value: toggleValue,
    onToggle: (value) =>
        context.read<SettingScreenCubit>().togglePushNotification(),
  );
}

Widget customSettingProfileWidget(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    String name,
    String classAndSession,
    String admissionNumber,
    {String? bloodGroup,
    String? gender,
      String? studentPicture,}) {
  return Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: screenHeight * 0.1,
    child: Card(
      elevation: 0.1,
      color: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          studentPicture==null || studentPicture ==""?
          
            CircleAvatar(
                  radius: 30,
                
                  backgroundColor: MyColors.greyShade_4,
                  child:  Icon(Icons.person,
                          color: Colors.white) 
                      
                )
                :

            CircleAvatar(
                  radius: 30,
                  backgroundImage: studentPicture.isNotEmpty
                      ? Image.memory(
                          base64Decode(studentPicture),
                          fit: BoxFit.fill,
                        ).image
                      : null, // Display the network image if URL is provided
                  backgroundColor: MyColors.greyShade_4,
                  child: studentPicture.isEmpty
                      ? const Icon(Icons.person,
                          color: Colors.white) // Fallback icon if no image
                      : null,
                ),
            10.widthBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: FontUtil.customStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: MyColors.boldTextColor),
                ),
                8.heightBox,
                Row(
                  children: [
                    customTags(
                        classAndSession,
                        const Color.fromARGB(255, 204, 231, 255),
                        MyColors.blueShades_1),
                    5.widthBox,
                    customTags(
                        admissionNumber,
                        const Color.fromARGB(255, 251, 225, 218),
                        MyColors.orangeShades_1),
                    5.widthBox,
                    customTags(
                        "$bloodGroup",
                        MyColors.yellowShade_5.withOpacity(0.2),
                        MyColors.yellowShade_5),
                    5.widthBox,
                    customTags(
                       gender == "M" ? "Male" : gender =="F" ? "Female" :"",
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

// Navigation on particular screen by clicking on it
void navigateBasedOnTitle(BuildContext context, SettingItem item) {
  switch (item) {
    case SettingItem.myProfile:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const MyProfileScreen(),
      //   ),
      // );
      break;

    case SettingItem.changeSibling:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChangeSiblings(),
        ),
      );
      break;

    case SettingItem.changePassword:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        ),
      );
      break;

    case SettingItem.changeSession:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChangeSessionScreen(),
        ),
      );
      break;

    case SettingItem.privacyPolicy:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PrivacyPolicyScreen(),
        ),
      );
      break;

    case SettingItem.termsOfUse:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TermsOfUseScreen(),
        ),
      );
      break;

    case SettingItem.feedback:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddFeedBackScreen(),
        ),
      );
      break;

    default:
      break;
  }
}

// Alirt dialog for sign out
AlertDialog buildLogoutAlertDialog({
  required BuildContext context,
  required VoidCallback onLogout,
  required VoidCallback onCancel,
}) {
  return AlertDialog(
    backgroundColor: MyColors.white,
    title: const Text(MyStrings.signOut),
    content: const Text(MyStrings.areYouSureYouWantToSignOut),
    actions: <Widget>[
      TextButton(
        onPressed: onCancel,
        child: Text(
          MyStrings.cancel,
          style: FontUtil.customStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: MyColors.boldTextColor),
        ),
      ),
      TextButton(
        onPressed: onLogout,
        child: Text(
          MyStrings.signOut,
          style: FontUtil.customStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: MyColors.boldTextColor),
        ),
      ),
    ],
  );
}
