import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/library/search_book/search_book_state.dart';
import 'package:nguru/repo/api_calls.dart';

class LibrarySearchBookCubit extends Cubit<LibrarySearchBookState> {
  final AuthRepo? authRepo;

  LibrarySearchBookCubit(this.authRepo) : super(LibrarySearchBookInitialState());

  Future<void> getLibrarySearchBook({String? searchQuery=""}) async {
    try {
      emit(LibrarySearchBookLoadingState());
      final result = await authRepo?.getLibrarySearchList(searchQuery: searchQuery);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(LibrarySearchBookSuccessState(
              librarySearch: result.librarySearch ?? []));
        } else {
          emit(LibrarySearchBookErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(LibrarySearchBookErrorState(e.toString()));
    }
  }
}
