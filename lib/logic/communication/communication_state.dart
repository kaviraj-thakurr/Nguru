import 'package:nguru/models/communication_models.dart';

abstract class CommunicationState{}
class CommunicationInitState extends CommunicationState {}

class CommunicationLoadingState extends CommunicationState{}

class CommunicationSuccessState extends CommunicationState{
  final CommunicationModel communicationModel;
  CommunicationSuccessState(this.communicationModel);
}

class CommunicationErrorState extends CommunicationState{
  final String message;
  CommunicationErrorState(this.message);
}