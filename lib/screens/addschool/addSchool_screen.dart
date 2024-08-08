import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/logic/form_validation/form_validation_cubit.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/screens/login/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class AddSchool extends StatefulWidget {
  const AddSchool({super.key});

  @override
  State<AddSchool> createState() => _AddSchoolState();
}

class _AddSchoolState extends State<AddSchool> {
  final FocusNode _schoolUrlFocusNode = FocusNode();
  final TextEditingController schoolUrlController = TextEditingController();
  final TextEditingController subdomainController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();

  @override
  void dispose() {
    _schoolUrlFocusNode.dispose();
    schoolUrlController.dispose();
    subdomainController.dispose();
    schoolNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    schoolUrlController.text = MyStrings.defaultSchoolUrl;
   


    schoolNameController.addListener(() {
      context.read<FormValidationCubit>().validateSchoolName(schoolNameController.text);
    });
    subdomainController.addListener(() {
      context.read<FormValidationCubit>().validateSubdomain(subdomainController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: padding18),
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
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          controller: schoolUrlController,
                          focusNode: _schoolUrlFocusNode,
                          labelText: MyStrings.schoolUrl,
                          suffixIconAsset: MyAssets.edit,
                          validator: _validateSchoolUrl,
                           onChanged: (value)=> schoolUrlController.text,),
                      14.heightBox,
                      BlocBuilder<FormValidationCubit, FormValidationState>(
                        builder: (context, state) {
                          return CustomTextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            controller: subdomainController,
                            labelText: MyStrings.subdomain,
                            autoValidateMode: state.autoValidateSubdomain
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: _validateSubDomain,
                            onChanged: (value)=> subdomainController.text,
                            
                          );
                        },
                      ),
                      14.heightBox,
                    BlocBuilder<FormValidationCubit, FormValidationState>(
                        builder: (context, state) {
                          return CustomTextFormField(
                             inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            controller: schoolNameController,
                            labelText: MyStrings.schoolName,
                            validator: _validateSchoolName,
                            autoValidateMode: state.autoValidateSchoolName
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                          );
                        },
                    )
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
                        setState(() {
                          
                        schoolUrl= schoolUrlController.text+subdomainController.text;
                        });
                        if (_formKey.currentState!.validate()) {
                          context.read<AddSchoolCubit>().addSchool(
                              schoolUrlController.text.trim(),
                              subdomainController.text.trim());
                        } else {
                          String errorMessage = '';
                          if (schoolUrlController.text.isEmpty) {
                            errorMessage = MyStrings.enterSchoolUrl;
                          } else if (subdomainController.text.isEmpty) {
                            errorMessage = MyStrings.enterSchoolUrl;
                          } else if (_validateSchoolName(
                                  schoolNameController.text) !=
                              null) {
                            errorMessage = MyStrings.schoolNameRequired;
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
                        LoginScreen(title: schoolNameController.text,schoolLogo: state.schoolPhoto,  schoolUrl: schoolUrlController.text+subdomainController.text,), context);
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
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String? _validateSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return MyStrings.enterSchoolName;
    }
    if (value.length < 3) {
      return MyStrings.schoolNameLeastName;
    }
    return null;
  }

  String? _validateSchoolUrl(String? url) {
    if (url == null || url.isEmpty) {
      return MyStrings.enterSchoolUrl;
    }
    return null;
  }

  String? _validateSubDomain(String? subdomain) {
    if (subdomain == null || subdomain.isEmpty) {
      return MyStrings.subdomainRequired;
    }
    return null;
  }
}
