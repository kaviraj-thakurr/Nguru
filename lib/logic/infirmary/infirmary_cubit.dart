import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/infirmary/infirmary_state.dart';
import 'package:nguru/logic/library/history/library_history_state.dart';
import 'package:nguru/repo/api_calls.dart';

class InfirmaryCubit extends Cubit<InfirmaryState> {
  final AuthRepo? authRepo;

  InfirmaryCubit(this.authRepo) : super(InfirmaryLoadingState());

  Future<void> getInfirmary() async {
    try {
      emit(InfirmaryLoadingState());
      final result = await authRepo?.getInfirmaryList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(InfirmarySuccessState(
              infirmary: result.illnessList ?? []));
        } else {
          emit(InfirmaryErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(InfirmaryErrorState(e.toString()));
    }
  }
}
