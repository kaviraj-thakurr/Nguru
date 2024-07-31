import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/models/dashboard_model.dart';
import 'package:nguru/repo/api_calls.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AuthRepo? authRepo;

  DashboardCubit(this.authRepo) : super(DashboardLoadingState());

  Future<void> dashboardGetList() async {
    try {
      emit(DashboardLoadingState());
      final result = await authRepo?.dashboardGetList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(DashboardSuccessState(
            studentName: result.studentName,
            studentPicture: result.studentPicture,
            qualification: result.qualification,
            admissionNumber: result.admissionNumber,
            section: result.section,
            dashboardList: result.dashboardList
                ?.map<Map<String, String>>((item) => {
                      'dashboardItem': item.dashboardItem ?? '',
                      'dashboardValue': item.dashboardValue ?? ''
                    })
                .toList(),
          ));
        } else {
          emit(DashboardErrorState(result.responseMessage ?? "Error occurred"));
        }
      } else {
        emit(DashboardErrorState("No data received"));
      }
    } catch (e) {
      emit(DashboardErrorState("Failed to fetch data: $e"));
    }
  }
}


