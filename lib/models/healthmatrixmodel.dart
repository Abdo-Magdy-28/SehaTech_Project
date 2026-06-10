// ── health_matrix_model.dart ──────────────────────────────────────────────────

class AllergyModel {
  final String substance;
  final String? reaction;
  final String? severity;

  AllergyModel({required this.substance, this.reaction, this.severity});

  factory AllergyModel.fromJson(Map<String, dynamic> json) => AllergyModel(
    substance: json['substance'] as String? ?? '',
    reaction: json['reaction'] as String?,
    severity: json['severity'] as String?,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'substance': substance};
    if (reaction != null) map['reaction'] = reaction;
    if (severity != null) map['severity'] = severity;
    return map;
  }
}

class HealthMatrixModel {
  final String? id;
  final String? userId;
  final String bloodType;
  final List<AllergyModel> allergies;
  final List<String> chronicDiseases;

  HealthMatrixModel({
    this.id,
    this.userId,
    required this.bloodType,
    required this.allergies,
    required this.chronicDiseases,
  });

  factory HealthMatrixModel.fromJson(Map<String, dynamic> json) {
    final raw = json['data'] ?? json;
    final ehr = (raw is Map<String, dynamic>) ? (raw['ehr'] ?? raw) : json;

    if (ehr is! Map<String, dynamic>) {
      throw const FormatException('ehr node is not an object');
    }

    final demographics = ehr['demographics'];
    final demo = demographics is Map<String, dynamic>
        ? demographics
        : <String, dynamic>{};

    return HealthMatrixModel(
      id: ehr['_id'] as String?,
      userId: ehr['userID'] as String?,
      bloodType: demo['bloodType'] as String? ?? '',
      allergies:
          (ehr['allergies'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map(AllergyModel.fromJson)
              .toList() ??
          [],
      chronicDiseases:
          (demo['chronicDiseases'] as List<dynamic>?)
              ?.map((e) => e?.toString() ?? '')
              .where((s) => s.isNotEmpty)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'demographics': {
      'bloodType': bloodType,
      'chronicDiseases': chronicDiseases,
    },
    'allergies': allergies.map((a) => a.toJson()).toList(),
  };

  HealthMatrixModel copyWith({
    String? bloodType,
    List<AllergyModel>? allergies,
    List<String>? chronicDiseases,
  }) => HealthMatrixModel(
    id: id,
    userId: userId,
    bloodType: bloodType ?? this.bloodType,
    allergies: allergies ?? this.allergies,
    chronicDiseases: chronicDiseases ?? this.chronicDiseases,
  );

  /// Empty model used as a form default before any data is loaded
  factory HealthMatrixModel.empty() =>
      HealthMatrixModel(bloodType: '', allergies: [], chronicDiseases: []);
}
