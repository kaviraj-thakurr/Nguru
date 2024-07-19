import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/notification/notification_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';

class NotificationCubit extends Cubit<NotificationState>{
  final AuthRepo ? authRepo;
  NotificationCubit(this.authRepo):super(NotificationLoadingState());
  
Future <void> notificationCount () async{
  try{
    emit(NotificationLoadingState());
    final result = await authRepo?.notificationCount();
    if(result != null){
      if(result.responseCode == "200"){
        emit(NotificationSuccessState(
          notificationCount: result.notificationCount,
        ));
      }else{
        emit(NotificationErrorState(result.responseMessage??"Error occured"));
      }
    }
  }
  catch(e){
    emit(NotificationErrorState("Failed to fetch data : $e"));

  }
}

}