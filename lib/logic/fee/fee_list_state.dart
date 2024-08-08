

import 'package:nguru/models/get_fee_model.dart';

abstract class FeeListState {}

class FeeListInitialState extends FeeListState {}

class FeeListLoadingState extends FeeListState {}

class FeeListSuccessState extends FeeListState {
  final List<FeeList> feeListModel;
   FeeListSuccessState({  required this.feeListModel});
}

class FeeListErrorState extends FeeListState {
  final String message;
  FeeListErrorState(this.message);
}