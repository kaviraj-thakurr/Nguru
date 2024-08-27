import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/local_database/add_school_list_hive_box.dart';
import 'package:nguru/logic/form_validation/form_validation_cubit.dart';
import 'package:nguru/screens/addschool/addSchool_screen.dart';
import 'package:nguru/screens/dashboard_screen.dart';
import 'package:nguru/screens/forgot_password.dart';
import 'package:nguru/screens/reset_password_screen.dart';

import 'package:nguru/utils/app_font.dart';
import 'package:nguru/custom_widgets/gradient_divider.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_gapping.dart';

import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/utils/app_utils.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  final String? title;
  final String? schoolLogo;
  final String? schoolUrl;
  final String subDomain;
  final String schoolNickName;
   final String trimmedSchoolUrl;
  final String? username;
  final bool retainUsername;



  const LoginScreen({super.key, this.title, this.schoolLogo, this.schoolUrl, required this.subDomain, required this.schoolNickName, required this.trimmedSchoolUrl,this.username, this.retainUsername = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool isSelected = false;
  String selectedRadio = '';
  String schoolUrlGlobal = '';
  bool isFirstTime = true;
  Box<UserModel>? box;
  List<UserModel>? addSchoolList;

  Future<void> openAddSchoolBox() async {
    box = await Hive.openBox<UserModel>('listItems');
     addSchoolList = box?.values.toList();
      int index = findUserModelIndex(addSchoolList??[],widget.schoolNickName,widget.subDomain, widget.trimmedSchoolUrl??"" );
  
    selectedRadio = addSchoolList?.elementAt(index).schoolNickName ?? "";
    schoolUrlGlobal =
        "${addSchoolList?.elementAt(index).schoolUrl}${addSchoolList?.elementAt(index).subDomain}" ??
            "";
    removeDuplicateSchools(addSchoolList);
    setState(() {});
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
  void initState() {
    openAddSchoolBox();
    super.initState();
    if (widget.retainUsername && widget.username != null) {
      userNameController.text = widget.username!;
    }
    userNameController.addListener(() {
      context
          .read<FormValidationCubit>()
          .validateUserName(userNameController.text);
    });
  }

  int findUserModelIndex(List<UserModel> userModelList, String schoolNickName,
      String subDomain, String schoolUrl) {
    try {
      return userModelList.indexWhere(
        (user) =>
            user.schoolNickName == schoolNickName &&
            user.subDomain == subDomain &&
            user.schoolUrl == schoolUrl,
      );
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSchoolCubit, AddSchoolState>(
      buildWhen: (previous, current) =>
          current is AddSchoolSuccessState ||
          current is AddSchoolSuccessUpdated ||
          current is AddSchoolLoadingState,
      builder: (context, state) {
        if (state is AddSchoolSuccessState) {
          return _buildBody(state.schoolName ?? "", state.schoolPhoto ?? "");
        } else if (state is AddSchoolSuccessUpdated) {
          return _buildBody(state.schoolName ?? "", state.schoolPhoto ?? "");
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildBody(String schoolName, String schoolPhoto) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding23),
            child: Column(
              children: [
                169.heightBox,
                Image.memory(
                  base64Decode(schoolPhoto),
                  height: height150,
                ),
                15.heightBox,
                Text(
                  schoolName,
                  style: const TextStyle(color: Colors.black),
                ),
                8.heightBox,
                const GradientDivider(
                  gradient: MyColors.divider,
                  height: height1,
                ),
                20.heightBox,

                // Row(
                //   children: [
                //     Radio(
                //       activeColor: Color.fromARGB(255, 67, 225, 181),
                //      // hoverColor: Colors.blue,
                //       value: 1,
                //       groupValue: 1,
                //       onChanged: (value) {},
                //     ),
                //     Text(widget.title ?? ""),
                //   ],
                // ),

                addSchoolList?.length == null
                    ? SizedBox()
                    : SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: addSchoolList?.length,
                            itemBuilder: (context, index) {
                              String schoolNickName =
                                  addSchoolList?[index].schoolNickName ?? "";
                              String schoolUrl =
                                  "${addSchoolList?[index].schoolUrl ?? ""}${addSchoolList?[index].subDomain}";
                              return GestureDetector(
                                onTap: () {
                                  context.read<AddSchoolCubit>().addSchool(
                                      addSchoolList?[index].schoolUrl ?? "",
                                      addSchoolList?[index].subDomain ?? "",
                                      addSchoolList?[index].schoolNickName ??
                                          "",
                                      isNavigating: false);

                                  setState(() {
                                    selectedRadio =
                                        addSchoolList?[index].schoolNickName ??
                                            "";
                                    schoolNickName =
                                        addSchoolList?[index].schoolNickName ??
                                            "";
                                    schoolUrl =
                                        "${addSchoolList?[index].schoolUrl ?? ""}${addSchoolList?[index].subDomain}";
                                    schoolUrlGlobal =
                                        "${addSchoolList?[index].schoolUrl ?? ""}${addSchoolList?[index].subDomain}";
                                    isSelected = !isSelected;
                                    isFirstTime = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: customRadioButton(
                                      context,
                                      selectedRadio == schoolNickName &&
                                          schoolUrl == schoolUrlGlobal,
                                      addSchoolList![index].schoolNickName ??
                                          "",
                                      addSchoolList?[index]),
                                ),
                              );
                            }),
                      ),

                10.heightBox,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BlocBuilder<FormValidationCubit, FormValidationState>(
                          builder: (context, state) {
                        return CustomTextFormField(
                          controller: userNameController,
                          labelText: MyStrings.userName,
                          validator: (url) {
                            if (url == null || url.isEmpty) {
                              return MyStrings.userNameReq;
                            }
                            return null;
                          },
                          autoValidateMode: state.autoValidateUserName
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                        );
                      }),
                      14.heightBox,
                      TextFormField(
                        obscureText: _obscureText,
                        controller: passWordController,
                        decoration: InputDecoration(
                          label: const Text(
                            MyStrings.passWord,
                            style: TextStyle(
                                fontSize: 15,
                                color: MyColors.grey,
                                fontFamily: APP_FONT),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: MyColors.passIcon,
                              _obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: paddingVertical15,
                              horizontal: paddingHorizontal20),
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
                                BorderSide(color: Colors.grey, width: width1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                        ),
                        style: FontUtil.signInFieldText,
                        validator: (pass) {
                          if (pass == null || pass.isEmpty) {
                            return MyStrings.passWordReq;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(

                
                      
                        onPressed: () {
        if (userNameController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(MyStrings.userNameReq), // Show an error message
            ),
          );
        } else {
          NavigationService.navigateTo(
            ForgotPassword(username: userNameController.text.trim()),
            context,
          );
        }
      },
                      
                      child: Text(
                        MyStrings.forgotPassword,
                        style: FontUtil.forgotPassword,
                      ),
                    ),
                  ],
                ),

                 TextButton(
                   onPressed: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) =>
                               const AddSchool(isAddSchoolScreen: true),
                         ));
                   },
                   child: Text(
                     MyStrings.add,
                     style: FontUtil.add,
                   ),
                 ),
                BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return PrimaryButton(
                      title: MyStrings.signIn,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().logIn(
                                userNameController.text.trim(),
                                passWordController.text.toString(),
                                widget.schoolUrl ?? "",
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(MyStrings.enterUserNamePass),
                            ),
                          );
                        }
                      },
                    );
                  }
                }, listener: (context, state) {
                  if (state is LoginSuccessState) {
                    NavigationService.navigateTo(
                        const NguruDashboardScreen(), context);
                  } else if (state is LoginForgetPasswordState) {
                    isFromForgotPassword = false;
                    NavigationService.navigateTo(
                        const ResetPasswordScreen(), context);
                  } else if (state is LoginErrorState) {
                    _showSnackBar(context, state.message);
                  }
                }),
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

  Widget customRadioButton(BuildContext context, bool isSelected,
      String schoolNickName, UserModel? addSchoolList) {
    //  isSelected ?      context.read<AddSchoolCubit>().addSchool(addSchoolList!.schoolUrl,addSchoolList.subDomain,addSchoolList.schoolNickName) : null;

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
}
