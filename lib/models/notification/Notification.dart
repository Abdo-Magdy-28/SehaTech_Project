class NotificationData {
  final String? reminderId;
  final String? medicationName;
  final String? scheduledTime;

  NotificationData({this.reminderId, this.medicationName, this.scheduledTime});

  factory NotificationData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NotificationData();
    return NotificationData(
      reminderId: json['reminderId'],
      medicationName: json['medicationName'],
      scheduledTime: json['scheduledTime'],
    );
  }
}

class AppNotification {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String body;
  final NotificationData data;
  final String channel;
  final bool isRead;
  final DateTime? readAt;
  final bool emailSent;
  final DateTime? emailSentAt;
  final DateTime? scheduledFor;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    required this.data,
    required this.channel,
    required this.isRead,
    this.readAt,
    required this.emailSent,
    this.emailSentAt,
    this.scheduledFor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      data: NotificationData.fromJson(json['data']),
      channel: json['channel'] ?? '',
      isRead: json['isRead'] ?? false,
      readAt: json['readAt'] != null ? DateTime.tryParse(json['readAt']) : null,
      emailSent: json['emailSent'] ?? false,
      emailSentAt: json['emailSentAt'] != null
          ? DateTime.tryParse(json['emailSentAt'])
          : null,
      scheduledFor: json['scheduledFor'] != null
          ? DateTime.tryParse(json['scheduledFor'])
          : null,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  AppNotification copyWith({bool? isRead, DateTime? readAt}) {
    return AppNotification(
      id: id,
      userId: userId,
      type: type,
      title: title,
      body: body,
      data: data,
      channel: channel,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      emailSent: emailSent,
      emailSentAt: emailSentAt,
      scheduledFor: scheduledFor,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
