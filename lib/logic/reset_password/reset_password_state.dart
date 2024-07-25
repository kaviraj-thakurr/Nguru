// Updated Dashboard State classes


import 'package:nguru/models/reset_password_model.dart';

abstract class ResetPasswordState{}

class ResetPasswordInitState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {
  final ResetPasswordModel? resetPasswordModel;

  ResetPasswordSuccessState({
    this.resetPasswordModel,
  
  });
}

class ResetPasswordErrorState extends ResetPasswordState {
  final String message;
  
  ResetPasswordErrorState(this.message);
}




