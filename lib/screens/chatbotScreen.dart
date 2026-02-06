import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Chat%20bot/ChatCubit.dart';
import 'package:grad_project/cubit/Chat%20bot/ChatStates.dart';
import 'package:grad_project/services/Chatbot%20Services/DemoChatBot.dart';
import 'package:grad_project/widgets/chatbot%20page/BubbleWidget.dart';
import 'package:grad_project/widgets/chatbot%20page/chatinputwidget.dart';
import 'package:grad_project/widgets/chatbot%20page/chatsuggestedbuttons.dart';
import 'package:grad_project/widgets/chatbot%20page/customchatbotappbar.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatbotwidgetState();
}

class _ChatbotwidgetState extends State<ChatBotScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSuggestedButton(
    ChatCubit cubit,
    String buttonText,
    Function(ChatCubit) introFunction,
  ) {
    cubit.addUserMessage(buttonText);

    Future.delayed(const Duration(milliseconds: 300), () {
      introFunction(cubit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => ChatCubit(ChatDemoService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const Customchatbotappbar(),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            final cubit = context.read<ChatCubit>();
            final hasMessages = state.messages.isNotEmpty;

            return Column(
              children: [
                SizedBox(width: devwidth, child: const Divider(thickness: 1)),

                Expanded(
                  child: hasMessages
                      ? ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.messages.length,
                          itemBuilder: (_, i) =>
                              ChatBubble(message: state.messages[i]),
                        )
                      : _buildEmptyState(context, devheight, devwidth, cubit),
                ),

                Chatinputwidget(
                  controller: _controller,
                  onSend: () {
                    if (_controller.text.trim().isNotEmpty) {
                      cubit.sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    double devheight,
    double devwidth,
    ChatCubit cubit,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: devheight * 0.05),
          SizedBox(
            height: devheight * 0.2,
            child: Image.asset("assets/images/chatbot/Frame 33.png"),
          ),
          SizedBox(height: devheight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/chatbot/sparkles-sharp.svg"),
              SizedBox(width: devwidth * 0.04),
              Text(
                "What Can I Help With?",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff111111).withOpacity(0.6),
                  fontSize: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: devheight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chatsuggestedbuttons(
                func: () {
                  _handleSuggestedButton(
                    cubit,
                    "Diagnoses",
                    (c) => c.chatService.runDiagnosesIntro(c),
                  );
                },
                name: "Diagnoses",
              ),
              SizedBox(width: devwidth * 0.02),
              Chatsuggestedbuttons(
                func: () {
                  _handleSuggestedButton(
                    cubit,
                    "Drug Price",
                    (c) => c.chatService.runDrugPriceIntro(c),
                  );
                },
                name: "Drug Price",
              ),
              SizedBox(width: devwidth * 0.02),
              Chatsuggestedbuttons(
                func: () {
                  _handleSuggestedButton(
                    cubit,
                    "Active Ingredient",
                    (c) => c.chatService.runActiveIngredientIntro(c),
                  );
                },
                name: "Active Ingredient",
              ),
            ],
          ),
          SizedBox(height: devheight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chatsuggestedbuttons(
                func: () {
                  _handleSuggestedButton(
                    cubit,
                    "Disease symptoms",
                    (c) => c.chatService.runDiseaseSymptomsIntro(c),
                  );
                },
                name: "Disease symptoms",
              ),
              SizedBox(width: devwidth * 0.02),
              Chatsuggestedbuttons(
                func: () {
                  _handleSuggestedButton(
                    cubit,
                    "Chronic diseases",
                    (c) => c.chatService.runChronicDiseasesIntro(c),
                  );
                },
                name: "Chronic diseases",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
