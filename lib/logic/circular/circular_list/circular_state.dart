import 'package:nguru/models/circular_model/circular_model.dart';

abstract class CircularState {}

class CircularInitialState extends CircularState {}

class CircularLoadingState extends CircularState {}

class CircularSuccessState extends CircularState {
   List<CircularList> circularList;
   List<CircularList> storyCircularList;
   CircularSuccessState({  required this.circularList, required this.storyCircularList});
}


class CircularFilterState extends CircularState {
   List<CircularList> filterList;
   CircularFilterState({  required this.filterList});
}


class CircularErrorState extends CircularState {
  final String message;
  CircularErrorState(this.message);
}

class CircularFilteredState extends CircularState {
  final List<CircularList> filteredCircularList;

  CircularFilteredState({required this.filteredCircularList});
}
