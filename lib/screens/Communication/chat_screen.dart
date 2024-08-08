import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nguru/custom_widgets/appbar.dart';
import 'package:nguru/custom_widgets/custom_textformfield.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_cubit.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_state.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:nguru/utils/app_gapping.dart';
import 'package:nguru/utils/app_sizebox.dart';
import 'package:nguru/utils/app_strings.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String sendMessafe = "";
  @override
  void initState() {
    context.read<ChatSendButtonCubit>().sendMessageButton(sendMessafe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
              padding: const EdgeInsets.all(padding20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customAppBar(),
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
                    AppGapping.padding5,
                    Container(color: Colors.red, height: screenHeight * 0.36),
                    const Divider(
                      height: 20,
                    ),
                    Container(color: Colors.green, height: screenHeight * 0.32),
                    AppGapping.padding10,
                    BlocBuilder<ChatSendButtonCubit, ChatSendButtonState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          
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
                            suffixIcon: state is ChatSendButtonLoadingState
                                ? const SizedBox()
                                : state is ChatSendButtonSuccessState
                                    ? IconButton(
                                        onPressed: () {
                                          
                                          context
                                              .read<ChatSendButtonCubit>()
                                              .sendMessageButton(sendMessafe);
                                        },
                                        icon: SvgPicture.asset(MyAssets.sendIcon),
                                      )
                                    : const SizedBox(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
