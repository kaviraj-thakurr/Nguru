import 'package:nguru/models/contact_us_model.dart';
import 'package:nguru/models/gallery/gallery_model.dart';

abstract class GalleryPhotosState {}

class GalleryPhotosInitialState extends GalleryPhotosState {}

class GalleryPhotosLoadingState extends GalleryPhotosState {}

class GalleryPhotosSuccessState extends GalleryPhotosState {
  final GalleryPhotosModel galleryPhotos;
   GalleryPhotosSuccessState({  required this.galleryPhotos});
}

class GalleryPhotosErrorState extends GalleryPhotosState {
  final String message;
  GalleryPhotosErrorState(this.message);
}