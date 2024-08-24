import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/library/reserve_book/reserve_book_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ReserveBookCubit extends Cubit<ReserveBookState> {
  final AuthRepo? authRepo;

  ReserveBookCubit(this.authRepo) : super(ReserveBookInitialState());

  Future<void> reserveBook(int? bookID,int? accessionNo,int? issueReturnId) async {
    try {
      emit(ReserveBookLoadingState());
      final result = await authRepo?.reserveBook(bookID,accessionNo,issueReturnId);
      if (result != null) {
        if (result["responseCode"] == "200") {
          emit(ReserveBookSuccessState(reserveData: result["responseMessage"]));
          log("response of reserving a book $result");
        } else {
          emit(ReserveBookErrorState(result["responseMessage"]));
        }
      }
    } catch (e) {
      emit(ReserveBookErrorState(e.toString()));
    }
  }
}
