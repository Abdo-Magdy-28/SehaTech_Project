import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/cubit/notification/notificationcubit.dart';
import 'package:grad_project/models/notification/Notification.dart';

class NotificationService {
  final Dio _dio;

  NotificationService() : _dio = Dio(BaseOptions(baseUrl: '$apiurl/api/v2')) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const storage = FlutterSecureStorage();
          final token = await storage.read(key: 'auth_token');
          if (token != null) options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  Future<NotificationResult> getNotifications({int page = 1}) async {
    final response = await _dio.get(
      '/notifications',
      queryParameters: {'page': page},
    );

    final data = response.data['data'];
    final list = (data?['notifications'] as List?) ?? [];

    return NotificationResult(
      notifications: list.map((e) => AppNotification.fromJson(e)).toList(),
      unreadCount: response.data['unreadCount'] ?? 0,
      total: response.data['total'] ?? 0,
      page: response.data['page'] ?? 1,
    );
  }

  Future<void> markAsRead(String id) async {
    await _dio.patch('/notifications/$id/read');
  }

  Future<void> markAllAsRead() async {
    await _dio.patch('/notifications/read-all');
  }

  Future<void> deleteNotification(String id) async {
    await _dio.delete('/notifications/$id');
  }
}
