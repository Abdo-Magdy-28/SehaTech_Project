// ============================================================
// lib/screens/prescriptions/reminder_screen.dart
// ============================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/cubit/Reminder/ReminderCubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/medication_reminder.dart';
import 'package:grad_project/widgets/prescriptions/reminderactivated.dart';

class ReminderScreen extends StatefulWidget {
  final String medicineName;
  final String medicineSize;

  ReminderScreen({
    super.key,
    required this.medicineName,
    required this.medicineSize,
  });

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

// ── Backend-safe constants (always English, never localized) ─
// These are the values that go to the API regardless of UI language.

const _kFreqTimesEn = ['Once', 'Twice', 'Three times'];
const _kFreqPeriodEn = ['Every Day', 'Every Week', 'Every Month'];
const _kDosageUnits = ['500gm', '250gm', '100gm', '50gm'];
const _kTypesEn = ['Capsule', 'Syrup'];

const _kTimes = [
  '06:00',
  '07:00',
  '08:00',
  '09:00',
  '10:00',
  '11:00',
  '12:00',
  '13:00',
  '14:00',
  '15:00',
  '16:00',
  '17:00',
  '18:00',
  '19:00',
  '20:00',
  '21:00',
];

const _kMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

// ── Localized label helpers ──────────────────────────────────
// Each helper maps the English backend key → localized display label.

List<String> _freqTimesLabels(S s) => [
  s.reminderFreqOnce,
  s.reminderFreqTwice,
  s.reminderFreqThreeTimes,
];

List<String> _freqPeriodLabels(S s) => [
  s.reminderPeriodEveryDay,
  s.reminderPeriodEveryWeek,
  s.reminderPeriodEveryMonth,
];

List<String> _typeLabels(S s) => [s.reminderTypeCapsule, s.reminderTypeSyrup];

// Convert localized type label → English backend value
String _typeToBackend(String localizedType, S s) {
  if (localizedType == s.reminderTypeSyrup) return 'Syrup';
  return 'Capsule';
}

// Convert localized freqTimes label → max selectable int
int _maxTimesFromLabel(String localizedLabel, S s) {
  if (localizedLabel == s.reminderFreqTwice) return 2;
  if (localizedLabel == s.reminderFreqThreeTimes) return 3;
  return 1;
}

// ── Screen ───────────────────────────────────────────────────

class _ReminderScreenState extends State<ReminderScreen> {
  String monthToNumber(String m) {
    const map = {
      'Jan': '01',
      'Feb': '02',
      'Mar': '03',
      'Apr': '04',
      'May': '05',
      'Jun': '06',
      'Jul': '07',
      'Aug': '08',
      'Sep': '09',
      'Oct': '10',
      'Nov': '11',
      'Dec': '12',
    };
    return map[m]!;
  }

  int get maxSelectableTimes =>
      _maxTimesFromLabel(_freqTimesLabel, S.of(context));

  void _submitReminder() async {
    // Resolve English backend values from the currently selected labels
    final s = S.of(context);

    final medName = widget.medicineName.isNotEmpty
        ? widget.medicineName
        : _nameController.text.trim().split(' ').first;

    final generic = widget.medicineName.isNotEmpty
        ? widget.medicineName
        : _nameController.text.trim().split(' ').first;

    // _selectedTypeLabel is a localized string; convert to English for API
    final backendType = _typeToBackend(_selectedTypeLabel, s);

    final reminder = MedicationReminder(
      medicationName: medName,
      genericName: generic,
      form: backendType.toLowerCase(), // english → api
      strength: _dosageUnit.replaceAll('gm', 'mg'), // unit stays as-is
      instructions: 'Take as prescribed',
      startDate:
          '$_fromYear-${monthToNumber(_fromMonth)}-${_fromDay.toString().padLeft(2, '0')}',
      endDate:
          '$_toYear-${monthToNumber(_toMonth)}-${_toDay.toString().padLeft(2, '0')}',
      daysOfWeek: [1, 2, 3, 4, 5],
      doseTimes: _selectedTimes
          .map(
            (t) => DoseTime(
              time: t,
              // dosage uses English type
              dosage: '1 ${backendType.toLowerCase()}',
            ),
          )
          .toList(),
      color: '#1a9f5a',
    );

    context.read<ReminderCubit>().submitReminder(reminder);
  }

  bool _isLoading = false;

  late TextEditingController _nameController;

  int _dosageQty = 1;
  String _dosageUnit = '500gm';

