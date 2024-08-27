import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/create_communication/save_message_subject_state.dart';
import 'package:nguru/repo/api_calls.dart';

class SaveMessageSubjectCubit  extends Cubit<SaveMessageSubjectState>{
  final AuthRepo ? authRepo;
  SaveMessageSubjectCubit(this.authRepo):super(SaveMessageSubjectInitState());

  Future<void>getSaveMessageSubjectDetails(String subjectName,int messageTypeId ) async{
    try{
      emit(SaveMessageSubjectLoadingState());
      final result = await authRepo?.saveMessageSubject(subjectName,messageTypeId);
      if(result != null){
        if(result["responseCode"]== "200"){
          emit (SaveMessageSubjectSuccessState(result["responseMessage"] ?? ""));
        }else{
          emit(SaveMessageSubjectErrorState(result["responseMessage"]??"Error occurred"));
        }
      }
    }
    catch(e){
      emit(SaveMessageSubjectErrorState(e.toString()));

    }

  }

  
}