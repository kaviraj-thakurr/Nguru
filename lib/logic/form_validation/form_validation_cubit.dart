import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Define Form Validation State
class FormValidationState extends Equatable {
  final bool autoValidateSchoolName;
  final bool autoValidateSubdomain;
  final bool autoValidateUserName;

  const FormValidationState({
    this.autoValidateSchoolName = false,
    this.autoValidateSubdomain = false,
    this.autoValidateUserName = false,
  });

  FormValidationState copyWith({
    bool? autoValidateSchoolName,
    bool? autoValidateSubdomain,
    bool?autoValidateUserName
  }) {
    return FormValidationState(
      autoValidateSchoolName: autoValidateSchoolName ?? this.autoValidateSchoolName,
      autoValidateSubdomain: autoValidateSubdomain ?? this.autoValidateSubdomain,
      autoValidateUserName: autoValidateUserName?? this.autoValidateUserName
    );
  }

  @override
  List<Object?> get props => [autoValidateSchoolName, autoValidateSubdomain];
}


class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(const FormValidationState());

  void validateSchoolName(String value) {
    emit(state.copyWith(autoValidateSchoolName: value.isNotEmpty));
  }

  void validateSubdomain(String value) {
    emit(state.copyWith(autoValidateSubdomain: value.isNotEmpty));
  }


  void validateUserName(String value) {
    emit(state.copyWith(autoValidateUserName: value.isNotEmpty));
  }
}
