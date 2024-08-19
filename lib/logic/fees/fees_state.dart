import 'package:nguru/models/fees_model.dart';
import 'package:nguru/models/login_model.dart';

abstract class FeesState {}

class FeesInitState extends FeesState{}

class FeesLoadingState extends FeesState {}

class FeesSuccessState extends FeesState {
  final List<FeeList> totalFee;
 
  FeesSuccessState( this.totalFee);
}

class FeesErrorState extends FeesState {
  final String message;
 FeesErrorState(this.message);
}
