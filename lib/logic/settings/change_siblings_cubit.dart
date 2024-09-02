import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/settings/change_siblings_state.dart';
import 'package:nguru/repo/api_calls.dart';

class SiblingListCubit extends Cubit<SiblingListState>{
  final AuthRepo authRepo;

  SiblingListCubit (this.authRepo):super (SiblingListInitState());

  Future <void> getSiblingsList()async{
    try{
      emit (SiblingListLoadingState());
      final result = await authRepo.getSiblingsList();

      if(result !=null){
        if(result.responseCode == "200"){
          emit (SiblingListSuccessState(result));
        }else{
          emit (SiblingListErrorState(result.responseCode??"Error"));
        }
      }

    }
    catch(e){

    }
  }
  
}