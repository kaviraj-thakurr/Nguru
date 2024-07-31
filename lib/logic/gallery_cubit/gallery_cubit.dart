import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/gallery_cubit/gallery_state.dart';
import 'package:nguru/repo/api_calls.dart';

class GalleryPhotosCubit extends Cubit<GalleryPhotosState> {
  final AuthRepo?  authRepo;


  GalleryPhotosCubit(this.authRepo) : super(GalleryPhotosLoadingState());


  Future<void> getGalleryPhotos() async {
    try {
      emit(GalleryPhotosLoadingState());
      final result = await authRepo?.getGalleryPhotoList();
      if (result != null) {
        if(result.responseCode == "200" ){
          emit(GalleryPhotosSuccessState(galleryPhotos: result));
        }else {
emit(GalleryPhotosErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.photogalleryList}");
        
      }
    } catch (e) {
      emit(GalleryPhotosErrorState(e.toString()));
    }
  }
}



