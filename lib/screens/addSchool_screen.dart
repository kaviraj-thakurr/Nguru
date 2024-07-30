import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
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
  TextEditingController schoolNameController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _autoValidateSchoolName = false;
  bool _autoValidateSubdomain = false;

  @override
  void dispose() {
    _schoolUrlFocusNode.dispose();
    schoolurlController.dispose();
    subdomainController.dispose();
    schoolNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    schoolurlController.text = 'https://quickschool.niitnguru.com/';

    schoolNameController.addListener(() {
      if (!_autoValidateSchoolName) {
        setState(() {
          _autoValidateSchoolName = true;
        });
      }
    });
    subdomainController.addListener(() {
      if (!_autoValidateSubdomain) {
        setState(() {
          _autoValidateSubdomain = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                150.heightBox,
                SvgPicture.asset(MyAssets.signIN),
                20.heightBox,
                Text(
                  MyStrings.customData,
                  style: FontUtil.customData,
                  textAlign: TextAlign.center,
                ),
                20.heightBox,
                Form(
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          controller: schoolurlController,
                          focusNode: _schoolUrlFocusNode,
                          labelText: MyStrings.schoolurl,
                          suffixIconAsset: MyAssets.edit,
                          validator: _validateSchoolUrl),
                      14.heightBox,
                      CustomTextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                          controller: subdomainController,
                          labelText: MyStrings.subdomain,
                          autovalidateMode: _autoValidateSubdomain
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          validator: _validateSubDomain),
                      14.heightBox,
                      CustomTextFormField(
                        controller: schoolNameController,
                        labelText: MyStrings.schoolname,
                        validator: _validateSchoolName,
                        autovalidateMode: _autoValidateSchoolName
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                      ),
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
                          } else if (_validateSchoolName(
                                  schoolNameController.text) !=
                              null) {
                            errorMessage = 'School Name required';
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
                        LoginScreen(title: schoolNameController.text), context);
                  } else if (state is AddSchoolErrorState) {
                    _showSnackBar(context, state.message);
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

  String? _validateSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return MyStrings.enterschoolName;
    }
    if (value.length < 3) {
      return MyStrings.schoolNameLeastName;
    }
    return null;
  }

  String? _validateSchoolUrl(String? url) {
    if (url == null || url.isEmpty) {
      return MyStrings.enterschoolurl;
    }
    return null;
  }

  String? _validateSubDomain(String? subdomain) {
    if (subdomain == null || subdomain.isEmpty) {
      return MyStrings.subdomainrequired;
    }
    return null;
  }
}
