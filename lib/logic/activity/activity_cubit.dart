
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/activity/activity_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final AuthRepo? authRepo;

  ActivityCubit(this.authRepo) : super(ActivityLoadingState());

  Future<void> getActivity() async {
    try {
      emit(ActivityLoadingState());
      final result = await authRepo?.getActivityList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(ActivitySuccessState(
              activityList: result.activityList ?? []));
        } else {
          emit(ActivityErrorState(result.responseMessage ?? "Error occured"));
        }
      //  log("${result.ActivityList?.first.toString()}");
      }
    } catch (e) {
      emit(ActivityErrorState(e.toString()));
    }
  }
}
