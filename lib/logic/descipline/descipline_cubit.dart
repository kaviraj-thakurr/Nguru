import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/descipline/descipline_state.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/repo/signin_apiCalls/api_calls.dart';

class DisciplineCubit extends Cubit<DisciplineState> {
  final AuthRepo? authRepo;

  DisciplineCubit(this.authRepo) : super(DisciplineLoadingState());

  Future<void> getDiscipline() async {
    try {
      emit(DisciplineLoadingState());
      final result = await authRepo?.getCurrentDicipline();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(DisciplineSuccessState(
              disciplineList: result.disciplineList ?? []));
        } else {
          emit(DisciplineErrorState(result.responseMessage ?? "Error occured"));
        }
        
      }
    } catch (e) {
      emit(DisciplineErrorState(e.toString()));
    }
  }
}
