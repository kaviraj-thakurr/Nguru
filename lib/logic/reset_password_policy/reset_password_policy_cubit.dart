
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/reset_password/reset_password_state.dart';
import 'package:nguru/logic/reset_password_policy/reset_password_policy_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ResetPasswordPolicyCubit extends Cubit<ResetPasswordPolicyState>{
  final AuthRepo ? authRepo;
  ResetPasswordPolicyCubit(this.authRepo):super(ResetPasswordPolicyInitState());
  
Future <void> resetPasswordPolicy () async{
  try{
    emit(ResetPasswordPolicyLoadingState());
    final result = await authRepo?.getResetPasswordPolicy();
    if(result != null){
      if(result.isNotEmpty){
        emit(ResetPasswordPolicySuccessState(
          resetPasswordPolicyModel: result
        ));
      }else{
        emit(ResetPasswordPolicyErrorState(result.isEmpty ? "List is Empty" : "Some error occured!"));
      }
    }
  }
  catch(e){
    emit(ResetPasswordPolicyErrorState("Failed to fetch data : $e"));

  }
}

}