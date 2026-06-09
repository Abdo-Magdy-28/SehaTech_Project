import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/screens/chatbotScreen.dart';
import 'package:grad_project/screens/Scanner/scanscreen.dart';
import 'package:grad_project/screens/prescriptions/all_prescriptions.dart';
import 'package:grad_project/screens/searchscreen.dart';
import 'package:grad_project/widgets/homepage/homepagewidget.dart';
import 'package:grad_project/generated/l10n.dart';

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
            label: S.of(context).prescriptions,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
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
