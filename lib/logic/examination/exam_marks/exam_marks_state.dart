import 'package:nguru/models/examMarksModel.dart';
import 'package:nguru/models/report_card_model.dart';

abstract class ExamMarksListState {}

class ExamMarksListInitState extends ExamMarksListState{}


class ExamMarksListLoadingState extends ExamMarksListState{

}

class ExamMarksListSuccessState extends ExamMarksListState{

  final ExamMarksModel examMarksModel;
  ExamMarksListSuccessState(this.examMarksModel);

}

class ExamMarksListErrorState extends ExamMarksListState{
  final String message;
  ExamMarksListErrorState(this.message);
}
