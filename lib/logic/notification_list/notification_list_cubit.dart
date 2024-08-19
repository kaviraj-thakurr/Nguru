import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/notification_list/notification_list_state.dart';
import 'package:nguru/repo/api_calls.dart';


class NotificationListCubit extends Cubit<NotificationListState> {
  final AuthRepo? authRepo;

  NotificationListCubit(this.authRepo) : super(NotificationListInitState());

  Future<void> getNotificationList() async {
    try {
      emit(NotificationListLoadingState());
      final result = await authRepo?.getNotificationList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(NotificationListSuccessState(result));
        } else {
          emit(NotificationListErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(NotificationListErrorState(e.toString()));
    }
  }
}
