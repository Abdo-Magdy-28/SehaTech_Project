import 'package:flutter/material.dart';
import 'package:grad_project/screens/profileinfo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final horizontalPadding = screenWidth * 0.04;
    final verticalPadding = screenHeight * 0.02;
    final titleFontSize = screenWidth * 0.045;
    final nameFontSize = screenWidth * 0.04;
    final subTextFontSize = screenWidth * 0.033;
    final menuFontSize = screenWidth * 0.038;
    final avatarRadius = screenWidth * 0.07;
    final avatarIconSize = screenWidth * 0.09;
    final chevronSize = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: screenWidth * 0.06,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xff111111)),
        ),
      ),
      body: ListView(
        children: [
          // Profile Info Section
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profileinfo()),
              );
            },
            child: Container(
              color: const Color(0xFFF3F4F6),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: const Color(0xFF1D4ED8),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: avatarIconSize,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Youssef Mostafa',
                          style: TextStyle(
                            fontSize: nameFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          '22 y.o. (02 Jul 2004)',
                          style: TextStyle(
                            fontSize: subTextFontSize,
                            color: const Color(0xff5B5F5F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[500],
                    size: chevronSize,
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),

          // Menu Items
          _buildMenuItem(
            context,
            'Perceptions',
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
          _buildMenuItem(
            context,
            'Notification settings',
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
          _buildMenuItem(
            context,
            'Health Matrix',
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
          _buildMenuItem(
            context,
            'Payment settings',
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
          _buildMenuItem(
            context,
            'Change email',
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
          _buildMenuItem(
            context,
            'Security settings',
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
          _buildMenuItem(
            context,
            'Log out',
            isDestructive: true,
            hideChevron: true,
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title, {
    bool isDestructive = false,
    bool hideChevron = false,
    required double menuFontSize,
    required double horizontalPadding,
    required double verticalPadding,
    required double chevronSize,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: menuFontSize,
              color: isDestructive ? const Color(0xFFDC2626) : Colors.black87,
              fontWeight: isDestructive ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          trailing: hideChevron
              ? null
              : Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: chevronSize,
                ),
          onTap: () {
            // TODO: Implement menu action
          },
        ),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }
}
