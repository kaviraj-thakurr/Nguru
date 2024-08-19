import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/forgot_password/forgot_password_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ForgetPassCubit extends Cubit<ForgetPasswordState> {
  final AuthRepo? authRepo;

  ForgetPassCubit(this.authRepo) : super(ForgetPassInitState());

  Future<void> forgotPassword(String userName) async {
    try {
      emit(ForgetPassLoadingState());
      final result = await authRepo?.forgotPassword(userName);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(ForgetPassSuccessState());
        } else {
          emit(ForgetPassErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(ForgetPassErrorState(e.toString()));
    }
  }
}
