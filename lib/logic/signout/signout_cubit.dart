
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/signout/signout_state.dart';
import 'package:nguru/repo/api_calls.dart';


class SignoutCubit extends Cubit<SignoutState>{
  final AuthRepo ? authRepo;
  SignoutCubit(this.authRepo):super(SignoutLoadingState());
  
Future <void> signout () async{
  try{
    emit(SignoutLoadingState());
    final result = await authRepo?.logOut();
    if(result != null){
      if(result["responseCode"] == "200"){
        emit(SignoutSuccessState(
          responseMessage: result["responseMessage"]
        ));
      }else{
        emit(SignoutErrorState(result["responseMessage"]??"Error occured"));
      }
    }
  }
  catch(e){
    emit(SignoutErrorState("Failed to fetch data : $e"));

  }
}

}