// ============================================================
// lib/screens/prescriptions/reminder_screen.dart
// ============================================================

import 'package:flutter/material.dart';
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

class _ReminderScreenState extends State<ReminderScreen> {
  late TextEditingController _nameController;

  int _dosageQty = 1;
  String _dosageUnit = '500gm';
  String _freqTimes = 'Once';
  String _freqPeriod = 'Every Day';
  String _selectedType = 'Capsule';

  int _fromDay = 1;
  String _fromMonth = 'Feb';
  int _fromYear = 2026;
  int _toDay = 6;
  String _toMonth = 'Feb';
  int _toYear = 2026;

  List<String> _selectedTimes = [];

  static const _times = [
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
  static const _months = [
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
  static const _freqTimeList = ['Once', 'Twice', 'Three times'];
  static const _freqPeriodList = ['Every Day', 'Every Week', 'Every Month'];
  static const _dosageUnits = ['500gm', '250gm', '100gm', '50gm'];
  static const _types = ['Capsule', 'Syrup'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: '${widget.medicineName} ${widget.medicineSize}',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // ── helpers ────────────────────────────────────────────
  void _onRefill() {
    final times = _selectedTimes.isEmpty
        ? ['8:00']
        : List<String>.from(_selectedTimes);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ReminderActivatedDialog(
        selectedTimes: times,
        onGoHome: () {
          Navigator.of(context).popUntil((r) => r.isFirst);
        },
      ),
    );
  }

  // ── build ───────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Reminder Info",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
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
            _SectionTitle(text: 'Provide Information', sw: sw),
            SizedBox(height: sh * 0.022),

            // Name
            _InfoRow(
              icon: Icons.medication_outlined,
              label: 'Name:',
              sw: sw,
              sh: sh,
              child: _GreyField(controller: _nameController, sw: sw, sh: sh),
            ),
            SizedBox(height: sh * 0.018),

            // Dosage
            _InfoRow(
              icon: Icons.local_pharmacy_outlined,
              label: 'Dosage :',
              sw: sw,
              sh: sh,
              child: _DosageField(
                sw: sw,
                sh: sh,
                qty: _dosageQty,
                unit: _dosageUnit,
                units: _dosageUnits,
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
              label: 'Frequency :',
              sw: sw,
              sh: sh,
              child: Row(
                children: [
                  Expanded(
                    child: _StyledDropdown(
                      value: _freqTimes,
                      items: _freqTimeList,
                      onChanged: (v) => setState(() => _freqTimes = v!),
                      sw: sw,
                      sh: sh,
                    ),
                  ),
                  SizedBox(width: sw * 0.02),
                  Expanded(
                    child: _StyledDropdown(
                      value: _freqPeriod,
                      items: _freqPeriodList,
                      onChanged: (v) => setState(() => _freqPeriod = v!),
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
              label: 'Frequency :',
              sw: sw,
              sh: sh,
              child: Row(
                children: _types.map((t) {
                  final sel = _selectedType == t;
                  return Padding(
                    padding: EdgeInsets.only(right: sw * 0.025),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = t),
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
                          t,
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
              months: _months,
              onFromDayChanged: (v) => setState(() => _fromDay = int.parse(v!)),
              onFromMonthChanged: (v) => setState(() => _fromMonth = v!),
              onFromYearChanged: (v) =>
                  setState(() => _fromYear = int.parse(v!)),
              onToDayChanged: (v) => setState(() => _toDay = int.parse(v!)),
              onToMonthChanged: (v) => setState(() => _toMonth = v!),
              onToYearChanged: (v) => setState(() => _toYear = int.parse(v!)),
            ),
            SizedBox(height: sh * 0.028),

            // Select time
            _SectionTitle(text: 'Select time', sw: sw),
            SizedBox(height: sh * 0.005),
            Text(
              'Maximum 3 times',
              style: TextStyle(
                fontSize: sw * 0.032,
                color: Colors.grey.shade500,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: sh * 0.015),

            _TimeGrid(
              times: _times,
              selected: _selectedTimes,
              sw: sw,
              sh: sh,
              onTap: (t) {
                setState(() {
                  if (_selectedTimes.contains(t)) {
                    _selectedTimes.remove(t);
                  } else if (_selectedTimes.length < 3) {
                    _selectedTimes.add(t);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Maximum 3 times allowed'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                });
              },
            ),
            SizedBox(height: sh * 0.03),

            // Refill button
            _ActionButton(
              label: 'Refill',
              color: const Color(0xFF2260FF),
              sw: sw,
              sh: sh,
              onPressed: _onRefill,
            ),
            SizedBox(height: sh * 0.015),

            // Cancel button
            _ActionButton(
              label: 'Cancel Reminder',
              color: Colors.red,
              sw: sw,
              sh: sh,
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(height: sh * 0.04),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SMALL REUSABLE WIDGETS
// ============================================================

// ── Section title ───────────────────────────────────────────
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

// ── Icon + Label + child row ────────────────────────────────
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

// ── Grey text field ─────────────────────────────────────────
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

// ── Dosage field ────────────────────────────────────────────
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

// ── Styled dropdown ─────────────────────────────────────────
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

// ── Duration section ────────────────────────────────────────
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
  Widget build(BuildContext context) => Row(
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
              'Duration:',
              style: TextStyle(
                fontSize: sw * 0.037,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: sh * 0.01),
            _dateRow(
              label: 'From:',
              day: fromDay,
              month: fromMonth,
              year: fromYear,
              onDay: onFromDayChanged,
              onMonth: onFromMonthChanged,
              onYear: onFromYearChanged,
            ),
            _dateRow(
              label: 'To:',
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

// ── Time grid ───────────────────────────────────────────────
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

// ── Action button ───────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final double sw, sh;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
    required this.sw,
    required this.sh,
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
      child: Text(
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
