class Hospital {
  final String id;
  final String name;
  final String nameAr;
  final String category; // type: public/private
  final double? rating;
  final String openTime;
  final String phone;
  final String? website;
  final bool hasEmergency;
  final List<String> specialties;
  final double latitude; // 👈 add
  final double longitude;
  Hospital({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.category,
    this.rating,
    required this.openTime,
    required this.phone,
    this.website,
    required this.hasEmergency,
    required this.specialties,
    required this.latitude, // 👈 add
    required this.longitude,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    final coords = json['location']?['coordinates'] ?? [0.0, 0.0];
    return Hospital(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
      category: json['type'] ?? '',
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      openTime: json['openingHours'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'],
      hasEmergency: json['hasEmergency'] ?? false,
      specialties: List<String>.from(json['specialties'] ?? []),
      longitude: (coords[0] as num).toDouble(), // 31.1803111
      latitude: (coords[1] as num).toDouble(), // 30.4738277
    );
  }
}
