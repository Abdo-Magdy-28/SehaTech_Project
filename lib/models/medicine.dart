class Medicine {
  final String name;
  final String image;
  final String description;
  final String component;
  final double rate;
  final List<String> sizes;
  final String overview;
  final List<String> keyBenefits;
  final List<String> sideEffects;
  final String category;

  Medicine({
    required this.name,
    required this.image,
    required this.description,
    required this.component,
    required this.rate,
    required this.sizes,
    required this.overview,
    required this.keyBenefits,
    required this.sideEffects,
    required this.category,
  });
}
