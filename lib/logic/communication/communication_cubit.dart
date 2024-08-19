import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/communication/communication_state.dart';
import 'package:nguru/repo/api_calls.dart';

class CommunicationCubit  extends Cubit<CommunicationState>{
  final AuthRepo ? authRepo;
  CommunicationCubit(this.authRepo):super(CommunicationInitState());

  Future<void>getCommunicationDetails() async{
    try{
      emit(CommunicationLoadingState());
      final result = await authRepo?.getCommunicationDetails();
      if(result != null){
        if(result.responseCode== "200"){
          emit (CommunicationSuccessState(result));
        }else{
          emit(CommunicationErrorState(result.responseMessage??"Error occurred"));
        }
      }
    }
    catch(e){
      emit(CommunicationErrorState(e.toString()));

    }

  }

  
}