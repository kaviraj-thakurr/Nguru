import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/feedback/send_feedback/send_feedback_cubit.dart';
import 'package:nguru/logic/feedback/send_feedback/send_feedback_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:velocity_x/velocity_x.dart';

class AddFeedBackScreen extends StatefulWidget {
  const AddFeedBackScreen({super.key});

  @override
  State<AddFeedBackScreen> createState() => _AddFeedBackScreenState();
}

class _AddFeedBackScreenState extends State<AddFeedBackScreen> {

 final TextEditingController _nameController= TextEditingController();
 final TextEditingController _emailController= TextEditingController();
 final TextEditingController _feedBackController= TextEditingController();
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            MyAssets.bg,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              20.heightBox,
              dashboardAppBar(),
              10.heightBox,
              screenTitleHeader("Feedback", onPressed: ()=> Navigator.pop(context)),
              10.heightBox,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        10.heightBox,
                        CustomTextFormField(
                        controller: _nameController,
                          labelText: "Name",
                        ),
                        20.heightBox,
                        CustomTextFormField(
                        controller: _emailController,
                          labelText: "Email",
                        ),
                        20.heightBox,
                        CustomTextFormField(
                          controller: _feedBackController,
                          maxLine: 5,
                          labelText: "Feedback",
                            
                        ),
                        20.heightBox,

                      ],
                    ),
                    PrimaryButton(title: "Send", 
                    onPressed: (){
                      if(_emailController.text.isEmpty || _nameController.text.isEmpty || _feedBackController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text("Please add proper details!")),
                        );
                      }
                      else if (_emailController.text.isNotEmpty || _nameController.text.isNotEmpty || _feedBackController.text.isNotEmpty){
                         context.read<SendFeedbackCubit>().getSendFeedbackDetails(
                      _nameController.text.toString(), _emailController.text.toString(), _feedBackController.text.toString());
                      }
                    }),

                    BlocConsumer<SendFeedbackCubit, SendFeedbackState>(
                  builder: (context, state) {
                return const SizedBox();
              }, listener: (context, state) {
                if (state is SendFeedbackSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign out Successfully")));
                } else if (state is SendFeedbackErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign out Successfully")));
                }
              })


                  ],
                ),
              )
            ]
    )
          ),
        ]
      )
    );
  }
}