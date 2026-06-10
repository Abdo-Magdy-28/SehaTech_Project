class DailyMedications {
  final String reminderId;
  final String medicationName;
  final String genericName;
  final String form;
  final String strength;
  final String instructions;
  final String time;
  final String dosage;
  final String color;
  final String status;
  final String? takenAt;
  final String? logId;

  DailyMedications({
    required this.reminderId,
    required this.medicationName,
    required this.genericName,
    required this.form,
    required this.strength,
    required this.instructions,
    required this.time,
    required this.dosage,
    required this.color,
    required this.status,
    this.takenAt,
    this.logId,
  });

  factory DailyMedications.fromJson(Map<String, dynamic> json) {
    return DailyMedications(
      reminderId: json['reminderId'] ?? '',
      medicationName: json['medicationName'] ?? '',
      genericName: json['genericName'] ?? '',
      form: json['form'] ?? '',
      strength: json['strength'] ?? '',
      instructions: json['instructions'] ?? '',
      time: json['time'] ?? '',
      dosage: json['dosage'] ?? '',
      color: json['color'] ?? '',
      status: json['status'] ?? '',
      takenAt: json['takenAt'], // nullable
      logId: json['logId'], // nullable
    );
  }
  DailyMedications copyWith({
    String? reminderId,
    String? medicationName,
    String? genericName,
    String? form,
    String? strength,
    String? instructions,
    String? color,
    String? status,
    String? dosage,
    String? time,
  }) {
    return DailyMedications(
      reminderId: reminderId ?? this.reminderId,
      medicationName: medicationName ?? this.medicationName,
      genericName: genericName ?? this.genericName,
      form: form ?? this.form,
      strength: strength ?? this.strength,
      instructions: instructions ?? this.instructions,
      color: color ?? this.color,
      status: status ?? this.status,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
    );
  }
}
