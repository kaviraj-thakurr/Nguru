abstract class SendFeedbackState{}
class SendFeedbackInitState extends SendFeedbackState {}

class SendFeedbackLoadingState extends SendFeedbackState{}

class SendFeedbackSuccessState extends SendFeedbackState{
  final String sendFeedbackResponse;
  SendFeedbackSuccessState(this.sendFeedbackResponse);
}

class SendFeedbackErrorState extends SendFeedbackState{
  final String message;
  SendFeedbackErrorState(this.message);
}