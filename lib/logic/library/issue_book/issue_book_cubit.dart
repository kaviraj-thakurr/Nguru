import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/library/issue_book/issue_book_state.dart';
import 'package:nguru/repo/api_calls.dart';

class LibraryIssueBookCubit extends Cubit<LibraryIssueBookState> {
  final AuthRepo? authRepo;

  LibraryIssueBookCubit(this.authRepo) : super(LibraryIssueBookLoadingState());

  Future<void> getLibraryIssueBook() async {
    try {
      emit(LibraryIssueBookLoadingState());
      final result = await authRepo?.getLibraryIssuedBook();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(LibraryIssueBookSuccessState(
              libraryIssued: result.libraryIssued ?? []));
        } else {
          emit(LibraryIssueBookErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(LibraryIssueBookErrorState(e.toString()));
    }
  }
}
