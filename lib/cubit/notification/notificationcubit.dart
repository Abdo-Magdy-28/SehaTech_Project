import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/notification/Notification.dart';
import 'package:grad_project/services/Notification/notificationservice.dart';

import 'package:equatable/equatable.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<AppNotification> notifications;
  final int unreadCount;
  final int total;
  final int page;

  const NotificationLoaded({
    required this.notifications,
    required this.unreadCount,
    required this.total,
    required this.page,
  });

  NotificationLoaded copyWith({
    List<AppNotification>? notifications,
    int? unreadCount,
    int? total,
    int? page,
  }) {
    return NotificationLoaded(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      total: total ?? this.total,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [notifications, unreadCount, total, page];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}

class NotificationResult {
  final List<AppNotification> notifications;
  final int unreadCount;
  final int total;
  final int page;

  NotificationResult({
    required this.notifications,
    required this.unreadCount,
    required this.total,
    required this.page,
  });
}

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService _service;

  NotificationCubit(this._service) : super(NotificationInitial());

  Future<void> loadNotifications({int page = 1}) async {
    emit(NotificationLoading());
    try {
      final result = await _service.getNotifications(page: page);
      emit(
        NotificationLoaded(
          notifications: result.notifications,
          unreadCount: result.unreadCount,
          total: result.total,
          page: result.page,
        ),
      );
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> markAsRead(String id) async {
    final current = state;
    if (current is! NotificationLoaded) return;

    // optimistic update
    final updated = current.notifications.map((n) {
      if (n.id == id && !n.isRead) {
        return n.copyWith(isRead: true, readAt: DateTime.now());
      }
      return n;
    }).toList();

    final newUnread =
        current.notifications
            .firstWhere(
              (n) => n.id == id,
              orElse: () => current.notifications.first,
            )
            .isRead
        ? current.unreadCount
        : (current.unreadCount - 1).clamp(0, current.unreadCount);

    emit(current.copyWith(notifications: updated, unreadCount: newUnread));

    try {
      await _service.markAsRead(id);
    } catch (e) {
      // revert on failure
      emit(current);
    }
  }

  Future<void> markAllAsRead() async {
    final current = state;
    if (current is! NotificationLoaded) return;

    final updated = current.notifications
        .map(
          (n) =>
              n.isRead ? n : n.copyWith(isRead: true, readAt: DateTime.now()),
        )
        .toList();

    emit(current.copyWith(notifications: updated, unreadCount: 0));

    try {
      await _service.markAllAsRead();
    } catch (e) {
      emit(current);
    }
  }

  Future<void> deleteNotification(String id) async {
    final current = state;
    if (current is! NotificationLoaded) return;

    final removed = current.notifications.firstWhere(
      (n) => n.id == id,
      orElse: () => current.notifications.first,
    );

    final updated = current.notifications.where((n) => n.id != id).toList();
    final newUnread = (!removed.isRead && removed.id == id)
        ? (current.unreadCount - 1).clamp(0, current.unreadCount)
        : current.unreadCount;

    emit(
      current.copyWith(
        notifications: updated,
        unreadCount: newUnread,
        total: (current.total - 1).clamp(0, current.total),
      ),
    );

    try {
      await _service.deleteNotification(id);
    } catch (e) {
      emit(current);
    }
  }

  Future<void> refresh() => loadNotifications(page: 1);
}
