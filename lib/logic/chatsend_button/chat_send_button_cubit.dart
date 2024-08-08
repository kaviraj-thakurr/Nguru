import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/chatsend_button/chat_send_button_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ChatSendButtonCubit  extends Cubit<ChatSendButtonState>{
  final AuthRepo ? authRepo;
  ChatSendButtonCubit(this.authRepo):super(ChatSendButtonInitState());

  Future<void>sendMessageButton(String ? message) async{
    try{
      emit(ChatSendButtonLoadingState());
      final result = await authRepo?.sendMessageButton(message);
      if(result != null){
        if(result.responseCode== "200"){
          emit (ChatSendButtonSuccessState(result));
        }else{
          emit(ChatSendButtonErrorState(result.responseMessage??"Error occurred"));
        }
      }
    }
    catch(e){
      emit(ChatSendButtonErrorState(e.toString()));

    }

  }

  
}