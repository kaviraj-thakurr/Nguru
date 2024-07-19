// Updated Dashboard State classes
import 'package:nguru/models/dashboard_model.dart';

abstract class NotificationState{}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final int? notificationCount;
 

  NotificationSuccessState({
    this.notificationCount,
  
  });
}

class NotificationErrorState extends NotificationState {
  final String message;
  
  NotificationErrorState(this.message);
}




