import 'package:nguru/models/transport_detail_model.dart';

abstract class TransportState{}
class TransportInitState extends TransportState{}

class TransportLoadingState extends TransportState{}

class TransportSuccessState extends TransportState{
final TransportDetails transportDetails;
TransportSuccessState(this.transportDetails);
}

class TransportErrorState extends TransportState {
  final String message;
  TransportErrorState(this.message);
}