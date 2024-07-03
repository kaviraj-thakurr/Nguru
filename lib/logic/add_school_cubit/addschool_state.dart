import 'package:nguru/models/login_model.dart';

abstract class AddSchoolState {}

class AddSchoolLoadingState extends AddSchoolState {}

class AddSchoolSuccessState extends AddSchoolState {
  final String? schoolName;
   AddSchoolSuccessState({  required this.schoolName});
}

class AddSchoolErrorState extends AddSchoolState {
  final String message;
  AddSchoolErrorState(this.message);
}

