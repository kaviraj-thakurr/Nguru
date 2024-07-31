import 'package:bloc/bloc.dart';
import 'package:nguru/logic/attendence/attendence_state.dart';
import 'package:nguru/repo/api_calls.dart';


class AttendanceCubit extends Cubit<AttendanceState> {
 AuthRepo authRepo;

  AttendanceCubit(this.authRepo) : super(AttendanceInitial());

  Future<void> fetchAttendanceData() async {
    try {
      emit(AttendanceLoading());
      final data = await authRepo.fetchAttendanceData();
      emit(AttendanceSuccess(data.attendanceCumulativeModel!.first.overAllPercentage??""));
    } catch (e) {
      emit(AttendanceError("Failed to fetch data"));
    }
  }
}