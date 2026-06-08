import 'package:flutter/material.dart';
import 'package:grad_project/screens/homepage.dart';

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────

enum NotificationType {
  appointment,
  medicine,
  virtualVisit,
  prescription,
  reschedule,
  cardExpired,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime timestamp;
  final String? actionLabel;
  final int? actionNavIndex;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    this.actionLabel,
    this.actionNavIndex,
    this.isRead = false,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.appointment:
      case NotificationType.reschedule:
        return Icons.calendar_today_rounded;
      case NotificationType.medicine:
        return Icons.medication_rounded;
      case NotificationType.virtualVisit:
        return Icons.desktop_mac_rounded;
      case NotificationType.prescription:
        return Icons.local_pharmacy_rounded;
      case NotificationType.cardExpired:
        return Icons.credit_card_off_rounded;
    }
  }

  Color get iconForeground {
    switch (type) {
      case NotificationType.prescription:
        return const Color(0xFFF59E0B);
      case NotificationType.cardExpired:
        return const Color(0xFFEF4444);
      default:
        return Colors.white;
    }
  }

  Color get iconBackground {
    switch (type) {
      case NotificationType.prescription:
        return const Color(0xFFFEF3C7);
      case NotificationType.cardExpired:
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFF1555D8);
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    id: id,
    title: title,
    body: body,
    type: type,
    timestamp: timestamp,
    actionLabel: actionLabel,
    actionNavIndex: actionNavIndex,
    isRead: isRead ?? this.isRead,
  );
}

// ─────────────────────────────────────────────
//  MOCK DATA
// ─────────────────────────────────────────────

