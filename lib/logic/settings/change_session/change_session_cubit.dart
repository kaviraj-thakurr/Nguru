import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/logic/settings/change_session/change_session_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

class ChangeSessionCubit extends Cubit<ChangeSessionState> {
  final AuthRepo? authRepo;

  ChangeSessionCubit(this.authRepo) : super(ChangeSessionLoadingState());

  Future<void> changeSession() async {
    try {
      emit(ChangeSessionLoadingState());
      final result = await authRepo?.changeSession();
      if (result != null) {
        var startDate=await SharedPref.getStartDateOfSession();
        var endDate=  await SharedPref.getEndDateOfSession();
          emit(ChangeSessionSuccessState( changeSessionList: result));
                    log("gettingg the session date: $startDate $endDate");

     //     log("gettingg the session formated date: ${ DateFormat("dd-MMM-yyyy").parse(startDate ?? "") } ${  DateFormat("dd-MMM-yyyy").parse(endDate ?? "")  }");
          log("dates are");

      }
    } catch (e) {
      emit(ChangeSessionErrorState(e.toString()));
    }
  }
}
