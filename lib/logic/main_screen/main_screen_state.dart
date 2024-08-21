
abstract class MainScreenState{}

class MainScreenLoadingState extends MainScreenState {}

class MainScreenLoggedInStatusState extends MainScreenState {
  final bool? isLoggedIn;
 

  MainScreenLoggedInStatusState({
    this.isLoggedIn,
  
  });
}


class MainScreenAddSchoolScreenState extends MainScreenState {}

class MainScreenErrorState extends MainScreenState {
  final String message;
  
  MainScreenErrorState(this.message);
}




