import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/setting_screen/setting_screen_state.dart';
import 'package:nguru/repo/api_calls.dart';

class SettingScreenCubit extends Cubit<SettingScreenState> {
  final AuthRepo? authRepo;

  SettingScreenCubit(this.authRepo) : super(SettingScreenInitialState());


     // initiating values
  void initiatingValues() {
      emit(SettingScreenSuccessState(toggleState: false));
    
  }

     // Toggle isUserActive boolean in the state
  Future<void> togglePushNotification() async{
      final currentState = state as SettingScreenSuccessState;
      emit(currentState.copyWith(toggleState: !currentState.toggleState));
  }
}
