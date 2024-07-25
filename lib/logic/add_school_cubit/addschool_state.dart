import 'package:nguru/models/login_model.dart';

abstract class AddSchoolState {}

class AddSchoolLoadingState extends AddSchoolState {}

class AddSchoolSuccessState extends AddSchoolState {
  final String? schoolName;
  final String ? schoolPhoto;
  AddSchoolSuccessState({required this.schoolName, required this.schoolPhoto});
}

class AddSchoolErrorState extends AddSchoolState {
  final String message;
  AddSchoolErrorState(this.message);
}
