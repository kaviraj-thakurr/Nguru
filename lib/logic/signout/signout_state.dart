// Updated Dashboard State classes


abstract class SignoutState{}

class SignoutLoadingState extends SignoutState {}

class SignoutSuccessState extends SignoutState {
  final String? responseMessage;

  SignoutSuccessState({
    this.responseMessage,
  
  });
}

class SignoutErrorState extends SignoutState {
  final String message;
  
  SignoutErrorState(this.message);
}




