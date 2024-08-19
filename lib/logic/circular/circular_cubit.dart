import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/circular/circular_state.dart';
import 'package:nguru/logic/discipline/descipline_state.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/repo/api_calls.dart';

class CircularCubit extends Cubit<CircularState> {
  final AuthRepo? authRepo;
  int currentPage = 1;
  int totalRecords = 0;
  int itemsPerPage = 11;

  CircularCubit(this.authRepo) : super(CircularInitialState());

  Future<void> getCurrentCircular({int page = 1, int? month}) async {
    try {
      emit(CircularLoadingState());
      final result = await authRepo?.getCurrentCircular(page: "page", month: month);
      if (result != null) {
        if (result.responseCode == "200") {
          currentPage = page;
          totalRecords = result.pagination?.totalRecords ?? 0;
          emit(CircularSuccessState(
              circularList: result.circularList ?? []));
        } else {
          emit(CircularErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(CircularErrorState(e.toString()));
    }
  }

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