final List<NotificationModel> mockNotifications = [
  NotificationModel(
    id: '1',
    title: 'Your Visit Has Been Rescheduled',
    body: 'Your visit to Dr. Smith is rescheduled to 3:00 PM on December 15th.',
    type: NotificationType.reschedule,
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  NotificationModel(
    id: '2',
    title: 'Time to Take Your Medicine',
    body:
        "Don't forget to take: 50mg of Antibiotic. Stay on track with your treatment!",
    type: NotificationType.medicine,
    timestamp: DateTime.now().subtract(const Duration(minutes: 34)),
  ),
  NotificationModel(
    id: '3',
    title: 'Appointment Reminder',
    body:
        'Your virtual visit with Dr. Lee is scheduled for tomorrow at 10:00 AM.',
    type: NotificationType.virtualVisit,
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  NotificationModel(
    id: '4',
    title: 'Only 2 pills of AmoxiCare left',
    body: 'Time to refill your prescription!',
    type: NotificationType.prescription,
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    actionLabel: 'Go to Prescriptions',
    actionNavIndex: 4,
  ),
  NotificationModel(
    id: '5',
    title: 'Your Visit Has Been Rescheduled',
    body: 'Your visit to Dr. Smith is rescheduled to 3:00 PM on December 15th.',
    type: NotificationType.reschedule,
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  NotificationModel(
    id: '6',
    title: 'Card expired',
    body:
        'Your policy has expired. Please renew it as soon as possible to restore coverage.',
    type: NotificationType.cardExpired,
    timestamp: DateTime.now().subtract(const Duration(hours: 8)),
    actionLabel: 'Update card',
    actionNavIndex: 0,
  ),
];

// ─────────────────────────────────────────────
//  RESPONSIVE HELPER
// ─────────────────────────────────────────────

class _R {
  final double width;
  final double height;
  final double sp; // base scale for spacing  (based on width)
  final double fp; // base scale for fonts    (based on shortest axis)

  const _R({
    required this.width,
    required this.height,
    required this.sp,
    required this.fp,
  });

  factory _R.of(BuildContext context) {
    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;
    // design baseline: 390 wide (iPhone 14)
    return _R(width: w, height: h, sp: w / 390, fp: w / 390);
  }

  /// Responsive spacing / sizing
  double s(double v) => v * sp;

  /// Responsive font size
  double f(double v) => v * fp;

  bool get isTablet => width >= 600;
}

// ─────────────────────────────────────────────
//  NOTIFICATION SCREEN
// ─────────────────────────────────────────────

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationModel> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(mockNotifications);
  }

  void _dismiss(String id) =>
      setState(() => _items.removeWhere((n) => n.id == id));

  void _markRead(String id) {
    setState(() {
      final i = _items.indexWhere((n) => n.id == id);
      if (i != -1) _items[i] = _items[i].copyWith(isRead: true);
    });
  }

  void _navigateToTab(int tabIndex) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => Homepage(initialIndex: tabIndex)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = _R.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text("Hospitals", style: TextStyle(fontWeight: FontWeight.bold)),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: SafeArea(
        // Tablet: centre content with max width
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: r.isTablet ? 680 : double.infinity,
            ),
            child: _items.isEmpty ? _empty(r) : _list(r),
          ),
        ),
      ),
    );
  }

  // ── List ──────────────────────────────────────

  Widget _list(_R r) => ListView.separated(
    padding: EdgeInsets.zero,
    itemCount: _items.length,
    separatorBuilder: (_, __) =>
        Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
    itemBuilder: (_, i) {
      final n = _items[i];
      return Dismissible(
        key: ValueKey(n.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => _dismiss(n.id),
        background: Container(
          alignment: Alignment.centerRight,
          color: const Color(0xFFEF4444),
          padding: EdgeInsets.only(right: r.s(20)),
          child: Icon(
            Icons.delete_outline_rounded,
            color: Colors.white,
            size: r.s(26),
          ),
        ),
        child: _NotificationTile(
          r: r,
          notification: n,
          onTap: () => _markRead(n.id),
          onActionTap: n.actionNavIndex != null
              ? () => _navigateToTab(n.actionNavIndex!)
              : null,
        ),
      );
    },
  );

  Widget _empty(_R r) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.notifications_off_outlined,
          size: r.s(56),
          color: Colors.grey.shade300,
        ),
        SizedBox(height: r.s(12)),
        Text(
          'No notifications',
          style: TextStyle(color: Colors.grey.shade500, fontSize: r.f(16)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  NOTIFICATION TILE
// ─────────────────────────────────────────────

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.r,
    required this.notification,
    required this.onTap,
    this.onActionTap,
  });

  final _R r;
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final n = notification;

    // Tablet: slightly larger icon & padding
    final double iconSize = r.isTablet ? r.s(52) : r.s(44);
    final double hPad = r.isTablet ? r.s(24) : r.s(16);
    final double vPad = r.isTablet ? r.s(18) : r.s(14);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: n.isRead ? Colors.white : const Color(0xFFF0F5FF),
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon badge ──────────────────────
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: n.iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(n.icon, color: n.iconForeground, size: r.s(20)),
            ),
            SizedBox(width: r.s(12)),

            // ── Text ────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          n.title,
                          style: TextStyle(
                            fontWeight: n.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                            fontSize: r.f(14),
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(width: r.s(8)),
                      Text(
                        n.timeAgo,
                        style: TextStyle(
                          fontSize: r.f(11),
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.s(4)),
                  _buildBody(n),
                  if (n.actionLabel != null) ...[
                    SizedBox(height: r.s(6)),
                    GestureDetector(
                      onTap: onActionTap,
                      child: Text(
                        n.actionLabel!,
                        style: TextStyle(
                          color: const Color(0xFF1555D8),
                          fontWeight: FontWeight.w600,
                          fontSize: r.f(13),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ── Unread dot ──────────────────────
            if (!n.isRead)
              Padding(
                padding: EdgeInsets.only(left: r.s(8), top: r.s(6)),
                child: Container(
                  width: r.s(8),
                  height: r.s(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1555D8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(NotificationModel n) {
    final dateRegex = RegExp(r'(December \d+th\.?)');
    final match = dateRegex.firstMatch(n.body);

    final baseStyle = TextStyle(
      fontSize: r.f(13),
      color: Colors.grey.shade600,
      height: 1.4,
    );

    if (match == null) return Text(n.body, style: baseStyle);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: n.body.substring(0, match.start)),
          TextSpan(
            text: match.group(0),
            style: TextStyle(
              color: const Color(0xFF1555D8),
              fontWeight: FontWeight.w600,
              fontSize: r.f(13),
            ),
          ),
          TextSpan(text: n.body.substring(match.end)),
        ],
      ),
    );
  }
}
