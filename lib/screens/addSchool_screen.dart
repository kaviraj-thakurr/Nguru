// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';

import 'package:nguru/screens/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class AddSchool extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AddSchool({super.key});

  @override
  State<AddSchool> createState() => _AddSchoolState();
}

class _AddSchoolState extends State<AddSchool> {
  final FocusNode _schoolUrlFocusNode = FocusNode();
  TextEditingController schoolurlController = TextEditingController();
  TextEditingController subdomainController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  bool _isButtonEnabled = false;

  String? _validateNickName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter School Name';
    }
    if (value.length < 3) {
      return 'School Name must be at least 3 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _schoolUrlFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    schoolurlController.text = 'https://quickschool.niitnguru.com/';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                169.heightBox,
                SvgPicture.asset(MyAssets.signIN),
                50.heightBox,
                Text(
                  MyStrings.customData,
                  style: FontUtil.customData,
                  textAlign: TextAlign.center,
                ),
                20.heightBox,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: _schoolUrlFocusNode,
                        controller: schoolurlController,
                        decoration: InputDecoration(
                        
                          suffixIcon: IconButton(
                              onPressed: () {
                                _schoolUrlFocusNode.requestFocus();
                              },
                              icon: SvgPicture.asset(MyAssets.edit)),
                          label: const Text(
                            MyStrings.schoolurl,
                            style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                fontSize: 15,
                                color: Colors.grey,
                                fontFamily: "Effra_Trial"),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.borderColor,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                        ),
                        style: FontUtil.signInFieldText,
                        validator: (url) {
                          if (url == null || url.isEmpty) {
                            return MyStrings.enterschoolurl;
                          }
                          return null;
                        },
                      ),
                      14.heightBox,
                      TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        controller: subdomainController,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          label: const Text(
                            MyStrings.subdomain,
                            style: TextStyle(
                                fontSize: 15,
                                // fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontFamily: "Effra_Trial"),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.borderColor,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                        ),
                          style: FontUtil.signInFieldText,
                        validator: (subdomain) {
                          if (subdomain == null || subdomain.isEmpty) {
                            return MyStrings.subdomainrequired;
                          }
                          return null;
                        },
                      ),
                      14.heightBox,
                      TextFormField(
                          controller: nickNameController,
                          decoration: InputDecoration(
                            hintStyle:FontUtil.signInFieldText ,
                            label: const Text(
                              MyStrings.schoolname,
                              style: TextStyle(
                                  //fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontFamily: "Effra_Trial"),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.borderColor,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0)),
                            ),
                          ),
                          style: FontUtil.signInFieldText,
                          validator: _validateNickName),
                      14.heightBox,
                    ],
                  ),
                ),
                30.heightBox,
                TextButton(
                  onPressed: () {},
                  child: Text(
                    MyStrings.add,
                    style: FontUtil.add,
                  ),
                ),
                BlocConsumer<AddSchoolCubit, AddSchoolState>(
                    builder: (context, state) {
                  if (state is AddSchoolLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return PrimaryButton(
                      title: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddSchoolCubit>().addSchool(
                              schoolurlController.text.trim(),
                              subdomainController.text.trim());
                        } else {
                          String errorMessage = '';
                          if (schoolurlController.text.isEmpty) {
                            errorMessage = MyStrings.enterschoolurl;
                          } else if (subdomainController.text.isEmpty) {
                            errorMessage = MyStrings.enterschoolurl;
                          } else if (_validateNickName(
                                  nickNameController.text) !=
                              null) {
                            errorMessage = 'Nickname required';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(

                            SnackBar(
                              content: Text(errorMessage),
                            ),
                          );
                        }
                      },
                    );
                  }
                }, listener: (context, state) {
                  if (state is AddSchoolSuccessState) {
                    NavigationService.navigateTo(
                        LoginScreen(title: nickNameController.text), context);
                  } else if (state is AddSchoolErrorState) {
                    _showSnackBar(context , state.message);
                  }
                }),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
    void _showSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).clearSnackBars(); 

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3), 
      ),
    );
  }

}
