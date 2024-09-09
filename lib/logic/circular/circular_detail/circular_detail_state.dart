
import 'package:nguru/models/circularDetailsModel.dart';

abstract class CircularDetailState {}

class CircularDetailInitialState extends CircularDetailState {}

class CircularDetailLoadingState extends CircularDetailState {}

class CircularDetailSuccessState extends CircularDetailState {
   List<CircularList> circularDetailList;
   CircularDetailSuccessState({  required this.circularDetailList});
}




class CircularDetailErrorState extends CircularDetailState {
  final String message;
  CircularDetailErrorState(this.message);
}


