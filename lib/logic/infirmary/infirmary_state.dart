
import 'package:nguru/models/infirmary_model.dart';
import 'package:nguru/models/library_history_model.dart';
import 'package:nguru/models/library_issued_book_model.dart';

abstract class InfirmaryState {}

class InfirmaryInitialState extends InfirmaryState {}

class InfirmaryLoadingState extends InfirmaryState {}

class InfirmarySuccessState extends InfirmaryState {
  final List<IllnessList> infirmary;
   InfirmarySuccessState({  required this.infirmary});
}

class InfirmaryErrorState extends InfirmaryState {
  final String message;
  InfirmaryErrorState(this.message);
}