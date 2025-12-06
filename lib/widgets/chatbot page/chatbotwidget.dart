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
    final _SearchController = TextEditingController();
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
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.04)),
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
            SliverToBoxAdapter(child: SizedBox(height: devheight * 0.12)),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -3),
                    ),
                  ],
                  border: Border(
                    top: BorderSide(color: Colors.blue.shade200, width: 2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ask Ai Assistant Any Thing You need",
                          style: TextStyle(fontSize: 12, fontFamily: 'Cairo'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "View Your History",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cairo',
                              color: Color(0xff0D61EC),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: GestureDetector(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ask anything',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Color(0xFF0066FF),
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
