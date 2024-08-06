import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/circular/circular_state.dart';
import 'package:nguru/logic/discipline/descipline_state.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/repo/api_calls.dart';

class CircularCubit extends Cubit<CircularState> {
  final AuthRepo? authRepo;

  CircularCubit(this.authRepo) : super(CircularLoadingState());

  Future<void> getCircular() async {
    try {
      emit(CircularLoadingState());
      final result = await authRepo?.getCurrentCircular();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(CircularSuccessState(
              circularList: result.circularList ?? []));
        } else {
          emit(CircularErrorState(result.responseMessage ?? "Error occured"));
        }
      //  log("${result.circularList?.first.toString()}");
      }
    } catch (e) {
      emit(CircularErrorState(e.toString()));
    }
  }
}
