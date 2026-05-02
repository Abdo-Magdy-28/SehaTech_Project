import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/Homepage.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  const MainScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onTabTapped(int index) {
    if (index == _selectedIndex) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
    Future.microtask(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Homepage(initialIndex: index)),
      );
    });
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
        onTap: _onTabTapped,
      ),
      body: widget.child,
    );
  }
}
