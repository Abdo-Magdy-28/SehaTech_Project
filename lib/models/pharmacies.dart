class Pharmacy {
  final String id;
  final String name;
  final String nameAr;
  final double rating;
  final bool is24Hours;
  final String address;
  final String city;
  final String openingHours;
  final double? latitude;
  final double? longitude;

  Pharmacy({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.rating,
    required this.is24Hours,
    required this.address,
    required this.city,
    required this.openingHours,
    this.latitude,
    this.longitude,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    final coords = json['location']?['coordinates'] as List?;
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      is24Hours: json['is24Hours'] ?? false,
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      openingHours: json['openingHours'] ?? '',
      longitude: coords != null ? (coords[0] as num).toDouble() : null,
      latitude: coords != null ? (coords[1] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'nameAr': nameAr,
      'rating': rating,
      'is24Hours': is24Hours,
      'address': address,
      'city': city,
      'openingHours': openingHours,
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude],
      },
    };
  }
}
