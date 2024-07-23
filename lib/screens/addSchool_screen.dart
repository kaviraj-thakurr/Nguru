import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  TextEditingController schoolurlController = TextEditingController();
  TextEditingController subdomainController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  String? _validateNickName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nickname';
    }
    if (value.length < 3) {
      return 'Nickname must be at least 3 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    schoolurlController.dispose();
    nickNameController.dispose();
    super.dispose();
  }

  bool _showClearIcon = false;
  bool _showClearIconSubdomain = false;
  bool _showClearIconNickName = false;
  @override
  void initState() {
    super.initState();
    schoolurlController.addListener(() {
      setState(() {
        _showClearIcon = schoolurlController.text.isNotEmpty;
      });
    });

    subdomainController.addListener(() {
      setState(() {
        _showClearIconSubdomain = subdomainController.text.isNotEmpty;
      });
    });

    nickNameController.addListener(() {
      setState(() {
        _showClearIconNickName = nickNameController.text.isNotEmpty;
      });
    });
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
                        controller: schoolurlController,
                        decoration: InputDecoration(
                          hintText: MyStrings.schoolurl,
                          hintStyle: FontUtil.hintText,
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
                          suffixIcon: _showClearIcon
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    schoolurlController.clear();
                                  },
                                )
                              : null,
                        ),
                        validator: (url) {
                          if (url == null || url.isEmpty) {
                            return MyStrings.enterschoolurl;
                          }
                          return null;
                        },
                      ),
                      14.heightBox,
                      TextFormField(
                        controller: subdomainController,
                        decoration: InputDecoration(
                          hintText: MyStrings.subdomain,
                          hintStyle: FontUtil.hintText,
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
                          suffixIcon: _showClearIconSubdomain
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    subdomainController.clear();
                                  },
                                )
                              : null,
                        ),
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
                            hintText: MyStrings.nickName,
                            hintStyle: FontUtil.hintText,
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
                            suffixIcon: _showClearIconNickName
                                ? IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      nickNameController.clear();
                                    },
                                  )
                                : null,
                          ),
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
                    style: FontUtil.customStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        textColor: MyColors.addButtonColor),
                  ),
                ),
                BlocListener<AddSchoolCubit, AddSchoolState>(
                  listener: (context, state) {
                    if (state is AddSchoolSuccessState) {
                      NavigationService.navigateTo(
                          LoginScreen(title: state.schoolName), context);
                    } else if (state is AddSchoolErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                  child: PrimaryButton(
                    title: MyStrings.submit,
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
                        } else if (_validateNickName(nickNameController.text) !=
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
                  ),
                ),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
