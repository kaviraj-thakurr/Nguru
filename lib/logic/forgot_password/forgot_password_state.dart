
abstract class ForgetPasswordState {}

class ForgetPassInitState extends ForgetPasswordState{}

class ForgetPassLoadingState extends ForgetPasswordState {}

class ForgetPassSuccessState extends ForgetPasswordState {
 
  ForgetPassSuccessState();
}

class ForgetPassErrorState extends ForgetPasswordState {
  final String message;
 ForgetPassErrorState(this.message);
}
