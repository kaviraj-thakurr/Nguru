import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/screens/dashboard_screen.dart';

import 'package:nguru/utils/font_util.dart';
import 'package:nguru/custom_widgets/gradient_divider.dart';
import 'package:nguru/utils/my_assets.dart';
import 'package:nguru/utils/my_colors.dart';

import 'package:nguru/utils/my_strings.dart';
import 'package:nguru/custom_widgets/navigation_services.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/logic/add_school_cubit/addschool_cubit.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/logic/login_cubit/login_cubit.dart';
import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/screens/addSchool_screen.dart';
import 'package:velocity_x/velocity_x.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  final String? title;
  const LoginScreen({super.key, this.title});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSchoolCubit, AddSchoolState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AddSchoolSuccessState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      169.heightBox,
                      SvgPicture.asset(MyAssets.schoolLogo),
                      15.heightBox,
                      Text(
                        state.schoolName ?? 'School Name',
                        style: TextStyle(color: Colors.black),
                      ),
                      8.heightBox,
                      const GradientDivider(
                        gradient: MyColors.divider,
                        height: 2.0, // Customize height as needed
                      ),
                      16.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:  Colors.white,
                              
                              border:
                                  Border.all(color: Colors.black, width: 3.0),
                            ),
                            width: 13,
                            height: 14.0,
                          ),
                          5.widthBox,
                          Text(widget.title ?? "")
                        ],
                      ),
                      10.heightBox,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            VxTextField(
                              fillColor: Colors.transparent,
                              borderColor: MyColors.borderColor,
                              borderType: VxTextFieldBorderType.roundLine,
                              hint: MyStrings.userName,
                              style: FontUtil.hintText,
                              borderRadius: 9,
                              validator: (url) {
                                if (url == null || url.isEmpty) {
                                  return MyStrings.userName;
                                }
                                return null;
                              },
                            ),
                            14.heightBox,
                            VxTextField(
                              isPassword: true,
                              obscureText: true,
                              suffixColor: MyColors.textcolors,
                              fillColor: Colors.transparent,
                              borderColor: MyColors.borderColor,
                              borderType: VxTextFieldBorderType.roundLine,
                              hint: MyStrings.passWord,
                              style: FontUtil.hintText,
                              borderRadius: 9,
                              validator: (url) {
                                if (url == null || url.isEmpty) {
                                  return MyStrings.passWord;
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
                            onPressed: () {},
                            child: Text(
                              MyStrings.forgotpassword,
                              style: FontUtil.forgotpassword,
                            ),
                          ),
                        ],
                      ),
                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            NavigationService.navigateTo(NguruDashboardScreen(), context);
                          } else if (state is LoginErrorState) {
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
                          title: MyStrings.signin,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().logIn(
                                  userNameController.text.trim(),
                                  passWordController.text.toString());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(MyStrings.enterusernamepass),
                                ),
                              );
                            }
                          },
                        ),
                      ),
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
        } else {
          return Container();
        }
      },
    );
  }
}
