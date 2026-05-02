class Pharmacy {
  final String name;
  final double rating;
  final bool is24Hours;

  Pharmacy({required this.name, required this.rating, required this.is24Hours});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['name'],
      rating: json['rating'].toDouble(),
      is24Hours: json['is24Hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'rating': rating, 'is24Hours': is24Hours};
  }
}
