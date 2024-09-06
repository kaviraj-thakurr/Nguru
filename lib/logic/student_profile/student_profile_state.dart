
import 'package:nguru/models/student_profile_model.dart';

abstract class StudentProfileState {}

class StudentProfileInitialState extends StudentProfileState {}

class StudentProfileLoadingState extends StudentProfileState {}

class StudentProfileSuccessState extends StudentProfileState {
  final StudentProfileModel studentProfileState;
   StudentProfileSuccessState({  required this.studentProfileState});
}

class StudentProfileErrorState extends StudentProfileState {
  final String message;
  StudentProfileErrorState(this.message);
}