import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_searchbar.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_cubit.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_state.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:url_launcher/url_launcher.dart';
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

  @override
  void initState() {

//Getting ContactUs details
    context.read<ContactUsCubit>().getContactUs();


// Phone Icon Animation initialization
    _phoneIconController = AnimationController(
      duration: const Duration(milliseconds: 300),
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
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _messageIconAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(
        parent: _messageIconController,
        curve: Curves.easeOut,
      ),
    );

    super.initState();
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> sendEmail(
      {String? email, String subject = "", String body = ""}) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
    if (await canLaunch(mail)) {
      await launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      
      floatingActionButton:
          GestureDetector(
            onTap:()=> Navigator.pop(context),
            child: SvgPicture.asset("assets/icons/floating_action_button.svg")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (BuildContext context, ContactUsState state) {},
        builder: (context, state) {
          if (state is ContactUsInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactUsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactUsSuccessState) {
            return contactUsWidget(
                screenHeight,
                screenWidth,
                state.contactUs.schoolPhoto ?? "",
                state.contactUs.address ?? "",
                state.contactUs.email ?? "",
                state.contactUs.mobileNumber ?? "",
                state.contactUs.landlineNumber ?? "");
          } else if (state is ContactUsErrorState) {
            return const Text("Error state");
          } else {
            return const Center(child: Text("undifined state"));
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
      return SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.8,
            maxWidth: double.infinity,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              20.heightBox,
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
                    ? Image.network(
                        "https://via.placeholder.com/600",
                        fit: BoxFit.cover,
                      )
                    : Image.memory(base64Decode(schoolPhotoBytes ?? "")),
              ),
              10.heightBox,
              Flexible(
                child: Text(
                  "Address: ${address}" ?? "N/A",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black),
                ),
              ),
              Flexible(
                child: Text(
                  "Email: ${email}" ?? "N/A",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.fadedTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Flexible(
                child: Text(
                  "Mobile Number: ${mobileNumber}" ?? "N/A",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.fadedTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Flexible(
                child: Text(
                  "Landline Number: ${landlineNumber}" ?? "N/A",
                  textAlign: TextAlign.center,
                  style: FontUtil.customStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textColor: MyColors.fadedTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
             Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      double delta = details.primaryDelta!;
                      double newValue =
                          (_phoneIconAnimation.value - delta).clamp(-100.0, 0.0);
                      _phoneIconController.value = -newValue / 100.0;
                    },
                    onVerticalDragEnd: (details) {
                      if (_phoneIconController.value > 0.5 ||
                          details.primaryVelocity! < 0) {
                        _phoneIconController
                            .forward()
                            .then(
                              (_) => _makePhoneCall('tel:$landlineNumber'),
                            )
                            .then((value) => _phoneIconController.value = 0.0);
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
                        child: SvgPicture.asset("assets/icons/call_icon.svg")),
                  ),
                  const SizedBox(
                    width: 15,
                  ),


                   GestureDetector(
                    onVerticalDragUpdate: (details) {
                      double delta = details.primaryDelta!;
                      double newValue =
                          (_messageIconAnimation.value - delta).clamp(-100.0, 0.0);
                      _messageIconController.value = -newValue / 100.0;
                    },
                    onVerticalDragEnd: (details) {
                      if (_messageIconController.value > 0.5 ||
                          details.primaryVelocity! < 0) {
                        _messageIconController
                            .forward()
                            .then(
                              (_) =>  sendEmail(email: "$email", subject: "", body: ""),
                            )
                            .then((value) => _messageIconController.value = 0.0);
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
                        child: SvgPicture.asset("assets/icons/message_icon.svg")),
                  ),
                ],
              ),
              // 100.heightBox,
            ],
          ),
        ),
      );
    });
  }
}


// if (Platform.isAndroid) {
//    final AndroidIntent intent = AndroidIntent(
//            action: 'android.intent.action.MAIN',
//            category: 'android.intent.category.APP_EMAIL',
//   );
  
//   intent.launch().catchError((e) {});
// } else if (Platform.isIOS) {
//   launch('message://').catchError((e) {});
// }