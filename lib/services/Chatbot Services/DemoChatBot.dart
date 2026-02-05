import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';

import 'package:grad_project/services/Chatbot%20Services/ChatService.dart';

class ChatDemoService implements ChatService {
  @override
  Future<void> sendMessage(String message, ChatCubit cubit) async {
    await Future.delayed(const Duration(seconds: 2));

    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('headache') ||
        lowerMessage.contains('nausea') ||
        lowerMessage.contains('fever')) {
      cubit.addBotMessage(
        "These symptoms appear to be consistent with a severe cold. "
        "Let's proceed with further evaluation for a more accurate diagnosis.\n\n"
        "Please consult a healthcare professional for proper treatment.",
      );
    } else if (lowerMessage.contains('price') ||
        lowerMessage.contains('cost')) {
      cubit.addBotMessage(
        "I can help you check drug prices. Please provide the medication name.",
      );
    } else {
      cubit.addBotMessage(
        "Thank you for your message. Based on the information provided, "
        "I recommend consulting with a healthcare professional for accurate diagnosis and treatment.",
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
