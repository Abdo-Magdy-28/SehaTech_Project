import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';

class SpecialityChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const SpecialityChip({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        // Fixed total height = 62 (icon) + 6 (gap) + 30 (label area) = 98
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon box — always same size
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Color(0xff0D61EC),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff0D5FA7).withOpacity(0.28),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),

            const SizedBox(height: 6),

            // Label area — fixed height so all chips stay on same baseline
            SizedBox(
              height: 30,
              width: 72,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialityItem {
  final String apiKey; // exact string sent to /doctors/speciality/{apiKey}
  final String label; // short localized display name
  final IconData icon;

  const SpecialityItem({
    required this.apiKey,
    required this.label,
    required this.icon,
  });
}

List<SpecialityItem> getSpecialities(BuildContext context) {
  final s = S.of(context);
  return [
    SpecialityItem(
      apiKey: 'Allergy and Immunology',
      label: s.specialityAllergyImmunology,
      icon: Icons.coronavirus_outlined,
    ),
    SpecialityItem(
      apiKey: 'Andrology and Male Infertility',
      label: s.specialityAndrology,
      icon: Icons.male_outlined,
    ),
    SpecialityItem(
      apiKey: 'Audiology',
      label: s.specialityAudiology,
      icon: Icons.hearing_outlined,
    ),
    SpecialityItem(
      apiKey: 'Cardiology and Thoracic Surgery',
      label: s.specialityCardiologyThoracic,
      icon: Icons.monitor_heart_outlined,
    ),
    SpecialityItem(
      apiKey: 'Cardiology and Vascular Disease',
      label: s.specialityCardiologyVascular,
      icon: Icons.favorite_border,
    ),
    SpecialityItem(
      apiKey: 'Chest and Respiratory',
      label: s.specialityChestRespiratory,
      icon: Icons.air_outlined,
    ),
    SpecialityItem(
      apiKey: 'Dentistry',
      label: s.specialityDentistry,
      icon: Icons.mood_outlined,
    ),
    SpecialityItem(
      apiKey: 'Dermatology',
      label: s.specialityDermatology,
      icon: Icons.face_retouching_natural_outlined,
    ),
    SpecialityItem(
      apiKey: 'Diabetes and Endocrinology',
      label: s.specialityDiabetesEndocrinology,
      icon: Icons.science_outlined,
    ),
    SpecialityItem(
      apiKey: 'Diagnostic Radiology',
      label: s.specialityDiagnosticRadiology,
      icon: Icons.document_scanner_outlined,
    ),
  ];
}
