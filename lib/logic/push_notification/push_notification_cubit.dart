
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/push_notification/push_notification_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

class PushNotificationCubit extends Cubit<PushNotificationState>{
  final AuthRepo ? authRepo;
  PushNotificationCubit(this.authRepo):super(PushNotificationLoadingState());
  
Future <void> pushNotification (bool isNotification) async{
  try{
    emit(PushNotificationLoadingState());
    final result = await authRepo?.pushNotification(isNotification);
    if(result != null){
      if(result["responseCode"] == "200"){
        await SharedPref.saveNotificationToggle(isNotification);
        log("unique device token: ${SharedPref.getFcmToken()} ");
   
        emit(PushNotificationSuccessState(
          pushNotificationModel: result["responseMessage"]
        ));
      }else{
         await SharedPref.saveNotificationToggle(isNotification);
        emit(PushNotificationErrorState(result["responseMessage"] ?? "Error occured"));
      }
    }
  }
  catch(e){
     await SharedPref.saveNotificationToggle(isNotification);
    emit(PushNotificationErrorState("Failed to fetch data : $e"));

  }
}

}