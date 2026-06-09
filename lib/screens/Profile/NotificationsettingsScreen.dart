import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool medicationReminder = true;
  bool emailNotification = true;
  bool smsNotification = false;
  bool pushNotification = true;
  bool securityNotification = true;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: sw * 0.06),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: sh * 0.035),

            // Title
            Text(
              S.of(context).notificationssettings,
              style: TextStyle(
                fontSize: sw * 0.065,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: Colors.black,
              ),
            ),
            SizedBox(height: sh * 0.006),

            // Subtitle
            Text(
              S.of(context).changenotificationsettings,
              style: TextStyle(
                fontSize: sw * 0.035,
                color: Colors.black,
                fontFamily: 'Cairo',
              ),
            ),

            SizedBox(height: sh * 0.04),

            // Notification items
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _NotificationTile(
                    icon: Icons.medication_outlined,
                    iconBgColor: const Color(0xFF2260FF),
                    label: S.of(context).medicationreminder,
                    value: medicationReminder,
                    onChanged: (v) => setState(() => medicationReminder = v),
                    sw: sw,
                    sh: sh,
                  ),
                  _divider(),
                  _NotificationTile(
                    icon: Icons.email_outlined,
                    iconBgColor: const Color(0xFF2260FF),
                    iconImageAsset:
                        'assets/images/Profile/logos_google-gmail.svg',
                    label: S.of(context).emailnotification,
                    value: emailNotification,
                    onChanged: (v) => setState(() => emailNotification = v),
                    sw: sw,
                    sh: sh,
                  ),
                  _divider(),
                  _NotificationTile(
                    icon: Icons.sms_outlined,
                    iconBgColor: const Color(0xFF2260FF),
                    label: S.of(context).smsnotification,
                    value: smsNotification,
                    onChanged: (v) => setState(() => smsNotification = v),
                    sw: sw,
                    sh: sh,
                  ),
                  _divider(),
                  _NotificationTile(
                    icon: Icons.phone_android_outlined,
                    iconBgColor: const Color(0xFF2260FF),
                    label: S.of(context).pushnotification,
                    value: pushNotification,
                    onChanged: (v) => setState(() => pushNotification = v),
                    sw: sw,
                    sh: sh,
                  ),
                  _divider(),
                  _NotificationTile(
                    icon: Icons.lock_outline,
                    iconBgColor: const Color(0xFF2260FF),
                    label: S.of(context).securitynotification,
                    value: securityNotification,
                    onChanged: (v) => setState(() => securityNotification = v),
                    sw: sw,
                    sh: sh,
                  ),
                  _divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(height: 1, thickness: 1, color: Colors.black);
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String? iconImageAsset;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final double sw;
  final double sh;

  const _NotificationTile({
    required this.icon,
    required this.iconBgColor,
    this.iconImageAsset,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) {
    final double iconContainerSize = sw * 0.11;
    final double iconSize = sw * 0.045;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: sh * 0.012),
      child: Row(
        children: [
          // Icon circle
          Container(
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: iconImageAsset != null
                  ? SvgPicture.asset(
                      iconImageAsset!,
                      width: iconSize,
                      height: iconSize,
                    )
                  : Icon(icon, color: Colors.white, size: iconSize),
            ),
          ),

          SizedBox(width: sw * 0.04),

          // Label
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: sw * 0.041,
                fontWeight: FontWeight.w500,
                fontFamily: 'Cairo',
                color: Colors.black87,
              ),
            ),
          ),

          // Custom styled Switch
          Transform.scale(
            scale: sw * 0.003,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF2260FF),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade400,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}
