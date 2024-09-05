

import 'package:nguru/models/notificationlist_model.dart';
abstract class NotificationListState {}
class NotificationListInitState extends NotificationListState {}
class NotificationListLoadingState extends NotificationListState {}
class NotificationListSuccessState extends NotificationListState {
  final NotificationListModel notificationListModel;
  NotificationListSuccessState(this.notificationListModel);
}
class NotificationListErrorState extends NotificationListState {
  final String message;
  NotificationListErrorState(this.message);
}
