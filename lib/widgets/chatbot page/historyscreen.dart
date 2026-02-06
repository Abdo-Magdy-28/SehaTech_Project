import 'package:flutter/material.dart';
import 'package:grad_project/models/Chatbot%20Models/chathistorymodel.dart';
import 'package:grad_project/widgets/chatbot%20page/historywidget.dart';

class Historyscreen extends StatelessWidget {
  Historyscreen({super.key});

  final List<Chathistorymodel> hismodel = [
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
    Chathistorymodel(
      headtitle: 'Disease sympotoms',
      secondtitle: 'Hello 👋 I\'m here to help you. Let\'s explore you..',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "All Chats",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            color: Color(0xff111111),
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'New chat',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: hismodel.length,
          itemBuilder: (context, i) {
            return Historywidget(model: hismodel[i]);
          },
        ),
      ),
    );
  }
}
