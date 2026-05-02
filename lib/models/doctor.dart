class Doctor {
  final String name;
  String? description;
  final String hospital;
  final String job;
  String? phone;
  String? profile;
  final String image;
  String? price;
  final double rate;
  final String beginDate;
  final String endDate;

  Doctor({
    this.price,
    this.phone,
    this.profile,
    this.description,
    required this.name,
    required this.job,
    required this.hospital,
    required this.image,
    required this.rate,
    required this.beginDate,
    required this.endDate,
  });
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] ?? '',
      description: json['description'],
      hospital: json['address'] ?? '',
      job: json['medicalSpecialty'] ?? '',
      phone: json['telephone'],
      profile: json['profile_url'],
      image: json['image'] ?? '',
      price: json['priceRange'],
      rate: (json['rate'] ?? 0).toDouble(),
      beginDate: json['beginDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'address': hospital,
      'medicalSpecialty': job,
      'telephone': phone,
      'profile_url': profile,
      'image': image,
      'priceRange': price,
      'rate': rate,
      'beginDate': beginDate,
      'endDate': endDate,
    };
  }
}
