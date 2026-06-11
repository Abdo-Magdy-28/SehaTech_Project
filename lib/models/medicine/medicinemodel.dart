class MedicineModel {
  final String id;
  final String brandNameEn;
  final String brandNameAr;
  final String activeIngredientsEn;
  final String activeIngredientsAr;
  final String usesEn;
  final String usesAr;
  final String sideEffectsEn;
  final String sideEffectsAr;
  final String dosageEn;
  final String dosageAr;
  final String imageUrl =
      'assets/images/search/liveasy-wellness-calcium-magnesium-vitamin-d3-zinc-bones-dental-health-bottle-60-tabs-6.1-1733485732.png';
  final String categoryEn;
  final String categoryAr;

  MedicineModel({
    required this.id,
    required this.brandNameEn,
    required this.brandNameAr,
    required this.activeIngredientsEn,
    required this.activeIngredientsAr,
    required this.usesEn,
    required this.usesAr,
    required this.sideEffectsEn,
    required this.sideEffectsAr,
    required this.dosageEn,
    required this.dosageAr,

    required this.categoryEn,
    required this.categoryAr,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json["_id"],
      brandNameEn: json["Brand_Name_EN"],
      brandNameAr: json["Brand_Name_AR"],
      activeIngredientsEn: json["Active_Ingredients_EN"],
      activeIngredientsAr: json["Active_Ingredients_AR"],
      usesEn: json["Uses_EN"],
      usesAr: json["Uses_AR"],
      sideEffectsEn: json["Side_Effects_EN"],
      sideEffectsAr: json["Side_Effects_AR"],
      dosageEn: json["Dosage_and_Administration_EN"],
      dosageAr: json["Dosage_and_Administration_AR"],

      categoryEn: json["Category_EN"],
      categoryAr: json["Category_AR"],
    );
  }
}
