
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState>{
  final AuthRepo ? authRepo;
  ResetPasswordCubit(this.authRepo):super(ResetPasswordInitState());
  
Future <void> resetPassword (String newPassword, String oldPassword) async{
  try{
    emit(ResetPasswordLoadingState());
    final result = await authRepo?.resetPassword(newPassword: newPassword, oldPassword: oldPassword);
    if(result != null){
      if(result.responseCode == "200"){
        emit(ResetPasswordSuccessState(
          resetPasswordModel: result
        ));
      }
    // else  if(result.responseCode == "500"){
    //     emit(ResetPasswordSuccessState(
    //       resetPasswordModel: result
    //     ));
    //   }
   else if(result.responseCode == "500"){
         emit(ResetPasswordErrorState(result.responseMessage ?? "Error occured"));
      }
      else{
        emit(ResetPasswordErrorState(result.responseMessage ?? "Error occured"));
      }
    }
  }
  catch(e){
    emit(ResetPasswordErrorState("Failed to fetch data : $e"));

  }
}

}