import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/circular/circular_detail/circular_detail_state.dart';

import 'package:nguru/repo/api_calls.dart';

class CircularDetailsCubit extends Cubit<CircularDetailState> {
  final AuthRepo? authRepo;

  CircularDetailsCubit(this.authRepo) : super(CircularDetailInitialState());

  Future<void> getCurrentCircularDetails({int? circularID,String?circularNo}) async {
    try {
      emit(CircularDetailLoadingState());
      final result = await authRepo?.getCircularDetails(circularID: circularID,circularNo:circularNo );
      if (result != null) {
        if (result.responseCode == "200") {
          emit(CircularDetailSuccessState(
              circularDetailList: result.circularList ?? []));
        } else {
          emit(CircularDetailErrorState(
              result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(CircularDetailErrorState(e.toString()));
    }
  }
}
