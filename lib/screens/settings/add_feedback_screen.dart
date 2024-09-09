import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/custom_widgets/primary_butttons.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/logic/feedback/send_feedback/send_feedback_cubit.dart';
import 'package:nguru/logic/feedback/send_feedback/send_feedback_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class AddFeedBackScreen extends StatefulWidget {
  const AddFeedBackScreen({super.key});

  @override
  State<AddFeedBackScreen> createState() => _AddFeedBackScreenState();
}

class _AddFeedBackScreenState extends State<AddFeedBackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedBackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
            screenTitleHeader(MyStrings.feedback,
                onPressed: () => Navigator.pop(context)),
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
                        labelText: MyStrings.name,
                      ),
                      20.heightBox,
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: MyStrings.email,
                      ),
                      20.heightBox,
                      CustomTextFormField(
                        controller: _feedBackController,
                        maxLine: 5,
                        labelText: MyStrings.feedback,
                      ),
                      20.heightBox,
                    ],
                  ),
                  BlocConsumer<SendFeedbackCubit, SendFeedbackState>(
                      builder: (context, state) {
                    return const SizedBox.shrink();
                  }, listener: (context, state) {
                    if (state is SendFeedbackSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.sendFeedbackResponse)));
                    } else if (state is SendFeedbackErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(MyStrings.somethingWentWrong)));
                    }
                  }),
                  PrimaryButton(
                      title: MyStrings.send,
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _nameController.text.isEmpty ||
                            _feedBackController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text(MyStrings.pleaseAddProperDetails)),
                          );
                        } else if (_emailController.text.isNotEmpty ||
                            _nameController.text.isNotEmpty ||
                            _feedBackController.text.isNotEmpty) {
                          context
                              .read<SendFeedbackCubit>()
                              .sendFeedbackDetails(
                                  _nameController.text.toString(),
                                  _emailController.text.toString(),
                                  _feedBackController.text.toString())
                              .then((value) => {
                                    _nameController.clear(),
                                    _emailController.clear(),
                                    _feedBackController.clear()
                                  });
                        }
                      }),
                ],
              ),
            )
          ])),
    ]));
  }
}
