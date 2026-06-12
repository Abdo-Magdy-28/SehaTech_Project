class AllReminderModel {
  final String id;
  final String userId;
  final String medicationName;
  final String genericName;
  final String form;
  final String strength;
  final String instructions;
  final String startDate;
  final String endDate;
  final bool active;
  final String color;
  final List<int> daysOfWeek;
  final List<ReminderDoseTime> doseTimes;

  AllReminderModel({
    required this.id,
    required this.userId,
    required this.medicationName,
    required this.genericName,
    required this.form,
    required this.strength,
    required this.instructions,
    required this.startDate,
    required this.endDate,
    required this.active,
    required this.color,
    required this.daysOfWeek,
    required this.doseTimes,
  });

  factory AllReminderModel.fromJson(Map<String, dynamic> json) {
    return AllReminderModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      medicationName: json['medicationName'] ?? '',
      genericName: json['genericName'] ?? '',
      form: json['form'] ?? '',
      strength: json['strength'] ?? '',
      instructions: json['instructions'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      active: json['active'] ?? false,
      color: json['color'] ?? '',
      daysOfWeek: List<int>.from(json['daysOfWeek'] ?? []),
      doseTimes: (json['doseTimes'] as List<dynamic>? ?? [])
          .map((e) => ReminderDoseTime.fromJson(e))
          .toList(),
    );
  }
}

class ReminderDoseTime {
  final String time;
  final String dosage;
  final bool taken;
  final String? takenAt;

  ReminderDoseTime({
    required this.time,
    required this.dosage,
    required this.taken,
    this.takenAt,
  });

  factory ReminderDoseTime.fromJson(Map<String, dynamic> json) {
    return ReminderDoseTime(
      time: json['time'] ?? '',
      dosage: json['dosage'] ?? '',
      taken: json['taken'] ?? false,
      takenAt: json['takenAt'],
    );
  }
}
