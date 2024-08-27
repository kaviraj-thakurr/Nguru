
abstract class ReserveBookState {}

class ReserveBookInitialState extends ReserveBookState {}

class ReserveBookLoadingState extends ReserveBookState {}

class ReserveBookSuccessState extends ReserveBookState {
  final dynamic reserveData;
   ReserveBookSuccessState({  required this.reserveData});
}

class ReserveBookErrorState extends ReserveBookState {
  final dynamic message;
  ReserveBookErrorState(this.message);
}