import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/setting_screen/setting_screen_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

class SettingScreenCubit extends Cubit<SettingScreenState> {
  final AuthRepo? authRepo;

  SettingScreenCubit(this.authRepo) : super(SettingScreenInitialState());


     // initiating values
  Future<void> initiatingValues() async{
    bool toggleValue=  await SharedPref.getNotificationToggle() ??false;
    log("the shared pref value of notification toggle is $toggleValue");
      emit(SettingScreenSuccessState(toggleState: toggleValue));
    
  }

     // Toggle isUserActive boolean in the state
  Future<void> togglePushNotification() async{
      final currentState = state as SettingScreenSuccessState;
      emit(currentState.copyWith(toggleState: !currentState.toggleState));
  }
}
