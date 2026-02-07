import 'dart:io';

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isLoading;
  final DateTime timestamp;
  final File? image;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.isLoading = false,
    required this.timestamp,
    this.image,
  });

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    bool? isLoading,
    DateTime? timestamp,
    File? image,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      isLoading: isLoading ?? this.isLoading,
      timestamp: timestamp ?? this.timestamp,
      image: image ?? this.image,
    );
  }
}
