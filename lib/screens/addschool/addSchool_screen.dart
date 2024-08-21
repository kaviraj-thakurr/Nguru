import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/local_database/add_school_list_hive_box.dart';
import 'package:nguru/logic/form_validation/form_validation_cubit.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/screens/login/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';


class AddSchool extends StatefulWidget {
  final bool isAddSchoolScreen;
  const AddSchool({super.key, required this.isAddSchoolScreen});

  @override
  State<AddSchool> createState() => _AddSchoolState();
}

class _AddSchoolState extends State<AddSchool> {
  final FocusNode _schoolUrlFocusNode = FocusNode();
  
final _formKey = GlobalKey<FormState>();
  final TextEditingController schoolUrlController = TextEditingController();
  final TextEditingController subdomainController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  List<UserModel>? addSchoolList;
 bool isEditable = false;
  Box<UserModel>? box;
  String selectedRadio = '';

   void _toggleEditability() {
    setState(() {
      isEditable = !isEditable;
      if (isEditable) {
        _schoolUrlFocusNode.requestFocus();
      }
    });
  }

  Future<void> openAddSchoolBox() async {
    box = await Hive.openBox<UserModel>('listItems');

    addSchoolList = box?.values.toList();
    removeDuplicateSchools(addSchoolList);
    setState(() {
      
    });
    log("fetching: $addSchoolList");
  }

  void removeDuplicateSchools(List<UserModel>? addSchoolList) {
    if (addSchoolList == null) return;

    // Set to track unique subDomains
    final uniqueSubDomains = <String>{};

    // Retain only the first occurrence of each unique subDomain
    addSchoolList.retainWhere((user) => uniqueSubDomains.add(user.subDomain));
  }

  @override
  void dispose() {
    // _schoolUrlFocusNode.dispose();
    schoolUrlController.dispose();
    subdomainController.dispose();
    schoolNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    schoolUrlController.text = MyStrings.defaultSchoolUrl;
    openAddSchoolBox();
    schoolNameController.addListener(() {
      context
          .read<FormValidationCubit>()
          .validateSchoolName(schoolNameController.text);
    });
    subdomainController.addListener(() {
      context
          .read<FormValidationCubit>()
          .validateSubdomain(subdomainController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
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
                
                20.heightBox,
                Form(
                      key: _formKey,
                  child: Column(
                    children: [
                      Visibility(
                  visible: widget.isAddSchoolScreen,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: addSchoolList?.length ?? 0,
                        itemBuilder: (context, index) {
                          String schoolNickName =
                              addSchoolList?[index].schoolNickName ?? "";
                          return GestureDetector(
                            onTap: () {
                              context.read<AddSchoolCubit>().addSchool(
                                  addSchoolList?[index].schoolUrl ?? "",
                                  addSchoolList?[index].subDomain ?? "",
                                  addSchoolList?[index].schoolNickName ?? "",
                                  isNavigating: false);

                              setState(() {
                                selectedRadio =
                                    addSchoolList?[index].schoolNickName ?? "";
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: customRadioButton(
                                  context,
                                  selectedRadio == schoolNickName,
                                  addSchoolList?[index].schoolNickName ?? "",
                                  addSchoolList?[index]),
                            ),
                          );
                        }),
                  ),
                ),
                      CustomTextFormField(
                        read: !isEditable,

                         suffixIcon: IconButton(
                icon: SvgPicture.asset(MyAssets.edit),
                onPressed: _toggleEditability
              ),

                        controller: schoolUrlController,
                         focusNode: _schoolUrlFocusNode,
                        labelText: MyStrings.schoolUrl,
                        suffixIconAsset: MyAssets.edit,
                        validator: _validateSchoolUrl,
                        onChanged: (value) => schoolUrlController.text,
                      ),
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
                            onChanged: (value) => subdomainController.text,
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
                Visibility(
                  visible: !widget.isAddSchoolScreen,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddSchool(isAddSchoolScreen: true),
                          ));
                    },
                    child: Text(
                      MyStrings.add,
                      style: FontUtil.add,
                    ),
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
                          context.read<AddSchoolCubit>().saveToHive(
                              schoolUrlController.text.trim(),
                              subdomainController.text.trim(),
                              schoolNameController.text.trim());
                          context.read<AddSchoolCubit>().addSchool(
                              schoolUrlController.text.trim(),
                              subdomainController.text.trim(),
                              schoolNameController.text.trim());
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
                    final box = Hive.box<UserModel>('listItems');
                    final user = UserModel(
                      schoolUrl: "${schoolUrlController.text.trim()}",
                      subDomain: "${subdomainController.text.trim()}",
                      schoolNickName: "${schoolNameController.text.trim()}",
                    );

                    //           bool exists = addSchoolList!.any(
                    // (e) => e.schoolUrl == schoolName && e.subDomain == subDomain);

                    box.add(user).then((value) async {
                      print("Successs");
                      var box = await Hive.openBox<UserModel>('listItems');

                      var userModel = box.values.toList();

                      log("fetching: $userModel");
                    }).onError((error, stackTrace) {
                      print("Faileddddd!!!");
                    });

                    NavigationService.navigateTo(
                        LoginScreen(
                          title: schoolNameController.text,
                          schoolLogo: state.schoolPhoto,
                          schoolUrl: schoolUrlController.text +
                              subdomainController.text,
                        ),
                        context);
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

  Widget customRadioButton(BuildContext context, bool isSelected,
      String schoolNickName, UserModel? addSchoolList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return MyColors.buttonColors.createShader(bounds);
              },
              child: Container(
                height: height18,
                width: width18,
                padding: const EdgeInsets.symmetric(
                    vertical: paddingVertical6,
                    horizontal: paddingHorizontal10),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white, // This color is not visible
                    width: width1,
                  ),
                ),
              ),
            ),
            isSelected
                ? Positioned(
                    top: 3,
                    left: 3,
                    child: Container(
                      height: height12,
                      width: width12,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingVertical6,
                          horizontal: paddingHorizontal10),
                      decoration: BoxDecoration(
                        gradient: MyColors.buttonColors,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.white, // This color is not visible
                          width: width1,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        5.widthBox,
        Text(
          schoolNickName ?? "",
          style: FontUtil.schoolName,
        )
      ],
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
