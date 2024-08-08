
import 'package:nguru/models/library_book_search_model.dart';
abstract class LibrarySearchBookState {}

class LibrarySearchBookInitialState extends LibrarySearchBookState {}

class LibrarySearchBookLoadingState extends LibrarySearchBookState {}

class LibrarySearchBookSuccessState extends LibrarySearchBookState {
  final List<LibrarySearch> librarySearch;
   LibrarySearchBookSuccessState({  required this.librarySearch});
}

class LibrarySearchBookErrorState extends LibrarySearchBookState {
  final String message;
  LibrarySearchBookErrorState(this.message);
}