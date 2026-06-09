import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/language/locale_cubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Authentication/loginpage.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/screens/Profile/NotificationsettingsScreen.dart';
import 'package:grad_project/screens/Profile/changepassword.dart';
import 'package:grad_project/screens/Profile/profileinfo.dart';
import 'package:grad_project/services/Authservice.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String subtitle = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await AuthService().getUserData();
    if (mounted) {
      setState(() {
        if (user != null) {
          userName = user.fullName;
          subtitle = user.email;
        }
      });
    }
  }

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
          S.of(context).profile,
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
                          userName.isEmpty ? 'Loading...' : userName,
                          style: TextStyle(
                            fontSize: nameFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          subtitle,
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
            S.of(context).perscriptions,
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
            ontap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homepage(initialIndex: 4),
                ),
                (route) => false,
              );
            },
          ),
          _buildMenuItem(
            context,
            S.of(context).notificationssettings,
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),

          _buildMenuItem(
            context,
            S.of(context).securitysettings,
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Changepassword()),
              );
            },
          ),
          _buildMenuItem(
            context,
            S.of(context).languagesettings,
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
            ontap: () {
              _showLanguageSheet(context);
            },
          ),
          _buildMenuItem(
            context,
            S.of(context).logout,
            isDestructive: true,
            hideChevron: true,
            menuFontSize: menuFontSize,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding * 0.3,
            chevronSize: chevronSize,
            ontap: () {
              AuthService().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Loginpage()),
                (route) => false,
              );
            },
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
    required void Function() ontap,
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
          onTap: ontap,
        ),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }
}

void _showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).selectlanguage,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 14),
                _LangOption(
                  code: 'en',
                  name: S.of(context).english,
                  selected: locale.languageCode == 'en',
                ),
                _LangOption(
                  code: 'ar',
                  name: S.of(context).arabic,
                  selected: locale.languageCode == 'ar',
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class _LangOption extends StatelessWidget {
  final String code, name;
  final bool selected;

  const _LangOption({
    required this.code,
    required this.name,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEFF6FF) : Colors.transparent,
        border: Border.all(
          color: selected ? const Color(0xFFBFDBFE) : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          context.read<LocaleCubit>().setLocale(code);
          Navigator.pop(context);
        },
        title: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),

        trailing: selected
            ? const Icon(Icons.check, color: Color(0xFF2563EB), size: 20)
            : null,
      ),
    );
  }
}
