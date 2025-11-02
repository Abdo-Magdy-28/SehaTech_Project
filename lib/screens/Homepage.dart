import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/widgets/categorysrow.dart';
import 'package:grad_project/widgets/chatbotslider.dart';
import 'package:grad_project/widgets/customappbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,

        // animationCurve: Easing.linear,
        onTap: (index) {
          print(index);
        },
        items: [
          Icon(Icons.home, color: Colors.white),

          Icon(Icons.qr_code_outlined, color: Colors.white),
        ],
        color: Color(0xff1555DA),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: devwidth * 0.9,
            child: ListView(
              children: [
                SizedBox(height: devheight * 0.02),
                Customappbar(),
                SizedBox(width: devwidth, child: Divider(thickness: 1)),
                SizedBox(height: devheight * 0.01),
                chatbotslider(devheight: devheight),
                SizedBox(height: devheight * 0.025),
                categorysrow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
