import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/logic/discipline/descipline_state.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/app_strings.dart';

class DisciplineCubit extends Cubit<DisciplineState> {
  final AuthRepo? authRepo;

  DisciplineCubit(this.authRepo) : super(DisciplineLoadingState());


List<DisciplineList> disciplineList=[];
  Future<void> getDiscipline({int? type}) async {
    disciplineList.clear();
    // type = 1 for fetching all the discipline 
    try {
      emit(DisciplineLoadingState());
      final result = await authRepo?.getDisciplineList(type: type ?? 0);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(DisciplineSuccessState(
              disciplineList: result.disciplineList ?? []));
               disciplineList = (state as DisciplineSuccessState).disciplineList;
        } else {
          emit(DisciplineErrorState(result.responseMessage ?? "Error occured"));
        }
        
      }
    } catch (e) {
      emit(DisciplineErrorState(e.toString()));
    }
  }




    void filterDisciplineListByDate(DateTime selectedDate, bool IsOnlyMonthSelected) {
 //   if (state is DisciplineSuccessState) {
    //  final disciplineList = (state as DisciplineSuccessState).disciplineList;
   // disciplineList.clear();
      final filteredList =
      IsOnlyMonthSelected ? 
      disciplineList
          .where((item) =>
              DateFormat("dd/MM/yyyy").parse(item.actionDate!).year == selectedDate.year ||
              DateFormat("dd/MM/yyyy").parse(item.actionDate!).month == selectedDate.month)
          .toList()
          :
       disciplineList
          .where((item) =>
              DateFormat("dd/MM/yyyy").parse(item.actionDate!).year == selectedDate.year ||
              DateFormat("dd/MM/yyyy").parse(item.actionDate!).month == selectedDate.month ||
              DateFormat("dd/MM/yyyy").parse(item.actionDate!).day == selectedDate.day)
          .toList();
      emit(DisciplineFilteredState(filteredList: filteredList));
    //}
  }
}
