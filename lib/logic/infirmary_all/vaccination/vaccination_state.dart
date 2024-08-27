
import 'package:nguru/models/Vaccination_model.dart';

abstract class VaccinationState {}

class VaccinationInitialState extends VaccinationState {}

class VaccinationLoadingState extends VaccinationState {}

class VaccinationSuccessState extends VaccinationState {
   List<VaccinationList> vaccination;
   VaccinationSuccessState({  required this.vaccination});
}

class VaccinationErrorState extends VaccinationState {
  final String message;
  VaccinationErrorState(this.message);
}