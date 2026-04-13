class Doctor {
  final String name;
  final String job;
  final String hospital;
  final String image;
  final double rate;
  String? description;
  String? price;
  String? phone;
  String? profile;
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
}
