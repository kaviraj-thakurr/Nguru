


import 'package:nguru/models/change_siblings_model.dart';
abstract class SiblingListState {}
class SiblingListInitState extends SiblingListState {}
class SiblingListLoadingState extends SiblingListState {}
class SiblingListSuccessState extends SiblingListState {
  final ChangeSiblingsModel changeSiblingsModel;
  SiblingListSuccessState(this.changeSiblingsModel);
}
class SiblingListErrorState extends SiblingListState {
  final String message;
  SiblingListErrorState(this.message);
}
