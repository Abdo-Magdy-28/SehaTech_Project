import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/widgets/chatbot%20page/chatsuggestedbuttons.dart';
import 'package:grad_project/widgets/chatbot%20page/customchatbotappbar.dart';

class Chatbotwidget extends StatefulWidget {
  const Chatbotwidget({super.key});

  @override
  State<Chatbotwidget> createState() => _ChatbotwidgetState();
}

class _ChatbotwidgetState extends State<Chatbotwidget> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),

          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
            SliverToBoxAdapter(child: Customchatbotappbar()),
            SliverToBoxAdapter(
              child: SizedBox(width: devwidth, child: Divider(thickness: 1)),
            ),
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.05)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: devheight * 0.2,
                child: Image.asset("assets/images/chatbot/Frame 33.png"),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/chatbot/sparkles-sharp.svg"),
                  SizedBox(width: devwidth * 0.04),
                  Text(
                    "What Can I Help With?",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111111).withOpacity(0.6),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chatsuggestedbuttons(func: () {}, name: "Diagnoses"),
                  SizedBox(width: devheight * 0.01),
                  Chatsuggestedbuttons(func: () {}, name: "Drug Price"),
                  SizedBox(width: devheight * 0.01),
                  Chatsuggestedbuttons(func: () {}, name: "Active Ingridiant"),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chatsuggestedbuttons(func: () {}, name: "Disease symptoms"),
                  SizedBox(width: devheight * 0.01),
                  Chatsuggestedbuttons(func: () {}, name: "Chronic diseases"),
                  SizedBox(width: devheight * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
