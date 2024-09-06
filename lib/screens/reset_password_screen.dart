import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/reset_password/reset_password_cubit.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/logic/reset_password_policy/reset_password_policy_cubit.dart';
import 'package:nguru/logic/reset_password_policy/reset_password_policy_state.dart';
import 'package:nguru/models/reset_password_policy_model.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confiremNewPasswordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    context.read<ResetPasswordPolicyCubit>().resetPasswordPolicy();
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confiremNewPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          30.heightBox,
          screenTitleHeader(MyStrings.resetPassword,
              onPressed: () => Navigator.pop(context)),
          15.heightBox,
          // Text(
          //   "Lorem ipsum dolor sit amet consectetur. Eget enim vulputate porta diam diam.",
          //   textAlign: TextAlign.center,
          //   style: FontUtil.customStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       textColor: MyColors.fadedTextColor),
          // ),
          // 14.heightBox,

          TextFormField(
            obscureText: _obscureText,
            controller: currentPasswordController,
            decoration: InputDecoration(
              label: const Text(
                MyStrings.currentpass,
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.borderColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
              ),
            ),
            style: FontUtil.signInFieldText,
            validator: (url) {
              if (url == null || url.isEmpty) {
                return MyStrings.passWord;
              }
              return null;
            },
          ),
         
          14.heightBox,

          TextFormField(
            obscureText: _obscureText,
            controller: newPasswordController,
            decoration: InputDecoration(
              label: const Text(
                MyStrings.newpass,
                style: TextStyle(
                   
                    fontSize: 15,
                    color: Colors.grey,
                    fontFamily: "Effra_Trial"),
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.borderColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
              ),
            ),
            style: FontUtil.signInFieldText,
            validator: (url) {
              if (url == null || url.isEmpty) {
                return MyStrings.passWord;
              }
              return null;
            },
          ),
       
          14.heightBox,

          TextFormField(
            obscureText: _obscureText,
            controller: confiremNewPasswordController,
            decoration: InputDecoration(
              label: const Text(
                MyStrings.confirmnewpass,
                style: TextStyle(
                  
                    fontSize: 15,
                    color: Colors.grey,
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.borderColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
              ),
            ),
            style: FontUtil.signInFieldText,
            validator: (url) {
              if (url == null || url.isEmpty) {
                return MyStrings.passWord;
              }
              return null;
            },
          ),
          10.heightBox,
          BlocConsumer<ResetPasswordPolicyCubit,ResetPasswordPolicyState>(
            listener: (context,state){},
            builder: (context,state){
              if(state is ResetPasswordPolicyLoadingState){
                  return const SizedBox();
              }
              else if(state is ResetPasswordPolicySuccessState){
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:() => showDialog(
                        context: context, 
                        builder: (BuildContext context) { 
                          return buildPasswordPolicyAlertDialog(context: context,resetPasswordPolicyModel: state.resetPasswordPolicyModel);
                         }

                      ),
                      child: Text("Reset Password Policy",style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.blueShade),)),
                  ],
                );
              }
              else if(state is ResetPasswordPolicyErrorState){
                  return const Text(MyStrings.error);
              }
              else {
                 return const Text(MyStrings.undefinedState);
              }
            }, ),

          


         
          30.heightBox,
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
            if (state is ResetPasswordLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return PrimaryButton(
                  title: MyStrings.signIn,
                  onPressed: () {
                    if (currentPasswordController.text.isNotEmpty &&
                        newPasswordController.text.isNotEmpty &&
                        confiremNewPasswordController.text.isNotEmpty &&
                        newPasswordController.text ==
                            confiremNewPasswordController.text) {
                      context.read<ResetPasswordCubit>().resetPassword(
                          confiremNewPasswordController.text,
                          currentPasswordController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                             MyStrings.resetPassInstruction1)));
                    }
                  });
            }
          }, listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(MyStrings.resetPassInstruction2)));
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const LoginScreen()));
              Navigator.pop(context);
            } else if (state is ResetPasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.message)));
            }
          }),
        ],
      ),
    ));
  }


  Widget buildPasswordPolicyAlertDialog({
  required BuildContext context,
  List<ResetPasswordPolicyModel>? resetPasswordPolicyModel
}) {
  return  BottomSheet(
    backgroundColor: MyColors.white,
    enableDrag: true,
     onClosing: () {  },
      builder: (BuildContext context) { 
        return Container(
          padding: EdgeInsets.all(20),
          height: 350,
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true, 
        itemCount: resetPasswordPolicyModel?.length ?? 0,
        itemBuilder: (context, index) {
          final policy = resetPasswordPolicyModel?[index];
          switch (policy?.key) {
            case "CORE_PSWD_LENGHT_MAX":
              return Text(
                '• Password should be maximum of 20 characters.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
              ).h8(context);
            case "PASSWORD_MINIMUM_LENGHT":
              return Text(
                '• Password should be minimum of 6 characters.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
             ).h8(context);
            case "PASSWORD_FIRST_LAST_ALPHABET":
              return Text(
                '• Password should contain at least 2 alphabets.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
             ).h8(context);
            case "PASSWORD_HISTORY_CHECK":
              return Text(
                '• Password should be different from last 4 passwords.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
             ).h8(context);
            case "PASSWORD_ALPHA_NUMERIC":
              return Text(
                '• Password must be alphanumeric.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
              ).h8(context);
            case "PASSWORD_EXIST_USERNAME":
              return Text(
                '• Password must not exist in the username.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
              ).h8(context);
            case "PASSWORD_IDENTICAL_CHAR":
              return Text(
                '• Password must not contain identical characters consecutively.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
             ).h8(context);
            case "PASSWORD_CONSECUTIVE_CHAR":
              return Text(
                '• Password must not contain consecutive characters.',
                style: FontUtil.customStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: MyColors.boldTextColor,
                ),
              ).h8(context);
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
       },
   
   
  );
}
}
