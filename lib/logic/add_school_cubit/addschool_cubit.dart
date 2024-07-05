import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';

class AddSchoolCubit extends Cubit<AddSchoolState> {
  final AuthRepo?  authRepo;


  AddSchoolCubit(this.authRepo) : super(AddSchoolLoadingState());


  Future<void> addSchool(String schoolName) async {
    try {
      emit(AddSchoolLoadingState());
      final result = await authRepo?.addSchool(schoolName,);
      if (result != null) {
        if(result.responseCode == "200" || result.schoolName != null){
          emit(AddSchoolSuccessState(schoolName: result.schoolName));
        }else {
          emit(AddSchoolErrorState(result.responseMessage ?? "Error occured"));}
        
      }
    } catch (e) {
      emit(AddSchoolErrorState(e.toString()));
    }
  }
}



