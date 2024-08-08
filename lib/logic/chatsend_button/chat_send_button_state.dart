import 'package:nguru/models/chatsend_button_model.dart';

abstract class ChatSendButtonState{}
class ChatSendButtonInitState extends ChatSendButtonState {}

class ChatSendButtonLoadingState extends ChatSendButtonState{}

class ChatSendButtonSuccessState extends ChatSendButtonState{
  final ChatSendButton chatSendButtonModel;
  ChatSendButtonSuccessState(this.chatSendButtonModel);
}

class ChatSendButtonErrorState extends ChatSendButtonState{
  final String message;
  ChatSendButtonErrorState(this.message);
}