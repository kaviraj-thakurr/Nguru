import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/fee/fee_list_state.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_state.dart';
import 'package:nguru/repo/api_calls.dart';

class FeeListCubit
    extends Cubit<FeeListState> {
  final AuthRepo? authRepo;

  FeeListCubit(this.authRepo)
      : super(FeeListLoadingState());

  Future<void> getFeeList() async {
    try {
      emit(FeeListLoadingState());
      final result = await authRepo?.getFeeList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(FeeListSuccessState(
              feeListModel: result.feeList ?? []));
        } else {
          emit(FeeListErrorState(
              result.responseMessage ?? "Error occured"));
        }
        log("$result");
      }
    } catch (e) {
      emit(FeeListErrorState(e.toString()));
    }
  }
}
