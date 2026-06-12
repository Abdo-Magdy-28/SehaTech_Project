class OcrHistoryModel {
  final String id;
  final String userId;
  final String tradeName;
  final String genericName;
  final List<String> activeIngredients;
  final String concentration;
  final String dosageForm;
  final List<String> indications;
  final List<String> contraindications;
  final String manufacturer;
  final String storageConditions;
  final String expiryDate;
  final String createdAt;
  final String updatedAt;

  OcrHistoryModel({
    required this.id,
    required this.userId,
    required this.tradeName,
    required this.genericName,
    required this.activeIngredients,
    required this.concentration,
    required this.dosageForm,
    required this.indications,
    required this.contraindications,
    required this.manufacturer,
    required this.storageConditions,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OcrHistoryModel.fromJson(Map<String, dynamic> json) {
    return OcrHistoryModel(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      tradeName: json['tradeName'] ?? "",
      genericName: json['genericName'] ?? "",
      activeIngredients: List<String>.from(json['activeIngredients'] ?? []),
      concentration: json['concentration'] ?? "",
      dosageForm: json['dosageForm'] ?? "",
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      manufacturer: json['manufacturer'] ?? "",
      storageConditions: json['storageConditions'] ?? "",
      expiryDate: json['expiryDate'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
