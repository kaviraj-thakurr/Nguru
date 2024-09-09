

abstract class SettingScreenState {}

class SettingScreenInitialState extends SettingScreenState {}

class SettingScreenLoadingState extends SettingScreenState {}

class SettingScreenSuccessState extends SettingScreenState {
  final bool toggleState;
   SettingScreenSuccessState( { required  this.toggleState});


     // Implement the copyWith method
  SettingScreenSuccessState copyWith({
      final bool? toggleState,
  }) {
    return SettingScreenSuccessState(
      toggleState: toggleState ?? this.toggleState,
    );
  }
}

class SettingScreenErrorState extends SettingScreenState {
  final String message;
  SettingScreenErrorState(this.message);
}