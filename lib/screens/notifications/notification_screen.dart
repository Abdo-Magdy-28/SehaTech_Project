import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/notification/notificationcubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/notification/Notification.dart';
import 'package:grad_project/screens/homepage.dart';
import 'package:grad_project/services/Notification/notificationservice.dart';

// ─────────────────────────────────────────────
//  RESPONSIVE HELPER
// ─────────────────────────────────────────────
class _R {
  final double width;
  final double height;
  final double sp;
  final double fp;

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
    return _R(width: w, height: h, sp: w / 390, fp: w / 390);
  }

  double s(double v) => v * sp;
  double f(double v) => v * fp;
  bool get isTablet => width >= 600;
}

// ─────────────────────────────────────────────
//  NOTIFICATION SCREEN
// ─────────────────────────────────────────────
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  void _navigateToTab(BuildContext context, int tabIndex) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => Homepage(initialIndex: tabIndex)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = _R.of(context);

    return BlocProvider(
      create: (_) =>
          NotificationCubit(NotificationService())..loadNotifications(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            S().notifications,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: Colors.grey),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: r.isTablet ? 680 : double.infinity,
              ),
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NotificationError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  if (state is NotificationLoaded) {
                    if (state.notifications.isEmpty) {
                      return _empty(r);
                    }
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<NotificationCubit>().refresh(),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: state.notifications.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade100,
                        ),
                        itemBuilder: (_, i) {
                          final n = state.notifications[i];
                          return Dismissible(
                            key: ValueKey(n.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => context
                                .read<NotificationCubit>()
                                .deleteNotification(n.id),
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
                            child: AppNotificationCard(
                              notification: n,
                              onTap: () => context
                                  .read<NotificationCubit>()
                                  .markAsRead(n.id),
                              onActionTap: n.data.reminderId != null
                                  ? () =>
                                        _navigateToTab(
                                          context,
                                          0,
                                        ) // example tab index
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: Text("Loading..."));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          S().nonoti,
          style: TextStyle(color: Colors.grey.shade500, fontSize: r.f(16)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  CARD UI (old style preserved)
// ─────────────────────────────────────────────
class AppNotificationCard extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  const AppNotificationCard({
    Key? key,
    required this.notification,
    this.onTap,
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = _R.of(context);
    final n = notification;

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
            // Icon badge
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                color: Color(0xFF1555D8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: r.s(20),
              ),
            ),
            SizedBox(width: r.s(12)),

            // Text
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
                        n.createdAt.toLocal().toString(),
                        style: TextStyle(
                          fontSize: r.f(11),
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.s(4)),
                  Text(
                    n.body,
                    style: TextStyle(
                      fontSize: r.f(13),
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  if (n.data.medicationName != null) ...[
                    SizedBox(height: r.s(6)),
                    GestureDetector(
                      onTap: onActionTap,
                      child: Text(
                        "${S().Medication}: ${n.data.medicationName}",
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Unread dot
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
}
