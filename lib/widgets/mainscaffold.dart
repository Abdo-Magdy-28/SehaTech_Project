import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/generated/l10n.dart';
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
        color: const Color(0xff1555d8),
        buttonBackgroundColor: const Color(0xff1555d8),
        items: [
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/home-2.svg'),
            label: S.of(context).home,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/mingcute_scan-line.svg'),
            label: S.of(context).scan,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/Frame 48095567.svg'),
            label: S.of(context).chatbot,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/search.svg'),
            label: S.of(context).search,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/reports.svg'),
            label: S.of(context).perscriptions,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: widget.child,
    );
  }
}
