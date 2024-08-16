
import 'package:nguru/models/activity_model.dart';

abstract class ActivityState {}

class ActivityInitialState extends ActivityState {}

class ActivityLoadingState extends ActivityState {}

class ActivitySuccessState extends ActivityState {
  final List<ActivityList> activityList;
   ActivitySuccessState({  required this.activityList});
}

class ActivityErrorState extends ActivityState {
  final String message;
  ActivityErrorState(this.message);
}