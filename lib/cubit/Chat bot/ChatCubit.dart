import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Chat%20bot/ChatStates.dart';
import 'package:grad_project/models/Chatbot%20Models/chatmodel.dart';
import 'package:grad_project/services/Chatbot%20Services/ChatService.dart';
import 'dart:io';

class ChatCubit extends Cubit<ChatState> {
  final ChatService chatService;
  bool _isDisposed = false;

  ChatCubit(this.chatService) : super(const ChatState(messages: []));

  // Safe emit - يتحقق إن الـ Cubit لسه مش متقفل
  void _safeEmit(ChatState newState) {
    if (!_isDisposed && !isClosed) {
      emit(newState);
    }
  }

  void addUserMessage(String text, {File? image}) {
    if (_isDisposed) return;

    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
      image: image,
    );

    _safeEmit(state.copyWith(messages: [...state.messages, userMessage]));

    // Add loading placeholder for bot response
    addLoadingMessage();

    // Send message to API
    chatService.sendMessage(text, this, image: image);
  }

  void addBotMessage(String text) {
    if (_isDisposed) return;

    final botMessage = ChatMessage(
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
    );

    _safeEmit(state.copyWith(messages: [...state.messages, botMessage]));
  }

  void addLoadingMessage() {
    if (_isDisposed) return;

    final loadingMessage = ChatMessage(
      text: '...',
      isUser: false,
      isLoading: true,
      timestamp: DateTime.now(),
    );

    _safeEmit(state.copyWith(messages: [...state.messages, loadingMessage]));
  }

  void updateBotMessageStatus(String status) {
    if (_isDisposed) return;

    final messages = List<ChatMessage>.from(state.messages);

    // Find the last loading message and update it
    for (int i = messages.length - 1; i >= 0; i--) {
      if (messages[i].isLoading) {
        messages[i] = ChatMessage(
          text: '⚙️ $status',
          isUser: false,
          isLoading: true,
          timestamp: messages[i].timestamp,
        );
        _safeEmit(state.copyWith(messages: messages));
        break;
      }
    }
  }

  void updateBotMessageContent(String content) {
    if (_isDisposed) return;

    final messages = List<ChatMessage>.from(state.messages);

    // Find the last loading message and update with content
    for (int i = messages.length - 1; i >= 0; i--) {
      if (messages[i].isLoading) {
        messages[i] = ChatMessage(
          text: content,
          isUser: false,
          isLoading: true, // Still loading until final
          timestamp: messages[i].timestamp,
        );
        _safeEmit(state.copyWith(messages: messages));
        break;
      }
    }
  }

  void finalizeBotMessage(String finalContent) {
    if (_isDisposed) return;

    final messages = List<ChatMessage>.from(state.messages);

    // Find the last loading message and finalize it
    for (int i = messages.length - 1; i >= 0; i--) {
      if (messages[i].isLoading) {
        messages[i] = ChatMessage(
          text: finalContent,
          isUser: false,
          isLoading: false,
          timestamp: messages[i].timestamp,
        );
        _safeEmit(state.copyWith(messages: messages));
        break;
      }
    }
  }

  void clearMessages() {
    if (_isDisposed) return;
    _safeEmit(const ChatState(messages: []));
  }

  void dispose() {
    _isDisposed = true;
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    return super.close();
  }
}
