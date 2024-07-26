import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/logic/fees/fees_state.dart';
import 'package:nguru/logic/forgot_password/forgot_password_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';

class FeesCubit extends Cubit<FeesState> {
  final AuthRepo? authRepo;

  FeesCubit(this.authRepo) : super(FeesInitState());

  Future<void> getTotalFees() async {
    try {
      emit(FeesLoadingState());
      final result = await authRepo?.getTotalFees();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(FeesSuccessState(result.feeList!));
        } else {
          emit(FeesErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(FeesErrorState(e.toString()));
    }
  }
}
