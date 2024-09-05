
import 'package:nguru/models/reset_password_policy_model.dart';

abstract class ResetPasswordPolicyState{}

class ResetPasswordPolicyInitState extends ResetPasswordPolicyState {}

class ResetPasswordPolicyLoadingState extends ResetPasswordPolicyState {}

class ResetPasswordPolicySuccessState extends ResetPasswordPolicyState {
  final List<ResetPasswordPolicyModel>? resetPasswordPolicyModel;

  ResetPasswordPolicySuccessState({
    this.resetPasswordPolicyModel,
  
  });
}

class ResetPasswordPolicyErrorState extends ResetPasswordPolicyState {
  final String message;
  
  ResetPasswordPolicyErrorState(this.message);
}




