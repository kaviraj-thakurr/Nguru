
import 'package:nguru/models/library_issued_book_model.dart';

abstract class LibraryIssueBookState {}

class LibraryIssueBookInitialState extends LibraryIssueBookState {}

class LibraryIssueBookLoadingState extends LibraryIssueBookState {}

class LibraryIssueBookSuccessState extends LibraryIssueBookState {
  final List<LibraryIssued> libraryIssued;
   LibraryIssueBookSuccessState({  required this.libraryIssued});
}

class LibraryIssueBookErrorState extends LibraryIssueBookState {
  final String message;
  LibraryIssueBookErrorState(this.message);
}