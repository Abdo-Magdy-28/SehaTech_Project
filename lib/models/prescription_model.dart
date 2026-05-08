enum PrescriptionStatus { active, upcoming, expired }

class Prescription {
  final String medicineName;
  final String description;
  final String capsuleCount;
  final String dateRange;
  final PrescriptionStatus status;
  final bool isHistory;

  const Prescription({
    required this.medicineName,
    required this.description,
    required this.capsuleCount,
    required this.dateRange,
    required this.status,
    this.isHistory = false,
  });
}
