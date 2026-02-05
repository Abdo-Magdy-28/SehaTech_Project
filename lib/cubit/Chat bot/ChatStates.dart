import 'package:grad_project/models/Chatbot%20Models/chatmodel.dart';

class ChatState {
  final List<ChatMessage> messages;

  const ChatState({required this.messages});

  ChatState copyWith({List<ChatMessage>? messages}) {
    return ChatState(messages: messages ?? this.messages);
  }
}
