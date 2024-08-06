import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/repo/api_calls.dart';

class CalendarEventCubit extends Cubit<CalendarEventState> {
  final AuthRepo? authRepo;

  CalendarEventCubit(this.authRepo) : super(CalendarEventInitialState());

  Future<void> getCalendarEvent(int monthNumber) async {
    try {
      emit(CalendarEventInitialState());
      final result = await authRepo?.getCalendarEventList(monthNumber: monthNumber);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(CalendarEventSuccessState(
              calendarEventList: result.calendarEventList ?? [],calendarEventListData: []));
        } else {
          emit(CalendarEventErrorState(result.responseMessage ?? "Error occured"));
        }
      //  log("${result.CalendarEventList?.first.toString()}");
      }
    } catch (e) {
      emit(CalendarEventErrorState(e.toString()));
    }
  }

  Future<void> getCalendarEventData(List<CalendarEventList> calendarEventList) async{
    emit(CalendarEventSuccessState(calendarEventListData: calendarEventList)) ;
  }

}
