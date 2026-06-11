class OcrModel {
  final String tradeName; // non-nullable
  final String? genericName; // nullable
  final List<String> activeIngredients; // non-nullable
  final String? concentration; // nullable
  final String? dosageForm; // nullable
  final List<String> indications; // non-nullable
  final List<String> contraindications; // non-nullable
  final String? manufacturer; // nullable
  final String? storageConditions; // nullable
  final String? expiryDate; // nullable

  OcrModel({
    required this.tradeName,
    this.genericName,
    required this.activeIngredients,
    this.concentration,
    this.dosageForm,
    required this.indications,
    required this.contraindications,
    this.manufacturer,
    this.storageConditions,
    this.expiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "trade_name": tradeName,
      "generic_name": genericName,
      "active_ingredients": activeIngredients,
      "concentration": concentration,
      "dosage_form": dosageForm,
      "indications": indications,
      "contraindications": contraindications,
      "manufacturer": manufacturer,
      "storage_conditions": storageConditions,
      "expiry_date": expiryDate,
    };
  }

  factory OcrModel.fromJson(Map<String, dynamic> json) {
    return OcrModel(
      tradeName: json['trade_name'] ?? "",
      genericName: json['generic_name'],
      activeIngredients: List<String>.from(json['active_ingredients'] ?? []),
      concentration: json['concentration'],
      dosageForm: json['dosage_form'],
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      manufacturer: json['manufacturer'],
      storageConditions: json['storage_conditions'],
      expiryDate: json['expiry_date'],
    );
  }
}
