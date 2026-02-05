import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Chat%20bot/ChatStates.dart';
import 'package:grad_project/models/Chatbot%20Models/chatmodel.dart';
import 'package:grad_project/services/Chatbot%20Services/ChatService.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;

  ChatCubit(this.chatService) : super(const ChatState(messages: []));

  void addUserMessage(String text) {
    final updatedMessages = [
      ChatMessage(text: text, isUser: true),
      ...state.messages,
    ];
    emit(state.copyWith(messages: updatedMessages));
  }

  void addBotMessage(String text) {
    final updatedMessages = [
      ChatMessage(text: text, isUser: false),
      ...state.messages,
    ];
    emit(state.copyWith(messages: updatedMessages));
  }

  void showTyping() {
    final updatedMessages = [
      ChatMessage(text: "Typing...", isUser: false, isLoading: true),
      ...state.messages,
    ];
    emit(state.copyWith(messages: updatedMessages));
  }

  void removeTyping() {
    final updatedMessages = state.messages.where((m) => !m.isLoading).toList();
    emit(state.copyWith(messages: updatedMessages));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    addUserMessage(text);
    showTyping();

    await chatService.sendMessage(text, this);

    removeTyping();
  }

  void clear() {
    emit(const ChatState(messages: []));
  }
}
