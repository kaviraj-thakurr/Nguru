import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/library/history/library_history_state.dart';
import 'package:nguru/repo/api_calls.dart';

class LibraryHistoryCubit extends Cubit<LibraryHistoryState> {
  final AuthRepo? authRepo;

  LibraryHistoryCubit(this.authRepo) : super(LibraryHistoryLoadingState());

  Future<void> getLibraryHistory() async {
    try {
      emit(LibraryHistoryLoadingState());
      final result = await authRepo?.getLibraryHistory();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(LibraryHistorySuccessState(
              libraryHistory: result.libraryHistory ?? []));
        } else {
          emit(LibraryHistoryErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(LibraryHistoryErrorState(e.toString()));
    }
  }
}
