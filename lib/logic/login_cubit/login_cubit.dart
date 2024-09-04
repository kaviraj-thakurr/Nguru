import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/login_cubit/login_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/app_utils.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

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
          await SharedPref.saveUserID(result.userId ??0);
          await SharedPref.saveSchoolID(result.schoolId ?? 0);
          await SharedPref.saveStudentID(result.studentProfile?.studentId ?? 0);
          await SharedPref.saveSessionID(result.studentProfile?.sessionId ?? 0);
          await SharedPref.saveLoggedInStatus(true);
          await SharedPref.saveSessionSeleted(isSessionSelected: false);
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
