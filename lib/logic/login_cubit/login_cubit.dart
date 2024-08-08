import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/app_utils.dart';

import 'package:nguru/repo/api_calls.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo? authRepo;

  LoginCubit(this.authRepo) : super(LoginInitState());

  Future<void> logIn(String userName, String password ,String schoolUrl) async {
    try {
      emit(LoginLoadingState());
      final result =
          await authRepo?.logIn(userName: userName, password: password,schoolUrl: schoolUrl) ;
      if (result != null) {
        if (result.responseCode == "200") {
          if (isFromForgotPassword) {
            emit(LoginForgetPasswordState());
          } else {
            emit(LoginSuccessState());
          }
        } else {
          emit(LoginErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  
}
