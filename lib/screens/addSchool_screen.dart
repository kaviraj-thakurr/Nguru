import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/utils/font_util.dart';
import 'package:nguru/utils/my_assets.dart';
import 'package:nguru/utils/my_colors.dart';
import 'package:nguru/utils/my_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';

import 'package:nguru/screens/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class AddSchool extends StatefulWidget {
  AddSchool({super.key});

  @override
  State<AddSchool> createState() => _AddSchoolState();
}

class _AddSchoolState extends State<AddSchool> {
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  TextEditingController schoolurlController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                169.heightBox,
                Image.asset(
                  MyAssets.niitLogo,
                  height: 70,
                ),
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
                      VxTextField(
                        controller: schoolurlController,
                        focusNode: _firstFocusNode,
                        enableSuggestions: true,
                        fillColor: Colors.transparent,
                        borderColor: MyColors.borderColor,
                        borderType: VxTextFieldBorderType.roundLine,
                        hint: MyStrings.schoolurl,
                        style: FontUtil.hintText,
                        borderRadius: 9,
                        onSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_secondFocusNode);
                        },
                        validator: (url) {
                          if (url == null || url.isEmpty) {
                            return MyStrings.enterschoolurl;
                          }
                          return null;
                        },
                      ),
                      14.heightBox,
                      VxTextField(
                        focusNode: _secondFocusNode,
                        controller: nickNameController,
                        fillColor: Colors.transparent,
                        borderColor: MyColors.borderColor,
                        borderType: VxTextFieldBorderType.roundLine,
                        hint: MyStrings.nickName,
                        style: FontUtil.hintText,
                        borderRadius: 9,
                        validator: _validateNickName,
                      ),
                    ],
                  ),
                ),
                30.heightBox,
                TextButton(
                  onPressed: () {},
                  child: Text(
                    MyStrings.add,
                    style: FontUtil.needHelp,
                  ),
                ),
                BlocListener<AddSchoolCubit, AddSchoolState>(
                  listener: (context, state) {
                    if (state is AddSchoolSuccessState) {
                      NavigationService.navigateTo(LoginScreen(title: nickNameController.text.trim()), context);
                    } else if (state is AddSchoolErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                  child: PrimaryButton(
                    title: MyStrings.submit,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddSchoolCubit>().addSchool(schoolurlController.text.trim());
                      } else {
                       String errorMessage = '';
                        if (schoolurlController.text.isEmpty) {
                          errorMessage = MyStrings.enterschoolurl;
                        } else if (_validateNickName(nickNameController.text) != null) {
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
                TextButton(
                  onPressed: () {},
                  child: Text(
                    MyStrings.needHelp,
                    style: FontUtil.needHelp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
