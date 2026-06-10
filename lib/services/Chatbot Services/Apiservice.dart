import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';
import 'package:grad_project/services/Chatbot%20Services/ChatService.dart';
import 'package:grad_project/services/Chatbot%20Services/ChatHistoryService.dart';
import 'dart:io';
import 'package:grad_project/services/Authservice.dart';

class ChatApiService implements ChatService {
  String? _threadId;
  String _summary = "No medical history.";

  static const String baseUrl =
      'https://8080-dep-01kp3cxxfzs0chgwd41w54zmem-d.cloudspaces.litng.ai';
  static const String apiKey = 'd1414a76-13c4-4267-9b96-12b0b62425f5';

  final Set<http.Client> _activeClients = {};
  final ChatHistoryService _historyService = ChatHistoryService();

  ChatApiService();

  @override
  Future<void> sendMessage(
    String message,
    ChatCubit cubit, {
    File? image,
  }) async {
    AuthService authService = AuthService();
    String userid = await authService.getUserId() ?? 'unknown_user';
    _threadId ??= _generateThreadId();

    final client = http.Client();
    _activeClients.add(client);

    try {
      final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/chat'));

      request.headers['Authorization'] = 'Bearer $apiKey';
      request.fields['query'] = message;
      request.fields['thread_id'] = _threadId!;
      request.fields['summary'] = _summary;
      request.fields['user_id'] = '${userid}_${_threadId!}';

      if (image != null) {
        final imageStream = http.ByteStream(image.openRead());
        final imageLength = await image.length();
        final multipartFile = http.MultipartFile(
          'image',
          imageStream,
          imageLength,
          filename: image.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      final streamedResponse = await client.send(request);

      if (streamedResponse.statusCode == 200) {
        String fullResponse = '';
        bool finalized = false; // ← guard to call finalize only once

        await for (var value in streamedResponse.stream.transform(
          utf8.decoder,
        )) {
          if (cubit.isClosed) break;

          final lines = value.split('\n');
          for (var line in lines) {
            if (line.trim().isEmpty) continue;

            try {
              final jsonData = jsonDecode(line);
              final msgType = jsonData['type'];

              switch (msgType) {
                case 'status':
                  final statusMsg = jsonData['content'] ?? '';
                  if (!cubit.isClosed) cubit.updateBotMessageStatus(statusMsg);
                  break;

                case 'token':
                  final content = jsonData['content'] ?? '';
                  fullResponse += content;
                  if (!cubit.isClosed)
                    cubit.updateBotMessageContent(fullResponse);
                  break;

                case 'final':
                  _summary = jsonData['summary'] ?? _summary;
                  if (!cubit.isClosed && !finalized) {
                    finalized = true;
                    cubit.finalizeBotMessage(fullResponse);
                  }
                  break;
              }
            } catch (e) {
              print('Error parsing JSON line: $e');
              continue;
            }
          }
        }

        print(
          'DEBUG stream ended. fullResponse length: ${fullResponse.length}',
        );
        print('DEBUG finalized: $finalized');

        // ── Finalize if the 'final' event never arrived ──────────────────
        if (!finalized && fullResponse.isNotEmpty && !cubit.isClosed) {
          cubit.finalizeBotMessage(fullResponse);
        }

        // ── Persist to backend history ────────────────────────────────────
        if (fullResponse.isNotEmpty && !cubit.isClosed) {
          print('DEBUG: saving message, length=${fullResponse.length}');
          try {
            final savedChatId = await _historyService.saveMessage(
              prompt: message,
              aiReply: fullResponse,
              chatId: cubit.currentChatId, // null = create new chat
            );
            print('DEBUG: savedChatId=$savedChatId');
            if (savedChatId != null && !cubit.isClosed) {
              cubit.currentChatId = savedChatId;
            }
          } catch (e) {
            print('History save error (non-fatal): $e');
          }
        }
        // ──────────────────────────────────────────────────────────────────
      } else {
        final errorBody = await streamedResponse.stream.bytesToString();
        if (!cubit.isClosed) {
          cubit.addBotMessage(
            'خطأ في الاتصال بالسيرفر: ${streamedResponse.statusCode}\n$errorBody',
          );
        }
      }
    } catch (e) {
      if (!cubit.isClosed) {
        cubit.addBotMessage(
          'فشل الاتصال بالسيرفر. تأكد من اتصالك بالإنترنت وحاول مرة أخرى.\nالخطأ: $e',
        );
      }
    } finally {
      _activeClients.remove(client);
      client.close();
    }
  }

  String _generateThreadId() {
    return 'thread_${DateTime.now().millisecondsSinceEpoch}';
  }

  void resetConversation() {
    _threadId = null;
    _summary = "No medical history.";
  }

  void seedSummary(String summary) {
    _summary = summary;
  }

  void cancelAllRequests() {
    for (var client in _activeClients) {
      client.close();
    }
    _activeClients.clear();
  }
}
