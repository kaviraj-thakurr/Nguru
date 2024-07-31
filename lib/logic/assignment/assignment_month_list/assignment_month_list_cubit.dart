import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_state.dart';

import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/repo/api_calls.dart';


class AssignmentMonthListCubit extends Cubit<AssignmentMonthListState> {
  final AuthRepo?  authRepo;


  AssignmentMonthListCubit(this.authRepo) : super(AssignmentMonthListLoadingState());


  Future<void> getAssignmentMonthList() async {
    try {
      emit(AssignmentMonthListLoadingState());
      final result = await authRepo?.getAssignementMonthList();
      if (result != null) {
        if(result.responseCode == "200" ){
          emit(AssignmentMonthListSuccessState(assignmentMonthList: result.assignmentMonthList));
        }else {
emit(AssignmentMonthListErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.assignmentMonthList}");
        
      }
    } catch (e) {
      emit(AssignmentMonthListErrorState(e.toString()));
    }
  }
}



