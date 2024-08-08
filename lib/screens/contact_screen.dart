import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_cubit.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchConroller = TextEditingController();
  late AnimationController _phoneIconController;
  late Animation<double> _phoneIconAnimation;
  late AnimationController _messageIconController;
  late Animation<double> _messageIconAnimation;
  bool _firstVisit = true; // Flag to check if it's the first visit

  @override
  void initState() {
    super.initState();

    // Getting ContactUs details
    context.read<ContactUsCubit>().getContactUs();

    // Phone Icon Animation initialization
    _phoneIconController = AnimationController(
      duration:
          const Duration(milliseconds: 400), // Custom duration for phone icon
      vsync: this,
    );

    _phoneIconAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(
        parent: _phoneIconController,
        curve: Curves.easeOut,
      ),
    );

    // Email Icon Animation Initialization
    _messageIconController = AnimationController(
      duration:
          const Duration(milliseconds: 600), // Custom duration for message icon
      vsync: this,
    );

    _messageIconAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(
        parent: _messageIconController,
        curve: Curves.easeOut,
      ),
    );

    // Trigger the animations on first visit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_firstVisit) {
        _firstVisit = false;
        _animateIcons();
      }
    });
  }

  void _animateIcons() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _phoneIconController.forward().then((_) {
        _phoneIconController.reverse();
        // Delay the start of the second animation
        Future.delayed(const Duration(milliseconds: 300), () {
          _messageIconController.forward().then((_) {
            _messageIconController.reverse();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(MyAssets.floatingActionIcon)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (BuildContext context, ContactUsState state) {},
        builder: (context, state) {
          if (state is ContactUsInitialState ||
              state is ContactUsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactUsSuccessState) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: MyColors.white,
                  child: SvgPicture.asset(
                    MyAssets.background,
                    fit: BoxFit.fill,
                  ),
                ),
                contactUsWidget(
                    screenHeight,
                    screenWidth,
                    state.contactUs.schoolPhoto ?? "",
                    state.contactUs.address ?? "",
                    state.contactUs.email ?? "",
                    state.contactUs.mobileNumber ?? "",
                    state.contactUs.landlineNumber ?? ""),
              ],
            );
          } else if (state is ContactUsErrorState) {
            return const Text(MyStrings.error);
          } else {
            return const Center(child: Text(MyStrings.undefinedState));
          }
        },
      ),
    );
  }

  Widget contactUsWidget(
      double screenHeight,
      double screenWidth,
      String schoolPhotoBytes,
      String address,
      String email,
      String mobileNumber,
      String landlineNumber) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.8,
              maxWidth: double.infinity,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAppBar(),
                CustomSearchBar(controller: _searchConroller),
                15.heightBox,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: MyColors.borderColor,
                      width: 1.0,
                    ),
                  ),
                  height: screenHeight * 0.43,
                  width: screenWidth * 0.85,
                  child: schoolPhotoBytes == ""
                      ? Text(
                          MyStrings.noSchoolPhotoAvailable,
                          textAlign: TextAlign.center,
                          style: FontUtil.customStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              textColor: MyColors.fadedTextColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.memory(
                            base64Decode(schoolPhotoBytes),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                10.heightBox,
                Text(
                  "${MyStrings.adddress}: $address",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black),
                ),
                Text(
                  "${MyStrings.email}: $email",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.fadedTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                  "${MyStrings.mobileNumber}: $mobileNumber",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.fadedTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                  "${MyStrings.landlineNumber}: $landlineNumber",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.fadedTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        double delta = details.primaryDelta!;
                        double newValue = (_phoneIconAnimation.value - delta)
                            .clamp(-100.0, 0.0);
                        _phoneIconController.value = -newValue / 100.0;
                      },
                      onVerticalDragEnd: (details) {
                        if (_phoneIconController.value > 0.5 ||
                            details.primaryVelocity! < 0) {
                          _phoneIconController
                              .forward()
                              .then(
                                (_) => CustomUrlLauncher.makePhoneCall(
                                    'tel:$landlineNumber'),
                              )
                              .then(
                                  (value) => _phoneIconController.value = 0.0);
                        } else {
                          _phoneIconController.reverse();
                        }
                      },
                      child: AnimatedBuilder(
                          animation: _phoneIconController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _phoneIconAnimation.value),
                              child: child,
                            );
                          },
                          child: Stack(
                            children: [
                              const CircleAvatar(
                                  backgroundColor: Colors.white, radius: 30),
                              SvgPicture.asset(MyAssets.callIcon),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        double delta = details.primaryDelta!;
                        double newValue = (_messageIconAnimation.value - delta)
                            .clamp(-100.0, 0.0);
                        _messageIconController.value = -newValue / 100.0;
                      },
                      onVerticalDragEnd: (details) {
                        if (_messageIconController.value > 0.5 ||
                            details.primaryVelocity! < 0) {
                          _messageIconController
                              .forward()
                              .then(
                                (_) => CustomUrlLauncher.sendEmail(
                                    email: email, subject: "", body: ""),
                              )
                              .then((value) =>
                                  _messageIconController.value = 0.0);
                        } else {
                          _messageIconController.reverse();
                        }
                      },
                      child: AnimatedBuilder(
                          animation: _messageIconController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _messageIconAnimation.value),
                              child: child,
                            );
                          },
                          child: Stack(
                            children: [
                              const CircleAvatar(
                                  backgroundColor: MyColors.white, radius: 30),
                              SvgPicture.asset(MyAssets.messageIcon),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}


//////////////  FOR MAKING THE PLATEFORM SPACIFIC IF REQUIRED

// if (Platform.isAndroid) {
//    final AndroidIntent intent = AndroidIntent(
//            action: 'android.intent.action.MAIN',
//            category: 'android.intent.category.APP_EMAIL',
//   );
  
//   intent.launch().catchError((e) {});
// } else if (Platform.isIOS) {
//   launch('message://').catchError((e) {});
// }