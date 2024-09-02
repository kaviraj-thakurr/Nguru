import 'package:nguru/models/exam_sehedule_model.dart';

abstract class ExamScheduleListState {}

class ExamScheduleListInitState extends ExamScheduleListState{}


class ExamScheduleListLoadingState extends ExamScheduleListState{

}

class ExamScheduleListSuccessState extends ExamScheduleListState{

  final ScheduleModel scheduleModel;
  ExamScheduleListSuccessState(this.scheduleModel);

}

class ExamScheduleListErrorState extends ExamScheduleListState{
  final String message;
  ExamScheduleListErrorState(this.message);
}
