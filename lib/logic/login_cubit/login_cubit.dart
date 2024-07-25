import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nguru/logic/login_cubit/login_state.dart';

import 'package:nguru/repo/signin_apiCalls/api_calls.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo? authRepo;

  LoginCubit(this.authRepo) : super(LoginLoadingState());

  Future<void> logIn(String userName, String password) async {
    try {
      emit(LoginLoadingState());
      final result =
          await authRepo?.logIn(userName: userName, password: password);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(LoginSuccessState());
        } else {
          emit(LoginErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
