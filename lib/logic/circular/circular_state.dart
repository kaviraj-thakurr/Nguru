import 'package:nguru/models/circular_model/circular_model.dart';
import 'package:nguru/models/contact_us_model.dart';
import 'package:nguru/models/gallery/gallery_model.dart';

abstract class CircularState {}

class CircularInitialState extends CircularState {}

class CircularLoadingState extends CircularState {}

class CircularSuccessState extends CircularState {
  final List<CircularList> circularList;
   CircularSuccessState({  required this.circularList});
}

class CircularErrorState extends CircularState {
  final String message;
  CircularErrorState(this.message);
}