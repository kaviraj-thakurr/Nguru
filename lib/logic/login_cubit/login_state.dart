import 'package:nguru/models/login_model.dart';

abstract class LoginState {}
class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String? schoolPhoto;
  final int? userId;
  final int? schoolId;
  final dynamic schoolLogo;
  final int? changePwdCount;
  final StudentProfile? studentProfile;
  final String? responseCode;
  final String? responseMessage;
  LoginSuccessState({
    this.schoolPhoto,
    this.userId,
    this.schoolId,
    this.schoolLogo,
    this.changePwdCount,
    this.studentProfile,
    this.responseCode,
    this.responseMessage,
  });
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}
