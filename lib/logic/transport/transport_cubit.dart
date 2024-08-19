import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/transport/transport_state.dart';
import 'package:nguru/repo/api_calls.dart';

class TransportCubit extends Cubit <TransportState>{
  final AuthRepo ? authRepo;

  TransportCubit(this.authRepo):super(TransportInitState());

  Future<void> getTransportDetails() async {
    try{

      emit(TransportLoadingState());
      final result = await authRepo?.getTransportDetails();
      if(result!=null){
        if(result.responseCode=="200"){
          emit(TransportSuccessState(result));
        }else{
          emit(TransportErrorState(result.responseMessage??"Error occurred"));
        }
      }
    }
    catch(e){

      emit (TransportErrorState(e.toString()));
    }
  }
  
}