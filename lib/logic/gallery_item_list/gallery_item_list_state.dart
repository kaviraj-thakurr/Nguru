import 'package:nguru/models/gallery/get_gallery_list_model.dart';

abstract class GalleryItemListState {}

class GalleryItemListInitialState extends GalleryItemListState {}

class GalleryItemListLoadingState extends GalleryItemListState {}

class GalleryItemListSuccessState extends GalleryItemListState {
  final GalleryItemListModel galleryItemList;
   GalleryItemListSuccessState({  required this.galleryItemList});
}

class GalleryItemListErrorState extends GalleryItemListState {
  final String message;
  GalleryItemListErrorState(this.message);
}