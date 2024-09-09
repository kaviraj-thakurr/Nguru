import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/logic/Chat/chat_state_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_state.dart';
import 'package:nguru/logic/communication/communication_cubit.dart';
import 'package:nguru/logic/communication/communication_state.dart';
import 'package:nguru/logic/create_communication/save_message_subject_cubit.dart';
import 'package:nguru/logic/create_communication/save_message_subject_state.dart';
import 'package:nguru/models/chatMessagesList.dart';
import 'package:nguru/models/communication_models.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  final int? appMessageID;
  final bool isNewChat;
  const ChatScreen({
    super.key,
    this.isNewChat = false,
    this.appMessageID,
  });

  @override
  _ChatUiScreenState createState() => _ChatUiScreenState();
}

class _ChatUiScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final TextEditingController subjectNameController = TextEditingController();
  int messageTypeId = 0;
  int? userID;
  int maxAppMessageId = 0;

  // for new chat Screen
  bool initiatedTheChat = false;
  List<ListCommunicationHeaderDetail> newChatScreenCommunicationHeader = [];

  @override
  void initState() {
    super.initState();
    if (widget.isNewChat) {
    } else {
      context.read<ChatCubit>().fetchMessages(widget.appMessageID);
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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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
              padding: const EdgeInsets.all(padding15),
              child: Column(
                children: [
                  // User Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          iconSize: 25,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const CircleAvatar(
                        maxRadius: 25,
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
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
                  widget.isNewChat
                      ? Expanded(
                          child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              10.heightBox,
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: MyColors.greyShade_6,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Hi there!\n \nI'm here to help you connect with your child's teacher. To best assist you, can you tell me what kind of message you'd like to send?",
                                    style: FontUtil.customStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        textColor: MyColors.boldTextColor),
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              10.heightBox,
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: MyColors.greyShade_6,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Here are your options: ",
                                        style: FontUtil.customStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            textColor: MyColors.boldTextColor),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      15.heightBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: messageTypeId == 1
                                                  ? MyColors.blueShade_3
                                                      .withOpacity(0.15)
                                                  : MyColors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    messageTypeId = 1;
                                                  });
                                                  dialog();
                                                },
                                                child: Text(
                                                  "General",
                                                  style: FontUtil.customStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor: messageTypeId ==
                                                              1
                                                          ? MyColors.blueShade_3
                                                          : MyColors
                                                              .boldTextColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          10.widthBox,
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: messageTypeId == 2
                                                  ? MyColors.blueShade_3
                                                      .withOpacity(0.15)
                                                  : MyColors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    messageTypeId = 2;
                                                  });
                                                  dialog();
                                                },
                                                child: Text(
                                                  "Complaint",
                                                  style: FontUtil.customStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor: messageTypeId ==
                                                              2
                                                          ? MyColors.blueShade_3
                                                          : MyColors
                                                              .boldTextColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.heightBox,
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: messageTypeId == 3
                                              ? MyColors.blueShade_3
                                                  .withOpacity(0.15)
                                              : MyColors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                messageTypeId = 3;
                                              });
                                              dialog();
                                            },
                                            child: Text(
                                              "Subject Query",
                                              style: FontUtil.customStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: messageTypeId == 3
                                                      ? MyColors.blueShade_3
                                                      : MyColors.boldTextColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              initiatedTheChat
                                  ? BlocBuilder<CommunicationCubit,
                                          CommunicationState>(
                                      builder: (context, state) {
                                      if (state is CommunicationLoadingState) {
                                        const CircularProgressIndicator();
                                      } else if (state
                                          is CommunicationSuccessState) {
                                        newChatScreenCommunicationHeader = state
                                                .communicationModel
                                                .listCommunicationHeaderDetail ??
                                            [];
                                        List<int> appMessageIds =
                                            newChatScreenCommunicationHeader
                                                .map((item) =>
                                                    item.appMessageId ?? 0)
                                                .toList();
                                        maxAppMessageId = appMessageIds
                                            .reduce((a, b) => a > b ? a : b);
                                        context
                                            .read<ChatCubit>()
                                            .fetchMessages(maxAppMessageId);
                                        return BlocBuilder<ChatCubit,
                                                ChatState>(
                                            builder: (context, state) {
                                          if (state.isLoading) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state.errorMessage !=
                                              null) {
                                            return Center(
                                                child:
                                                    Text(state.errorMessage!));
                                          } else if (state.messages.isEmpty) {
                                            return const Center(
                                                child:
                                                    Text('No messages found.'));
                                          }
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            controller: _scrollController,
                                            itemCount: state.messages.length,
                                            itemBuilder: (context, index) {
                                              ListcommunicationMsgDetail
                                                  message =
                                                  state.messages[index];
                                              bool isUserMessage =
                                                  message.createdByUserId ==
                                                      userID;

                                              return Align(
                                                alignment: isUserMessage
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: isUserMessage
                                                        ? MyColors.blueShade_3
                                                        : Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Text(
                                                      message.content ?? '',
                                                      style:
                                                          FontUtil.customStyle(
                                                              fontSize: 13.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              textColor:
                                                                  MyColors
                                                                      .white)),
                                                ),
                                              );
                                            },
                                          );
                                        });
                                      }

                                      return const SizedBox();
                                    })
                                  : const SizedBox(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Divider(
                                              color: Colors
                                                  .grey, // Customize the color here
                                              thickness:
                                                  1.0, // Customize the thickness here
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              'Please type in your query.',
                                              style: TextStyle(
                                                color:
                                                    Colors.grey, // Text color
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Colors
                                                  .grey, // Same color as the first divider
                                              thickness: 1.0, // Same thickness
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ))
                      : Expanded(
                          child: BlocBuilder<ChatCubit, ChatState>(
                            builder: (context, state) {
                              if (state.isLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state.errorMessage != null) {
                                return Center(child: Text(state.errorMessage!));
                              } else if (state.messages.isEmpty) {
                                return const Center(
                                    child: Text('No messages found.'));
                              }

                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    10.heightBox,
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      controller: _scrollController,
                                      itemCount: state.messages.length,
                                      itemBuilder: (context, index) {
                                        ListcommunicationMsgDetail message =
                                            state.messages[index];
                                        bool isUserMessage =
                                            message.createdByUserId == userID;

                                        return Align(
                                          alignment: isUserMessage
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 12),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: isUserMessage
                                                  ? MyColors.blueShade_3
                                                  : Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(message.content ?? '',
                                                style: FontUtil.customStyle(
                                                    fontSize: 13.h,
                                                    fontWeight: FontWeight.w500,
                                                    textColor: MyColors.white)),
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
                  // Input Area
                  widget.isNewChat && initiatedTheChat
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: BlocBuilder<ChatSendButtonCubit,
                                      ChatSendButtonState>(
                                    builder: (context, state) {
                                      return CustomTextFormField(
                                        controller: _controller,
                                        onChanged: (value) {
                                          setState(() {
                                            _controller.text = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 15),
                                          hintText: MyStrings.writeYourMessage,
                                          hintStyle: FontUtil.customStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            textColor:
                                                MyColors.notificationSubtitle,
                                          ),
                                          filled: true,
                                          fillColor: MyColors.chatTextField,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: _controller
                                                  .text.isNotEmpty
                                              ? IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ChatSendButtonCubit>()
                                                        .sendMessageButton(
                                                            _controller.text,
                                                            maxAppMessageId)
                                                        .then((value) => context
                                                            .read<ChatCubit>()
                                                            .fetchMessages(
                                                                maxAppMessageId))
                                                        .then((value) =>
                                                            _controller
                                                                .clear());
                                                    _scrollToBottom();
                                                  },
                                                  icon: SvgPicture.asset(
                                                      MyAssets.sendIcon),
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
                        )
                      : const SizedBox(),

                  widget.isNewChat == false
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: BlocBuilder<ChatSendButtonCubit,
                                      ChatSendButtonState>(
                                    builder: (context, state) {
                                      return CustomTextFormField(
                                        controller: _controller,
                                        onChanged: (value) {
                                          setState(() {
                                            _controller.text = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 15),
                                          hintText: MyStrings.writeYourMessage,
                                          hintStyle: FontUtil.customStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            textColor:
                                                MyColors.notificationSubtitle,
                                          ),
                                          filled: true,
                                          fillColor: MyColors.chatTextField,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: _controller
                                                  .text.isNotEmpty
                                              ? IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            ChatSendButtonCubit>()
                                                        .sendMessageButton(
                                                            _controller.text,
                                                            widget.appMessageID)
                                                        .then((value) => context
                                                            .read<ChatCubit>()
                                                            .fetchMessages(widget
                                                                .appMessageID))
                                                        .then((value) =>
                                                            _controller
                                                                .clear());
                                                    _scrollToBottom();
                                                  },
                                                  icon: SvgPicture.asset(
                                                      MyAssets.sendIcon),
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
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColors.white,
          title: const Text('Chat Subject'),
          content: SizedBox(
            width: double.infinity,
            height: 100,
            child: Column(
              children: [
                const Text('Please enter a chat subject!'),
                25.heightBox,
                CustomTextFormField(
                  controller: subjectNameController,
                  labelText: "Subject",
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
            ),
            TextButton(
              onPressed: () => context
                  .read<SaveMessageSubjectCubit>()
                  .getSaveMessageSubjectDetails(
                      subjectNameController.text.toString(), messageTypeId)
                  .then((value) => Navigator.pop(context))
                  .then((value) => context
                      .read<CommunicationCubit>()
                      .getCommunicationDetails())
                  .then((value) {
                setState(() {
                  initiatedTheChat = true;
                });
              }).then((value) {
                BlocListener<SaveMessageSubjectCubit, SaveMessageSubjectState>(
                    listener: (context, state) {
                  if (state is SaveMessageSubjectSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Subject Created Successfully!")));
                  } else if (state is SaveMessageSubjectErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Something went Wrong!")));
                  }
                });
              }),
              child: Text(
                'Add',
                style: FontUtil.customStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: MyColors.boldTextColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
