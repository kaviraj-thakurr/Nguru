import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_state.dart';
import 'package:nguru/logic/assignment/assignments_list/assignment_list_state.dart';

import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/models/assignment_models/assignment_list_model.dart';

import 'package:nguru/repo/api_calls.dart';

class AssignmentListCubit extends Cubit<AssignmentListState> {
  final AuthRepo?  authRepo;


  AssignmentListCubit(this.authRepo) : super(AssignmentListLoadingState());


  Future<void> getAssignmentList() async {
    try {
      emit(AssignmentListLoadingState());
      final result = await authRepo?.getAssignementList();
      if (result != null) {
        if(result.responseCode == "200" ){
          emit(AssignmentListSuccessState(subjectList: result.subjectList ?? []));
        }else {
emit(AssignmenListErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.subjectList}");
        
      }
    } catch (e) {
      emit(AssignmenListErrorState(e.toString()));
    }
  }
}



