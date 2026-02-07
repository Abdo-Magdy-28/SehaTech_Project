class Hospital {
  final String name;
  final String category;
  final double rating;
  final String openTime;
  final String closeTime;

  Hospital({
    required this.name,
    required this.category,
    required this.rating,
    required this.openTime,
    required this.closeTime,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'rating': rating,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }
}
