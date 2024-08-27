
abstract class SaveMessageSubjectState{}
class SaveMessageSubjectInitState extends SaveMessageSubjectState {}

class SaveMessageSubjectLoadingState extends SaveMessageSubjectState{}

class SaveMessageSubjectSuccessState extends SaveMessageSubjectState{
  final String saveMessageSubjectModel;
  SaveMessageSubjectSuccessState(this.saveMessageSubjectModel);
}

class SaveMessageSubjectErrorState extends SaveMessageSubjectState{
  final String message;
  SaveMessageSubjectErrorState(this.message);
}