

import 'package:nguru/models/change_session_model.dart';

abstract class ChangeSessionState {}

class ChangeSessionInitialState extends ChangeSessionState {}

class ChangeSessionLoadingState extends ChangeSessionState {}

class ChangeSessionSuccessState extends ChangeSessionState {
  final List<ChangeSessionModel> changeSessionList;
   ChangeSessionSuccessState({  required this.changeSessionList});
}

class ChangeSessionErrorState extends ChangeSessionState {
  final String message;
  ChangeSessionErrorState(this.message);
}