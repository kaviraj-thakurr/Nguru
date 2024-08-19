import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/gallery_item_list/gallery_item_list_state.dart';
import 'package:nguru/repo/api_calls.dart';

class GalleryItemListCubit extends Cubit<GalleryItemListState> {
  final AuthRepo?  authRepo;


  GalleryItemListCubit(this.authRepo) : super(GalleryItemListLoadingState());


  Future<void> getGalleryItemList() async {
    try {
      emit(GalleryItemListLoadingState());
      final result = await authRepo?.getGalleryItemList();
      if (result != null) {
        if(result.responseCode == "200" ){
          emit(
            GalleryItemListSuccessState(galleryItemList: result));
        }else {
emit(GalleryItemListErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.galleryList}");
        
      }
    } catch (e) {
      emit(GalleryItemListErrorState(e.toString()));
    }
  }
}



