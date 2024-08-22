import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/main_screen/main_screen_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

class MainScreenCubit extends Cubit<MainScreenState>{
  final AuthRepo ? authRepo;
  MainScreenCubit(this.authRepo):super(MainScreenLoadingState());
  
Future <void> mainScreenLoggedInStatus () async{
  try{

   bool isLoggedIn= await SharedPref.getLoggedInStatus()  ?? false;
   isLoggedIn ? emit(MainScreenLoggedInStatusState(isLoggedIn: true)) : emit(MainScreenAddSchoolScreenState());
  
    
  }
  catch(e){
    emit(MainScreenErrorState("Failed to fetch data : $e"));

  }
}

}