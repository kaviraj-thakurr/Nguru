import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/student_profile/student_profile_state.dart';
import 'package:nguru/repo/api_calls.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  final AuthRepo? authRepo;

  StudentProfileCubit(this.authRepo) : super(StudentProfileLoadingState());

  Future<void> getStudentProfile() async {
    try {
      emit(StudentProfileLoadingState());
      final result = await authRepo?.getStudentProfile();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(StudentProfileSuccessState(
              studentProfileState: result ));
        } else {
          emit(StudentProfileErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(StudentProfileErrorState(e.toString()));
    }
  }
}
