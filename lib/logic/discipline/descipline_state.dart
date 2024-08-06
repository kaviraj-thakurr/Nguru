import 'package:nguru/models/contact_us_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/models/discipline_model/discipline_model.dart';
import 'package:nguru/models/gallery/gallery_model.dart';

abstract class DisciplineState {}

class DisciplineInitialState extends DisciplineState {}

class DisciplineLoadingState extends DisciplineState {}

class DisciplineSuccessState extends DisciplineState {
  final List<DisciplineList> disciplineList;
   DisciplineSuccessState({  required this.disciplineList});
}

class DisciplineFilteredState extends DisciplineState {
  final List<DisciplineList> filteredList;
  DisciplineFilteredState({required this.filteredList});
}


class DisciplineErrorState extends DisciplineState {
  final String message;
  DisciplineErrorState(this.message);
}