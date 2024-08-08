
import 'package:nguru/models/library_history_model.dart';
import 'package:nguru/models/library_issued_book_model.dart';

abstract class LibraryHistoryState {}

class LibraryHistoryInitialState extends LibraryHistoryState {}

class LibraryHistoryLoadingState extends LibraryHistoryState {}

class LibraryHistorySuccessState extends LibraryHistoryState {
  final List<LibraryHistory> libraryHistory;
   LibraryHistorySuccessState({  required this.libraryHistory});
}

class LibraryHistoryErrorState extends LibraryHistoryState {
  final String message;
  LibraryHistoryErrorState(this.message);
}