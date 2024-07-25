import 'package:nguru/models/contact_us_model.dart';

abstract class ContactUsState {}

class ContactUsInitialState extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {
  final ContactUs contactUs;
   ContactUsSuccessState({  required this.contactUs});
}

class ContactUsErrorState extends ContactUsState {
  final String message;
  ContactUsErrorState(this.message);
}