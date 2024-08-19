import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/logic/Chat/chat_state_cubit.dart';
// Import your cubit
import 'package:nguru/logic/chatsend_button/chat_send_button_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_state.dart';
import 'package:nguru/models/chatMessagesList.dart';
import 'package:nguru/models/message_model.dart';

import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart'; // Import your model

class ChatScreen extends StatefulWidget {
  @override
  _ChatUiScreenState createState() => _ChatUiScreenState();
}

class _ChatUiScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  int? userID;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().fetchMessages();
    _scrollController.addListener(onScroll);
    getSharePrefVAlues();
  }

  void getSharePrefVAlues() async{
   userID=await SharedPref.getUserID();
   log("qwerty: $userID");
  }

  void onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Handle pagination if needed
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }











  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
              color: Color.fromARGB(255, 103, 195, 232),
              fontWeight: FontWeight.w500,
              fontSize: 30),
        ),
        backgroundColor: const Color.fromRGBO(35, 33, 46, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(
                    "url",
                  ),
                ),
                10.widthBox,
                Text(
                  "Anandi Jha",
                  style: FontUtil.customStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      textColor: MyColors.addButtonColor),
                )
              ],
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      ListcommunicationMsgDetail message = state.messages[index];
                      var isUserMessage = message.createdByUserId; 

                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            isUserMessage != 6135
                                ? Row(
                                    children: [
                                      const SizedBox(width: 17),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            child: Text(
                                              message.content ?? '',
                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height *0.03,
                                            width:  MediaQuery.of(context).size.width *0.03,
                                            decoration: BoxDecoration(

                                            ),
                                            child: Text(
                                              message.content ?? '',
                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 17),
                                    ],
                                  ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      );
                    },
                  );
                  } else if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  } else if (state.messages.isEmpty) {
                    return const Center(child: Text('No messages found.'));
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                                  height: MediaQuery.of(context).size.height * 0.14,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: MyColors.greyShade_6,
                                    borderRadius: BorderRadius.circular(15),
                           
                                  ),
                           
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Hi there!\n \nI'm here to help you connect with your child's teacher. To best assist you, can you tell me what kind of message you'd like to send?",
                                              style: FontUtil.customStyle(fontSize: 13, fontWeight: FontWeight.w400, textColor: MyColors.boldTextColor),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,),
                                  ),
                                ),
                         ),
                         Container(
                                  height: MediaQuery.of(context).size.height * 0.14,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: MyColors.greyShade_6,
                                    borderRadius: BorderRadius.circular(15),
                           
                                  ),
                           
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Here are your options: ",
                                                  style: FontUtil.customStyle(fontSize: 13, fontWeight: FontWeight.w400, textColor: MyColors.boldTextColor),
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,),

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        height:  MediaQuery.of(context).size.height*0.03,
                                                        width: MediaQuery.of(context).size.width*0.15,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: MyColors.blueShade_3.withOpacity(0.15),

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Text("General",
                                                          style: FontUtil.customStyle(fontSize: 13, fontWeight: FontWeight.w400, textColor: MyColors.blueShade_3),
                                                          textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        
                                                      ),
                                                      Container(
                                                        height:  MediaQuery.of(context).size.height*0.03,
                                                        width: MediaQuery.of(context).size.width*0.15,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: MyColors.white,

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Text("Complaint",
                                                          style: FontUtil.customStyle(fontSize: 13, fontWeight: FontWeight.w400, textColor: MyColors.boldTextColor),
                                                          textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        
                                                      ),
                                                    ],
                                                  ),
                                                  5.heightBox,
                                                  Container(
                                                        height:  MediaQuery.of(context).size.height*0.03,
                                                        width: MediaQuery.of(context).size.width*0.15,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: MyColors.white,

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Text("Complaint",
                                                          style: FontUtil.customStyle(fontSize: 13, fontWeight: FontWeight.w400, textColor: MyColors.boldTextColor),
                                                          textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        
                                                      ),
                                      ],
                                    ),
                                  ),
                                ),
                        ListView.builder(
                          
                          controller: _scrollController,
                          itemCount: state.messages.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            ListcommunicationMsgDetail message = state.messages[index];
                            var isUserMessage = message.createdByUserId; 
                        
                            return Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  
                                  isUserMessage != 6135
                                      ? Row(
                                          children: [
                                            const SizedBox(width: 17),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: Colors.red,
                                                  child: Text(
                                                    message.content ?? '',
                                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  message.content ?? '',
                                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 17),
                                          ],
                                        ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 5),
                      child: BlocBuilder<ChatSendButtonCubit, ChatSendButtonState>(
                        builder: (context, state) {
                          return CustomTextFormField(
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                _controller.text = value;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              hintText: MyStrings.writeYourMessage,
                              hintStyle: FontUtil.customStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                textColor: MyColors.notificationSubtitle,
                              ),
                              filled: true,
                              fillColor: MyColors.chatTextField,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: _controller.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        context.read<ChatSendButtonCubit>().sendMessageButton(
                                         _controller.text
                                        ).then((value) =>  context.read<ChatCubit>().fetchMessages()).then((value) => _controller.clear());
                                      },
                                      icon: SvgPicture.asset(MyAssets.sendIcon),
                                    )
                                  : const SizedBox(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   
}
