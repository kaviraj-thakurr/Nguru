import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nguru/logic/circular/circular_list/circular_state.dart';
import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/repo/api_calls.dart';

class CircularCubit extends Cubit<CircularState> {
  final AuthRepo? authRepo;
  int currentPage = 1;
  int totalRecords = 0;
  int itemsPerPage = 11;

  CircularCubit(this.authRepo) : super(CircularInitialState());

  List<CircularList> circularList=[];

  Future<void> getCurrentCircular({int page = 1, int? month}) async {
    circularList.clear();
    try {
      emit(CircularLoadingState());
      final result = await authRepo?.getCurrentCircular(page: "page", month: month);
      final storyResult = await authRepo?.getCurrentCircular(page: "page", month: month);
      if (result != null) {
        if (result.responseCode == "200") {
          currentPage = page;
          totalRecords = result.pagination?.totalRecords ?? 0;
          emit(CircularSuccessState(
              circularList: result.circularList ?? [], storyCircularList: storyResult?.circularList ?? []));
              circularList = (state as CircularSuccessState).circularList;
        } else {
          emit(CircularErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(CircularErrorState(e.toString()));
    }
  }



    void filterCircularListByDate(DateTime selectedDate, bool isOnlyMonthSelected) {
 //   if (state is DisciplineSuccessState) {
    //  final disciplineList = (state as DisciplineSuccessState).disciplineList;
   // disciplineList.clear();
      final filteredList =
      isOnlyMonthSelected ? 
      circularList
          .where((item) =>
              DateFormat("dd-MMM-yyyy").parse(item.circularDate!).year == selectedDate.year ||
              DateFormat("dd-MMM-yyyy").parse(item.circularDate!).month == selectedDate.month)
          .toList()
          :
       circularList
          .where((item) =>
              DateFormat("dd-MMM-yyyy").parse(item.circularDate!).year == selectedDate.year ||
              DateFormat("dd-MMM-yyyy").parse(item.circularDate!).month == selectedDate.month ||
              DateFormat("dd-MMM-yyyy").parse(item.circularDate!).day == selectedDate.day)
          .toList();
      emit(CircularFilterState(filterList: filteredList));
    //}
  }









/// PAGINATION

  void nextPage() {
    if (currentPage * itemsPerPage < totalRecords) {
      getCurrentCircular(page: currentPage + 1);
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      getCurrentCircular(page: currentPage - 1);
    }
  }

  void filterCirculars(String query) {
    final currentState = state;
    if (currentState is CircularSuccessState) {
      final filteredCirculars = currentState.circularList.where((circular) {
        final subject = circular.subject?.toLowerCase() ?? '';
        return subject.contains(query.toLowerCase());
      }).toList();
      emit(CircularFilteredState(filteredCircularList: filteredCirculars));
    }
  }
}
