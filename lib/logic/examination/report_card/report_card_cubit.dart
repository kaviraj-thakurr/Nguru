import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nguru/logic/examination/report_card/report_card_state.dart';
import 'package:nguru/repo/api_calls.dart';


class ReportCardListCubit extends Cubit<ReportCardListState> {
  final AuthRepo? authRepo;

  ReportCardListCubit(this.authRepo) : super(ReportCardListInitState());

  Future<void> getReportCardList() async {
    try {
      emit(ReportCardListLoadingState());
      final result = await authRepo?.getReportCardList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(ReportCardListSuccessState(result));
        } else {
          emit(ReportCardListErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(ReportCardListErrorState(e.toString()));
    }
  }
}
