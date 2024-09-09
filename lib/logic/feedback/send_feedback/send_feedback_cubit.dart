import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/feedback/send_feedback/send_feedback_state.dart';
import 'package:nguru/repo/api_calls.dart';

class SendFeedbackCubit  extends Cubit<SendFeedbackState>{
  final AuthRepo ? authRepo;
  SendFeedbackCubit(this.authRepo):super(SendFeedbackInitState());

  Future<void> sendFeedbackDetails(String name, String email, String feedback) async{
    try{
      emit(SendFeedbackLoadingState());
      final result = await authRepo?.sendFeedback(name, email, feedback);
      if(result != null){
        if(result["responseCode"]== "200"){
          emit (SendFeedbackSuccessState(result["responseMessage"] ?? ""));
        }else{
          emit(SendFeedbackErrorState(result["responseMessage"]??"Error occurred"));
        }
      }
    }
    catch(e){
      emit(SendFeedbackErrorState(e.toString()));

    }

  }

  
}