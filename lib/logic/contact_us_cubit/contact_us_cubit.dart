import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nguru/logic/assignment/assignment_month_list/assignment_month_list_state.dart';
import 'package:nguru/logic/contact_us_cubit/contact_us_state.dart';

import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/repo/api_calls.dart';

import 'package:nguru/repo/api_calls.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final AuthRepo?  authRepo;


  ContactUsCubit(this.authRepo) : super(ContactUsLoadingState());


  Future<void> getContactUs() async {
    try {
      emit(ContactUsLoadingState());
      final result = await authRepo?.contactUs();
      if (result != null) {
        if(result.responseCode == "200" ){
          emit(ContactUsSuccessState(contactUs: result));
        }else {
emit(ContactUsErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.schoolPhoto}");
        
      }
    } catch (e) {
      emit(ContactUsErrorState(e.toString()));
    }
  }
}



