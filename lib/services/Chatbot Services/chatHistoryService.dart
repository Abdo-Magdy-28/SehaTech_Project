import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatHistoryItem {
  final String id;
  final String title;
  final DateTime updatedAt;

  ChatHistoryItem({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  factory ChatHistoryItem.fromJson(Map<String, dynamic> json) {
    return ChatHistoryItem(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Untitled Chat',
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class ChatMessageHistory {
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;

  ChatMessageHistory({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessageHistory.fromJson(Map<String, dynamic> json) {
    return ChatMessageHistory(
      role: json['role'] ?? 'user',
      content: json['content'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}

class ChatHistoryDetail {
  final String id;
  final String title;
  final List<ChatMessageHistory> messages;

  ChatHistoryDetail({
    required this.id,
    required this.title,
    required this.messages,
  });
}

class ChatHistoryService {
  static const String baseUrl = 'https://sehatech-backend-gilt.vercel.app';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Map<String, String> _authHeaders(String token) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  /// Save a message to backend — creates new chat or continues existing one
  /// Returns the chatId from the response
  Future<String?> saveMessage({
    required String prompt,
    required String aiReply,
    String? chatId,
  }) async {
    final token = await _getToken();
    if (token == null) return null;

    final body = <String, dynamic>{'prompt': prompt, 'aiReply': aiReply};
    if (chatId != null) {
      body['chatId'] = chatId;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat/message'),
        headers: _authHeaders(token),
        body: jsonEncode(body),
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['data']['chatId'] as String?;
      }
    } catch (e) {
      print('Error saving message: $e');
    }
    return null;
  }

  /// Get all chat history for the current user
  Future<List<ChatHistoryItem>> getAllChats() async {
    final token = await _getToken();
    print("TOKEN = $token");
    if (token == null) return [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/chat/history'),
        headers: _authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final chats = data['data']['chats'] as List<dynamic>;
        return chats.map((c) => ChatHistoryItem.fromJson(c)).toList();
      }
    } catch (e) {
      print('Error fetching chats: $e');
    }
    return [];
  }

  /// Get messages of a specific chat
  Future<ChatHistoryDetail?> getChatContent(String chatId) async {
    final token = await _getToken();
    if (token == null) return null;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/chat/history/$chatId'),
        headers: _authHeaders(token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final chat = data['data']['chat'];
        final messages = (chat['messages'] as List<dynamic>)
            .map((m) => ChatMessageHistory.fromJson(m))
            .toList();
        return ChatHistoryDetail(
          id: chat['_id'] ?? chatId,
          title: chat['title'] ?? 'Chat',
          messages: messages,
        );
      }
    } catch (e) {
      print('Error fetching chat content: $e');
    }
    return null;
  }

  /// Delete a chat by ID
  Future<bool> deleteChat(String chatId) async {
    final token = await _getToken();
    if (token == null) return false;

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/chat/history/$chatId'),
        headers: _authHeaders(token),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Error deleting chat: $e');
      return false;
    }
  }
}
