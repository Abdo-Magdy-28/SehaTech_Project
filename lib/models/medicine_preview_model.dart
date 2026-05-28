class Medicine_preview {
  final String tradeName;
  final String genericName;
  final List<String> activeIngredients;
  final String concentration;
  final String dosageForm;
  final List<String> indications;
  final List<String> contraindications;
  final String? manufacturer;
  final String? storageConditions;
  final String? expiryDate;

  Medicine_preview({
    required this.tradeName,
    required this.genericName,
    required this.activeIngredients,
    required this.concentration,
    required this.dosageForm,
    required this.indications,
    required this.contraindications,
    this.manufacturer,
    this.storageConditions,
    this.expiryDate,
  });

  factory Medicine_preview.fromJson(Map<String, dynamic> json) {
    return Medicine_preview(
      tradeName: json['trade_name'] ?? '',
      genericName: json['generic_name'] ?? '',
      activeIngredients: List<String>.from(json['active_ingredients'] ?? []),
      concentration: json['concentration'] ?? '',
      dosageForm: json['dosage_form'] ?? '',
      indications: List<String>.from(json['indications'] ?? []),
      contraindications: List<String>.from(json['contraindications'] ?? []),
      manufacturer: json['manufacturer'],
      storageConditions: json['storage_conditions'],
      expiryDate: json['expiry_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trade_name': tradeName,
      'generic_name': genericName,
      'active_ingredients': activeIngredients,
      'concentration': concentration,
      'dosage_form': dosageForm,
      'indications': indications,
      'contraindications': contraindications,
      'manufacturer': manufacturer,
      'storage_conditions': storageConditions,
      'expiry_date': expiryDate,
    };
  }
}
