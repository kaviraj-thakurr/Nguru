import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/logic/Chat/chat_state_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_state.dart';
import 'package:nguru/models/chatMessagesList.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  final bool isNewChat;
  const ChatScreen({super.key, this.isNewChat=false});

 
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
     if (widget.isNewChat) {

   
  } else {
    context.read<ChatCubit>().fetchMessages();
  }

    // context.read<ChatCubit>().fetchMessages();
    _scrollController.addListener(onScroll);
    getSharePrefValues();
  }

  void getSharePrefValues() async {
    userID = await SharedPref.getUserID();
    log("User ID: $userID");
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
      
      body: Stack(
        children: [
             Positioned.fill(
            child: Image.asset(
          MyAssets.bg,
          fit: BoxFit.fill,
        )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(padding18),
              child: Column(
                children: [
                  // User Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        maxRadius: 25,
                        backgroundImage: NetworkImage("url"),
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
                  // Chat Messages
                  Expanded(
                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state.errorMessage != null) {
                          return Center(child: Text(state.errorMessage!));
                        } else if (state.messages.isEmpty) {
                          return const Center(child: Text('No messages found.'));
                        }
            
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            ListcommunicationMsgDetail message = state.messages[index];
                            bool isUserMessage = message.createdByUserId == userID;
            
                            return Align(
                              alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isUserMessage ? MyColors.blueShade_3 : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                 
                                ),
                                child: Text(
                                  message.content ?? '',
                                  style: FontUtil.customStyle(fontSize: 13.h, fontWeight: FontWeight.w500, textColor: MyColors.white)
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Input Area
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
                                    contentPadding: const EdgeInsets.only(left: 15),
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
                                              _scrollToBottom();
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
          ),
        ],
      ),
    );
  }
}