  // These hold the *localized* label the user sees.
  // They are initialized in didChangeDependencies so we have context/locale.
  late String _freqTimesLabel;
  late String _freqPeriodLabel;
  late String _selectedTypeLabel;

  late int _fromDay;
  late String _fromMonth;
  late int _fromYear;
  int _toDay = 6;
  String _toMonth = 'Feb';
  int _toYear = 2026;

  List<String> _selectedTimes = [];

  bool _labelsInitialized = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _fromDay = now.day;
    _fromMonth = _kMonths[now.month - 1];
    _fromYear = now.year;
    _nameController = TextEditingController(
      text: '${widget.medicineName} ${widget.medicineSize}',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize localized labels once (safe because context is available here)
    if (!_labelsInitialized) {
      final s = S.of(context);
      _freqTimesLabel = s.reminderFreqOnce;
      _freqPeriodLabel = s.reminderPeriodEveryDay;
      _selectedTypeLabel = s.reminderTypeCapsule;
      _labelsInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onRefill() {
    final times = _selectedTimes.isEmpty
        ? ['8:00']
        : List<String>.from(_selectedTimes);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ReminderActivatedDialog(
        selectedTimes: times,
        onGoHome: () => Navigator.of(context).popUntil((r) => r.isFirst),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return BlocListener<ReminderCubit, ReminderState>(
      listener: (context, state) {
        if (state is ReminderLoading) {
          setState(() => _isLoading = true);
        } else {
          setState(() => _isLoading = false);
        }
        if (state is ReminderSuccess) _onRefill();
        if (state is ReminderError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            s.reminderInfoTitle, // ← localized
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: Colors.grey),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.045,
            vertical: sh * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(text: s.reminderProvideInfo, sw: sw), // ← localized
              SizedBox(height: sh * 0.022),

              // Name
              _InfoRow(
                icon: Icons.medication_outlined,
                label: s.reminderLabelName, // ← localized
                sw: sw,
                sh: sh,
                child: _GreyField(controller: _nameController, sw: sw, sh: sh),
              ),
              SizedBox(height: sh * 0.018),

              // Dosage
              _InfoRow(
                icon: Icons.local_pharmacy_outlined,
                label: s.reminderLabelDosage, // ← localized
                sw: sw,
                sh: sh,
                child: _DosageField(
                  sw: sw,
                  sh: sh,
                  qty: _dosageQty,
                  unit: _dosageUnit,
                  units: _kDosageUnits, // units stay as-is (mg values)
                  onDecrease: () => setState(() {
                    if (_dosageQty > 1) _dosageQty--;
                  }),
                  onIncrease: () => setState(() => _dosageQty++),
                  onUnitChanged: (v) => setState(() => _dosageUnit = v!),
                ),
              ),
              SizedBox(height: sh * 0.018),

              // Frequency
              _InfoRow(
                icon: Icons.repeat,
                label: s.reminderLabelFrequency, // ← localized
                sw: sw,
                sh: sh,
                child: Row(
                  children: [
                    Expanded(
                      child: _StyledDropdown(
                        value: _freqTimesLabel,
                        items: _freqTimesLabels(s), // ← localized list
                        onChanged: (v) {
                          setState(() {
                            _freqTimesLabel = v!;
                            final max = _maxTimesFromLabel(v, s);
                            if (_selectedTimes.length > max) {
                              _selectedTimes = _selectedTimes
                                  .take(max)
                                  .toList();
                            }
                          });
                        },
                        sw: sw,
                        sh: sh,
                      ),
                    ),
                    SizedBox(width: sw * 0.02),
                    Expanded(
                      child: _StyledDropdown(
                        value: _freqPeriodLabel,
                        items: _freqPeriodLabels(s), // ← localized list
                        onChanged: (v) => setState(() => _freqPeriodLabel = v!),
                        sw: sw,
                        sh: sh,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sh * 0.018),

              // Type (Capsule / Syrup)
              _InfoRow(
                icon: Icons.category_outlined,
                label: s
                    .reminderLabelType, // ← localized (was wrongly "Frequency" before)
                sw: sw,
                sh: sh,
                child: Row(
                  children: _typeLabels(s).map((t) {
                    final sel = _selectedTypeLabel == t;
                    return Padding(
                      padding: EdgeInsets.only(right: sw * 0.025),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTypeLabel = t),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.05,
                            vertical: sh * 0.012,
                          ),
                          decoration: BoxDecoration(
                            color: sel
                                ? const Color(0xFF2260FF)
                                : const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(sw * 0.02),
                          ),
                          child: Text(
                            t, // localized label
                            style: TextStyle(
                              fontSize: sw * 0.035,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: sh * 0.018),

              // Duration
              _DurationSection(
                sw: sw,
                sh: sh,
                fromDay: _fromDay,
                fromMonth: _fromMonth,
                fromYear: _fromYear,
                toDay: _toDay,
                toMonth: _toMonth,
                toYear: _toYear,
                months: _kMonths,
                onFromDayChanged: (v) =>
                    setState(() => _fromDay = int.parse(v!)),
                onFromMonthChanged: (v) => setState(() => _fromMonth = v!),
                onFromYearChanged: (v) =>
                    setState(() => _fromYear = int.parse(v!)),
                onToDayChanged: (v) => setState(() => _toDay = int.parse(v!)),
                onToMonthChanged: (v) => setState(() => _toMonth = v!),
                onToYearChanged: (v) => setState(() => _toYear = int.parse(v!)),
              ),
              SizedBox(height: sh * 0.028),

              // Select time
              _SectionTitle(text: s.reminderSelectTime, sw: sw), // ← localized
              SizedBox(height: sh * 0.005),
              Text(
                s.reminderMaxTimes, // ← localized
                style: TextStyle(
                  fontSize: sw * 0.032,
                  color: Colors.grey.shade500,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: sh * 0.015),

              _TimeGrid(
                times: _kTimes,
                selected: _selectedTimes,
                sw: sw,
                sh: sh,
                onTap: (t) {
                  setState(() {
                    if (_selectedTimes.contains(t)) {
                      _selectedTimes.remove(t);
                    } else if (_selectedTimes.length < maxSelectableTimes) {
                      _selectedTimes.add(t);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            s.reminderMaxTimesError(maxSelectableTimes),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  });
                },
              ),
              SizedBox(height: sh * 0.03),

              // Refill button
              _ActionButton(
                label: s.reminderButtonRefill, // ← localized
                color: const Color(0xFF2260FF),
                sw: sw,
                sh: sh,
                onPressed: _isLoading ? null : _submitReminder,
                isLoading: _isLoading,
              ),
              SizedBox(height: sh * 0.015),

              // Cancel button
              _ActionButton(
                label: s.reminderButtonCancel, // ← localized
                color: Colors.red,
                sw: sw,
                sh: sh,
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: sh * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SMALL REUSABLE WIDGETS  (unchanged — no strings inside them)
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String text;
  final double sw;
  const _SectionTitle({required this.text, required this.sw});

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: sw * 0.045,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
    ),
  );
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;
  final double sw, sh;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.child,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, color: const Color(0xFF2260FF), size: sw * 0.055),
      SizedBox(width: sw * 0.02),
      Text(
        label,
        style: TextStyle(
          fontSize: sw * 0.037,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
      SizedBox(width: sw * 0.03),
      Expanded(child: child),
    ],
  );
}

class _GreyField extends StatelessWidget {
  final TextEditingController controller;
  final double sw, sh;
  const _GreyField({
    required this.controller,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F0F0),
      borderRadius: BorderRadius.circular(sw * 0.02),
    ),
    child: TextField(
      controller: controller,
      style: TextStyle(fontSize: sw * 0.035, fontFamily: 'Cairo'),
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: sh * 0.013),
      ),
    ),
  );
}

class _DosageField extends StatelessWidget {
  final int qty;
  final String unit;
  final List<String> units;
  final VoidCallback onDecrease, onIncrease;
  final ValueChanged<String?> onUnitChanged;
  final double sw, sh;

  const _DosageField({
    required this.qty,
    required this.unit,
    required this.units,
    required this.onDecrease,
    required this.onIncrease,
    required this.onUnitChanged,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.025, vertical: sh * 0.008),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F0F0),
      borderRadius: BorderRadius.circular(sw * 0.02),
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: onDecrease,
          child: Icon(Icons.remove, size: sw * 0.045),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.02),
          child: Text(
            '$qty',
            style: TextStyle(fontSize: sw * 0.035, fontFamily: 'Cairo'),
          ),
        ),
        GestureDetector(
          onTap: onIncrease,
          child: Icon(Icons.add, size: sw * 0.045),
        ),
        SizedBox(width: sw * 0.02),
        Text(
          '| $unit',
          style: TextStyle(
            fontSize: sw * 0.03,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
        const Spacer(),
        Text(
          'capsule/Spoonful',
          style: TextStyle(
            fontSize: sw * 0.028,
            color: Colors.grey.shade500,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    ),
  );
}

class _StyledDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double sw, sh;

  const _StyledDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F0F0),
      borderRadius: BorderRadius.circular(sw * 0.02),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, size: sw * 0.045),
        style: TextStyle(
          fontSize: sw * 0.033,
          fontFamily: 'Cairo',
          color: Colors.black87,
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

class _DurationSection extends StatelessWidget {
  final double sw, sh;
  final int fromDay, fromYear, toDay, toYear;
  final String fromMonth, toMonth;
  final List<String> months;
  final ValueChanged<String?> onFromDayChanged,
      onFromMonthChanged,
      onFromYearChanged,
      onToDayChanged,
      onToMonthChanged,
      onToYearChanged;

  const _DurationSection({
    required this.sw,
    required this.sh,
    required this.fromDay,
    required this.fromMonth,
    required this.fromYear,
    required this.toDay,
    required this.toMonth,
    required this.toYear,
    required this.months,
    required this.onFromDayChanged,
    required this.onFromMonthChanged,
    required this.onFromYearChanged,
    required this.onToDayChanged,
    required this.onToMonthChanged,
    required this.onToYearChanged,
  });

  Widget _dateRow({
    required String label,
    required int day,
    required String month,
    required int year,
    required ValueChanged<String?> onDay,
    required ValueChanged<String?> onMonth,
    required ValueChanged<String?> onYear,
  }) => Padding(
    padding: EdgeInsets.only(bottom: sh * 0.01),
    child: Row(
      children: [
        SizedBox(
          width: sw * 0.13,
          child: Text(
            label,
            style: TextStyle(fontSize: sw * 0.033, fontFamily: 'Cairo'),
          ),
        ),
        Expanded(
          child: _StyledDropdown(
            value: day.toString(),
            items: List.generate(31, (i) => (i + 1).toString()),
            onChanged: onDay,
            sw: sw,
            sh: sh,
          ),
        ),
        SizedBox(width: sw * 0.015),
        Expanded(
          child: _StyledDropdown(
            value: month,
            items: months,
            onChanged: onMonth,
            sw: sw,
            sh: sh,
          ),
        ),
        SizedBox(width: sw * 0.015),
        Expanded(
          child: _StyledDropdown(
            value: year.toString(),
            items: ['2025', '2026', '2027', '2028'],
            onChanged: onYear,
            sw: sw,
            sh: sh,
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: const Color(0xFF2260FF),
          size: sw * 0.055,
        ),
        SizedBox(width: sw * 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.reminderLabelDuration, // ← localized
                style: TextStyle(
                  fontSize: sw * 0.037,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: sh * 0.01),
              _dateRow(
                label: s.reminderFrom, // ← localized
                day: fromDay,
                month: fromMonth,
                year: fromYear,
                onDay: onFromDayChanged,
                onMonth: onFromMonthChanged,
                onYear: onFromYearChanged,
              ),
              _dateRow(
                label: s.reminderTo, // ← localized
                day: toDay,
                month: toMonth,
                year: toYear,
                onDay: onToDayChanged,
                onMonth: onToMonthChanged,
                onYear: onToYearChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeGrid extends StatelessWidget {
  final List<String> times, selected;
  final ValueChanged<String> onTap;
  final double sw, sh;

  const _TimeGrid({
    required this.times,
    required this.selected,
    required this.onTap,
    required this.sw,
    required this.sh,
  });

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: sw * 0.025,
      mainAxisSpacing: sh * 0.012,
      childAspectRatio: 2.3,
    ),
    itemCount: times.length,
    itemBuilder: (_, i) {
      final t = times[i];
      final sel = selected.contains(t);
      return GestureDetector(
        onTap: () => onTap(t),
        child: Container(
          decoration: BoxDecoration(
            color: sel ? const Color(0xFF2260FF) : const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(sw * 0.06),
          ),
          child: Center(
            child: Text(
              t,
              style: TextStyle(
                fontSize: sw * 0.032,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                color: sel ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final double sw, sh;
  final bool isLoading;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
    required this.sw,
    required this.sh,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: sh * 0.065,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sw * 0.03),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: sw * 0.05,
              height: sw * 0.05,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: sw * 0.042,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
    ),
  );
}
