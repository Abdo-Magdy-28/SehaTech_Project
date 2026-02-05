class ChatMessage {
  final String text;
  final bool isUser;
  final bool isLoading;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.isLoading = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    bool? isLoading,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      isLoading: isLoading ?? this.isLoading,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
