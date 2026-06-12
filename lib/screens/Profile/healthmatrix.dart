// ── health_matrix_screen.dart ─────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/profile/Health%20Matrix/HealthmatrixCubit.dart';
import 'package:grad_project/cubit/profile/Health%20Matrix/healthmatrixstates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/healthmatrixmodel.dart';

class HealthMatrixScreen extends StatelessWidget {
  const HealthMatrixScreen({super.key});

  static IconData _allergyIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('penicillin') || n.contains('antibiotic'))
      return Icons.medication_outlined;
    if (n.contains('pollen') || n.contains('dust') || n.contains('grass'))
      return Icons.eco_outlined;
    if (n.contains('shell') ||
        n.contains('fish') ||
        n.contains('nut') ||
        n.contains('milk') ||
        n.contains('egg') ||
        n.contains('soy'))
      return Icons.set_meal_outlined;
    return Icons.warning_amber_outlined;
  }

  static Color _allergyIconColor(int index) {
    const colors = [
      Color(0xFF43A047),
      Color(0xFFFB8C00),
      Color(0xFFE53935),
      Color(0xFF1976D2),
      Color(0xFF8E24AA),
    ];
    return colors[index % colors.length];
  }

  static Color _allergyIconBg(int index) {
    const colors = [
      Color(0xFFE8F5E9),
      Color(0xFFFFF3E0),
      Color(0xFFFFEBEE),
      Color(0xFFE3F2FD),
      Color(0xFFF3E5F5),
    ];
    return colors[index % colors.length];
  }

  static IconData _diseaseIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('diabet')) return Icons.water_drop_outlined;
    if (n.contains('hypert') || n.contains('pressure'))
      return Icons.favorite_border;
    if (n.contains('asthma')) return Icons.air;
    if (n.contains('cancer') || n.contains('tumour') || n.contains('tumor'))
      return Icons.coronavirus_outlined;
    return Icons.medical_services_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthMatrixCubit, HealthMatrixState>(
      listener: (context, state) {
        if (state is HealthMatrixSaved) {
          context.read<HealthMatrixCubit>().loadHealthMatrix();
        }
        if (state is HealthMatrixError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFE53935),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: _buildAppBar(context),
        body: BlocBuilder<HealthMatrixCubit, HealthMatrixState>(
          builder: (context, state) {
            if (state is HealthMatrixLoading || state is HealthMatrixInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF1976D2)),
              );
            }
            if (state is HealthMatrixNotFound) return _CreateFirstTimeView();
            if (state is HealthMatrixError) {
              return _ErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<HealthMatrixCubit>().loadHealthMatrix(),
              );
            }
            final data = state is HealthMatrixLoaded
                ? state.data
                : (state as HealthMatrixSaved).data;
            return _HealthMatrixBody(data: data);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: const BackButton(color: Colors.black87),
      title: Text(
        S.of(context).healthmatrix,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey.shade200),
      ),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _HealthMatrixBody extends StatelessWidget {
  final HealthMatrixModel data;
  const _HealthMatrixBody({required this.data});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final sw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Blood Type Section ─────────────────────────────────────────
            _SectionHeader(
              icon: Icons.water_drop_outlined,
              iconColor: const Color(0xFFE57373),
              label: s.bloodtype,
            ),
            const SizedBox(height: 10),
            _BloodTypeCard(bloodType: data.bloodType),
            const SizedBox(height: 20),

            // ── Allergies Section ──────────────────────────────────────────
            _SectionHeader(
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFF26C6A6),
              label: s.allergies,
              actionLabel: s.addAllergies,
              onAction: () => _showAddAllergyDialog(context),
            ),
            const SizedBox(height: 10),
            if (data.allergies.isEmpty)
              _EmptyCard(text: s.addAllergies)
            else
              _WhiteCard(
                child: Column(
                  children: [
                    ...data.allergies.asMap().entries.map(
                      (e) => _AllergyTile(
                        allergy: e.value,
                        index: e.key,
                        isLast: e.key == data.allergies.length - 1,
                        onDelete: () => context
                            .read<HealthMatrixCubit>()
                            .removeAllergyAt(e.key),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            _InfoNote(text: s.alwaysInformHealthcare),
            const SizedBox(height: 20),

            // ── Chronic Diseases Section ───────────────────────────────────
            _SectionHeader(
              icon: Icons.favorite_border,
              iconColor: const Color(0xFFEC407A),
              label: s.chronicdiseases,
              actionLabel: s.addCondition,
              onAction: () => _showAddDiseaseDialog(context),
            ),
            const SizedBox(height: 10),
            if (data.chronicDiseases.isEmpty)
              _EmptyCard(text: s.addCondition)
            else
              _WhiteCard(
                child: Column(
                  children: [
                    ...data.chronicDiseases.asMap().entries.map(
                      (e) => _DiseaseTile(
                        name: e.value,
                        isLast: e.key == data.chronicDiseases.length - 1,
                        onDelete: () => context
                            .read<HealthMatrixCubit>()
                            .removeDiseaseAt(e.key),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            _InfoNote(text: s.keepConditionUnderControl),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showAddAllergyDialog(BuildContext context) {
    final controller = TextEditingController();
    String? selectedSeverity;
    final s = S.of(context);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            s.addAllergies,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: s.allergies,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                s.severity,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: [
                  _SeverityChip(
                    label: s.mild,
                    value: 'mild',
                    selected: selectedSeverity == 'mild',
                    color: const Color(0xFF4CAF50),
                    onTap: () =>
                        setDialogState(() => selectedSeverity = 'mild'),
                  ),
                  _SeverityChip(
                    label: s.moderate,
                    value: 'moderate',
                    selected: selectedSeverity == 'moderate',
                    color: const Color(0xFFFF9800),
                    onTap: () =>
                        setDialogState(() => selectedSeverity = 'moderate'),
                  ),
                  _SeverityChip(
                    label: s.severe,
                    value: 'severe',
                    selected: selectedSeverity == 'severe',
                    color: const Color(0xFFF44336),
                    onTap: () =>
                        setDialogState(() => selectedSeverity = 'severe'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                S.of(context).discardchanges,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final substance = controller.text.trim();
                if (substance.isNotEmpty) {
                  context.read<HealthMatrixCubit>().addAllergy(
                    substance,
                    severity: selectedSeverity,
                  );
                }
                Navigator.pop(ctx);
              },
              child: Text(
                s.savechanges,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDiseaseDialog(BuildContext context) {
    final controller = TextEditingController();
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          s.addCondition,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: s.chronicdiseases,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              s.discardchanges,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty)
                context.read<HealthMatrixCubit>().addDisease(name);
              Navigator.pop(ctx);
            },
            child: Text(
              s.savechanges,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Blood Type Card ────────────────────────────────────────────────────────────

class _BloodTypeCard extends StatelessWidget {
  final String bloodType;
  const _BloodTypeCard({required this.bloodType});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final sw = MediaQuery.of(context).size.width;
    final label = _bloodTypeLabel(bloodType);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(sw * 0.04),
      child: Row(
        children: [
          // Blood type large text
          Container(
            width: sw * 0.18,
            alignment: Alignment.center,
            child: Text(
              bloodType.isEmpty ? '—' : bloodType,
              style: TextStyle(
                fontSize: sw * 0.12,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFE53935),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 64,
            color: const Color(0xFFFFCDD2),
            margin: EdgeInsets.symmetric(horizontal: sw * 0.03),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: sw * 0.04,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s.aPositiveBloodTypeDesc,
                  style: TextStyle(fontSize: sw * 0.031, color: Colors.black45),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _showChangeBloodTypeDialog(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE53935),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      s.changeType,
                      style: TextStyle(
                        fontSize: sw * 0.031,
                        color: const Color(0xFFE53935),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _bloodTypeLabel(String bt) {
    const map = {
      'A+': 'A Positive',
      'A-': 'A Negative',
      'B+': 'B Positive',
      'B-': 'B Negative',
      'AB+': 'AB Positive',
      'AB-': 'AB Negative',
      'O+': 'O Positive',
      'O-': 'O Negative',
    };
    return map[bt] ?? bt;
  }

  void _showChangeBloodTypeDialog(BuildContext context) {
    const types = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).bloodtype,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: types
                    .map(
                      (t) => GestureDetector(
                        onTap: () {
                          context.read<HealthMatrixCubit>().changeBloodType(t);
                          Navigator.pop(ctx);
                        },
                        child: Container(
                          width: 64,
                          height: 44,
                          decoration: BoxDecoration(
                            color: t == bloodType
                                ? const Color(0xFFFFEBEE)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: t == bloodType
                                  ? const Color(0xFFE53935)
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            t,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: t == bloodType
                                  ? const Color(0xFFE53935)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Allergy Tile ───────────────────────────────────────────────────────────────

class _AllergyTile extends StatelessWidget {
  final AllergyModel allergy;
  final int index;
  final bool isLast;
  final VoidCallback onDelete;

  const _AllergyTile({
    required this.allergy,
    required this.index,
    required this.isLast,
    required this.onDelete,
  });

  static const _severityColors = {
    'mild': Color(0xFF4CAF50),
    'moderate': Color(0xFFFF9800),
    'severe': Color(0xFFF44336),
  };

  static const _severityBg = {
    'mild': Color(0xFFE8F5E9),
    'moderate': Color(0xFFFFF3E0),
    'severe': Color(0xFFFFEBEE),
  };

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final severityLabels = {
      'mild': s.mild,
      'moderate': s.moderate,
      'severe': s.severe,
    };
    final sw = MediaQuery.of(context).size.width;
    final iconColor = HealthMatrixScreen._allergyIconColor(index);
    final iconBg = HealthMatrixScreen._allergyIconBg(index);
    final icon = HealthMatrixScreen._allergyIcon(allergy.substance);
    final severityKey = allergy.severity?.toLowerCase() ?? '';
    final severityColor =
        _severityColors[severityKey] ?? const Color(0xFF757575);
    final severityDisplayLabel =
        severityLabels[severityKey] ?? allergy.severity ?? ''; // ← ADD THIS
    final severityBg = _severityBg[severityKey] ?? Colors.grey.shade100;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allergy.substance,
                      style: TextStyle(
                        fontSize: sw * 0.038,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (allergy.reaction != null &&
                        allergy.reaction!.isNotEmpty)
                      Text(
                        allergy.reaction!,
                        style: TextStyle(
                          fontSize: sw * 0.031,
                          color: Colors.black45,
                        ),
                      ),
                  ],
                ),
              ),
              if (allergy.severity != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: severityBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    severityDisplayLabel, // ← localized label

                    style: TextStyle(
                      fontSize: sw * 0.029,
                      fontWeight: FontWeight.w600,
                      color: severityColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.close, size: 18, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.grey.shade100,
          ),
      ],
    );
  }
}

// ── Disease Tile ───────────────────────────────────────────────────────────────

class _DiseaseTile extends StatelessWidget {
  final String name;
  final bool isLast;
  final VoidCallback onDelete;

  const _DiseaseTile({
    required this.name,
    required this.isLast,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final sw = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  HealthMatrixScreen._diseaseIcon(name),
                  color: const Color(0xFF1976D2),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: sw * 0.038,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  s.managed,
                  style: TextStyle(
                    fontSize: sw * 0.029,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.close, size: 18, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.grey.shade100,
          ),
      ],
    );
  }
}

// ── Create First-Time View ─────────────────────────────────────────────────────

class _CreateFirstTimeView extends StatefulWidget {
  @override
  State<_CreateFirstTimeView> createState() => _CreateFirstTimeViewState();
}

class _CreateFirstTimeViewState extends State<_CreateFirstTimeView> {
  final _formKey = GlobalKey<FormState>();
  String _bloodType = 'A+';
  final List<String> _allergies = [];
  final List<String> _diseases = [];
  final _allergyCtrl = TextEditingController();
  final _diseaseCtrl = TextEditingController();

  static const _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void dispose() {
    _allergyCtrl.dispose();
    _diseaseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final sw = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(sw * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Icon(
                  Icons.health_and_safety_outlined,
                  size: 64,
                  color: Colors.grey.shade300,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  s.healthmatrix,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                s.bloodtype,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _bloodTypes
                    .map(
                      (t) => GestureDetector(
                        onTap: () => setState(() => _bloodType = t),
                        child: Container(
                          width: 56,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _bloodType == t
                                ? const Color(0xFFFFEBEE)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _bloodType == t
                                  ? const Color(0xFFE53935)
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            t,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _bloodType == t
                                  ? const Color(0xFFE53935)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              Text(
                s.allergies,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _allergyCtrl,
                      decoration: InputDecoration(
                        hintText: s.allergies,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF1976D2),
                    ),
                    onPressed: () {
                      final v = _allergyCtrl.text.trim();
                      if (v.isNotEmpty) {
                        setState(() => _allergies.add(v));
                        _allergyCtrl.clear();
                      }
                    },
                  ),
                ],
              ),
              ..._allergies.map(
                (a) => ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.circle,
                    size: 8,
                    color: Color(0xFF43A047),
                  ),
                  title: Text(a),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () => setState(() => _allergies.remove(a)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                s.chronicdiseases,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _diseaseCtrl,
                      decoration: InputDecoration(
                        hintText: s.chronicdiseases,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF1976D2),
                    ),
                    onPressed: () {
                      final v = _diseaseCtrl.text.trim();
                      if (v.isNotEmpty) {
                        setState(() => _diseases.add(v));
                        _diseaseCtrl.clear();
                      }
                    },
                  ),
                ],
              ),
              ..._diseases.map(
                (d) => ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.circle,
                    size: 8,
                    color: Color(0xFFEC407A),
                  ),
                  title: Text(d),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () => setState(() => _diseases.remove(d)),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.read<HealthMatrixCubit>().createHealthMatrix(
                      HealthMatrixModel(
                        bloodType: _bloodType,
                        allergies: _allergies
                            .map((a) => AllergyModel(substance: a))
                            .toList(),
                        chronicDiseases: _diseases,
                      ),
                    );
                  },
                  child: Text(
                    s.finish,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Error View ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onRetry,
              child: Text(
                S.of(context).erroroccured,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared Widgets ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: sw * 0.055),
            SizedBox(width: sw * 0.02),
            Text(
              label,
              style: TextStyle(
                fontSize: sw * 0.043,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        if (actionLabel != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: TextStyle(
                color: const Color(0xFF1976D2),
                fontSize: sw * 0.034,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final Widget child;
  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String text;
  const _EmptyCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  final String text;
  const _InfoNote({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 14, color: Colors.black38),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeverityChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _SeverityChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.12) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? color : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
