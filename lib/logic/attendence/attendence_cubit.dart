import 'package:bloc/bloc.dart';
import 'package:nguru/logic/attendence/attendence_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';


class AttendanceCubit extends Cubit<AttendanceState> {
 AuthRepo authRepo;

  AttendanceCubit(this.authRepo) : super(AttendanceInitial());

  Future<void> loadAttendanceData() async {
    try {
      emit(AttendanceLoading());
      final data = await authRepo.fetchAttendanceData();
      emit(AttendanceLoaded(data));
    } catch (e) {
      emit(AttendanceError("Failed to fetch data"));
    }
  }
}