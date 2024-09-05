import 'package:nguru/models/assignment_models/assignment_list_model.dart';

abstract class AssignmentListState {}

class AssignmentListInitialState extends AssignmentListState {}

class AssignmentListLoadingState extends AssignmentListState {}

class AssignmentListSuccessState extends AssignmentListState {
  final List<SubjectList>? subjectList;
  final List<SubjectList>? subjectListForStory;
   AssignmentListSuccessState( { this.subjectListForStory,   this.subjectList});
}

class AssignmentListErrorState extends AssignmentListState {
  final String message;
  AssignmentListErrorState(this.message);
}