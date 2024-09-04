// Updated Dashboard State classes



import 'package:nguru/models/push_notification_model.dart';

abstract class PushNotificationState{}

class PushNotificationLoadingState extends PushNotificationState {}

class PushNotificationSuccessState extends PushNotificationState {
  final String? pushNotificationModel;

  PushNotificationSuccessState({
    this.pushNotificationModel,
  
  });
}

class PushNotificationErrorState extends PushNotificationState {
  final String message;
  
  PushNotificationErrorState(this.message);
}




