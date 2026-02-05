import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';
import 'package:grad_project/services/Chatbot%20Services/ChatService.dart';

class ChatApiService implements ChatService {
  final String baseUrl;
  final String apiKey;

  ChatApiService({required this.baseUrl, required this.apiKey});

  @override
  Future<void> sendMessage(String message, ChatCubit cubit) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'message': message,
          'conversation_history': cubit.state.messages
              .where((m) => !m.isLoading)
              .map((m) => {'text': m.text, 'isUser': m.isUser})
              .toList(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        cubit.addBotMessage(data['response'] ?? 'No response');
      } else {
        cubit.addBotMessage('Sorry, I encountered an error. Please try again.');
      }
    } catch (e) {
      cubit.addBotMessage(
        'Connection error. Please check your internet and try again.',
      );
    }
  }

  @override
  void runDiseaseSymptomsIntro(ChatCubit cubit) {
    cubit.addBotMessage(
      "Hello 👋\n\n"
      "I'm here to help you. Let's explore your symptoms together.\n\n"
      "Describe Your Feeling Right Now!",
    );
  }

  @override
  void runDiagnosesIntro(ChatCubit cubit) {
    cubit.addBotMessage(
      "Hello! 👨‍⚕️\n\n"
      "I can help you understand possible diagnoses based on your symptoms.\n\n"
      "Please describe all your symptoms in detail.",
    );
  }

  @override
  void runDrugPriceIntro(ChatCubit cubit) {
    cubit.addBotMessage(
      "Hello! 💊\n\n"
      "I can help you check medication prices.\n\n"
      "What medication would you like to know the price for?",
    );
  }

  @override
  void runActiveIngredientIntro(ChatCubit cubit) {
    cubit.addBotMessage(
      "Hello! 🔬\n\n"
      "I can help you find information about active ingredients in medications.\n\n"
      "Which medication would you like to know about?",
    );
  }

  @override
  void runChronicDiseasesIntro(ChatCubit cubit) {
    cubit.addBotMessage(
      "Hello! 🏥\n\n"
      "I can provide information about chronic diseases and their management.\n\n"
      "Which chronic disease would you like to learn about?",
    );
  }
}
