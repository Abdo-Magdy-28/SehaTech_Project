class MedicationReminder {
  final String medicationName;
  final String genericName;
  final String form;
  final String strength;
  final String instructions;
  final String startDate;
  final String endDate;
  final List<int> daysOfWeek;
  final List<DoseTime> doseTimes;
  final String color;

  MedicationReminder({
    required this.medicationName,
    required this.genericName,
    required this.form,
    required this.strength,
    required this.instructions,
    required this.startDate,
    required this.endDate,
    required this.daysOfWeek,
    required this.doseTimes,
    required this.color,
  });

  factory MedicationReminder.fromJson(Map<String, dynamic> json) {
    return MedicationReminder(
      medicationName: json['medicationName'] ?? '',
      genericName: json['genericName'] ?? '',
      form: json['form'] ?? '',
      strength: json['strength'] ?? '',
      instructions: json['instructions'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      daysOfWeek: List<int>.from(json['daysOfWeek'] ?? []),
      doseTimes: (json['doseTimes'] as List<dynamic>? ?? [])
          .map((e) => DoseTime.fromJson(e))
          .toList(),
      color: json['color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "medicationName": medicationName,
      "genericName": genericName,
      "form": form,
      "strength": strength,
      "instructions": instructions,
      "startDate": startDate,
      "endDate": endDate,
      "daysOfWeek": daysOfWeek,
      "doseTimes": doseTimes.map((e) => e.toJson()).toList(),
      "color": color,
    };
  }
}

class DoseTime {
  final String time;
  final String dosage;

  DoseTime({required this.time, required this.dosage});

  factory DoseTime.fromJson(Map<String, dynamic> json) {
    return DoseTime(time: json['time'] ?? '', dosage: json['dosage'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {"time": time, "dosage": dosage};
  }
}
