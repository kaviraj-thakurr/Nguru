
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/push_notification/push_notification_state.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';

class PushNotificationCubit extends Cubit<PushNotificationState>{
  final AuthRepo ? authRepo;
  PushNotificationCubit(this.authRepo):super(PushNotificationLoadingState());
  
Future <void> PushNotification (int isNotification) async{
  try{
    emit(PushNotificationLoadingState());
    final result = await authRepo?.pushNotification(isNotification: isNotification);
    if(result != null){
      if(result.responseCode == "200"){
        emit(PushNotificationSuccessState(
          pushNotificationModel: result
        ));
      }else{
        emit(PushNotificationErrorState(result.responseMessage ?? "Error occured"));
      }
    }
  }
  catch(e){
    emit(PushNotificationErrorState("Failed to fetch data : $e"));

  }
}

}