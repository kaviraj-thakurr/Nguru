
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/infirmary_all/vaccination/vaccination_state.dart';
import 'package:nguru/models/Vaccination_model.dart';
import 'package:nguru/repo/api_calls.dart';


class VaccinationCubit extends Cubit<VaccinationState> {
  final AuthRepo? authRepo;

  VaccinationCubit(this.authRepo) : super(VaccinationLoadingState());

  Future<void> getVaccination() async {
  try {
    emit(VaccinationLoadingState());
    final result = await authRepo?.getVaccinationList();
    if (result != null) {
      if (result.responseCode == "200") {
        // Cast the result to the expected type
        List<VaccinationList> vaccinationList = 
            (result.vaccinationList as List).cast<VaccinationList>();
        
        emit(VaccinationSuccessState(
              vaccination: vaccinationList));
      } else {
        emit(VaccinationErrorState(result.responseMessage ?? "Error occurred"));
      }
    }
  } catch (e) {
    emit(VaccinationErrorState(e.toString()));
  }
}
}
