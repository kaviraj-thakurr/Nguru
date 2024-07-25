import 'package:nguru/models/assignment_models/assignment_month_list_model.dart';

abstract class AssignmentMonthListState {}

class AssignmentMonthListInitialState extends AssignmentMonthListState {}

class AssignmentMonthListLoadingState extends AssignmentMonthListState {}

class AssignmentMonthListSuccessState extends AssignmentMonthListState {
  final List<AssignmentMonthList> assignmentMonthList;
   AssignmentMonthListSuccessState({  required this.assignmentMonthList});
}

class AssignmentMonthListErrorState extends AssignmentMonthListState {
  final String message;
  AssignmentMonthListErrorState(this.message);
}