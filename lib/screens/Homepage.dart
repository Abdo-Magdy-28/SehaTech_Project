import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/screens/chatbotScreen.dart';
import 'package:grad_project/screens/Scanner/scanscreen.dart';
import 'package:grad_project/screens/prescriptions/All_Prescriptions.dart';
import 'package:grad_project/screens/searchscreen.dart';
import 'package:grad_project/widgets/homepage/homepagewidget.dart';

class Homepage extends StatefulWidget {
  final int initialIndex;
  const Homepage({super.key, this.initialIndex = 0});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.white,
        color: Color(0xff1555d8),
        items: [
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/home-2.svg'),
            label: _selectedIndex == 0 ? 'Home' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/mingcute_scan-line.svg'),
            label: _selectedIndex == 1 ? 'Scan' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/Frame 48095567.svg'),
            label: _selectedIndex == 2 ? 'Chatbot' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/search.svg'),
            label: _selectedIndex == 3 ? 'Search' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/reports.svg'),
            label: _selectedIndex == 4 ? 'Preciptions' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),

      body: _selectedIndex == 0
          ? Homepagewidget()
          : _selectedIndex == 1
          ? Scanscreen()
          : _selectedIndex == 2
          ? ChatBotScreen()
          : _selectedIndex == 3
          ? Searchscreen()
          : AllPrescriptions(),
    );
  }
}
