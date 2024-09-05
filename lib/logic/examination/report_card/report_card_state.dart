import 'package:nguru/models/report_card_model.dart';

abstract class ReportCardListState {}

class ReportCardListInitState extends ReportCardListState{}


class ReportCardListLoadingState extends ReportCardListState{

}

class ReportCardListSuccessState extends ReportCardListState{

  final ReportCardModel reportCardModel;
  ReportCardListSuccessState(this.reportCardModel);

}

class ReportCardListErrorState extends ReportCardListState{
  final String message;
  ReportCardListErrorState(this.message);
}
