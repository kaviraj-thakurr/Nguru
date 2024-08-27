import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nguru/models/chatMessagesList.dart';
// Import your model
import 'package:nguru/repo/api_calls.dart';
 // Import your service

// State
class ChatState extends Equatable {
  final List<ListcommunicationMsgDetail> messages;
  final bool isLoading;
  final String? errorMessage;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ListcommunicationMsgDetail>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, errorMessage];
}


// Cubit
class ChatCubit extends Cubit<ChatState> {
  final AuthRepo authRepo;

  ChatCubit(this.authRepo) : super(const ChatState());

  Future<void> fetchMessages(int? appMessageID) async {
    emit(state.copyWith(isLoading: true));
    try {
      final ListCommunicationModel response = await authRepo.getCommunicationList(appMessageID);
      emit(state.copyWith(
        messages: response.listcommunicationMsgDetail ?? [],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
