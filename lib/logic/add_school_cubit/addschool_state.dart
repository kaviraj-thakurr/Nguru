
abstract class AddSchoolState {}


class AddSchoolInitState extends AddSchoolState {}

class AddSchoolLoadingState extends AddSchoolState {}

class AddSchoolSuccessState extends AddSchoolState {
  final String? schoolName;
  final String ? schoolPhoto;
  final String  ? nickName;
  
  AddSchoolSuccessState({required this.schoolName, required this.schoolPhoto,  this.nickName});
}

class AddSchoolSuccessUpdated extends AddSchoolState {
  final String? schoolName;
  final String ? schoolPhoto;
  final String  ? nickName;
  
  AddSchoolSuccessUpdated({required this.schoolName, required this.schoolPhoto,  this.nickName});
}

class AddSchoolErrorState extends AddSchoolState {
  final String message;
  AddSchoolErrorState(this.message);
}
