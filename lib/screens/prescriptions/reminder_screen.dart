import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  final String medicineName;
  final String medicineSize;

  const ReminderScreen({
    super.key,
    required this.medicineName,
    required this.medicineSize,
  });

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late TextEditingController nameController;

  // Dosage
  int dosageQuantity = 1;
  String dosageUnit = '500gm';

  // Frequency
  String frequencyTimes = 'Once';
  String frequencyPeriod = 'Every Day';

  // Type
  String selectedType = 'Capsule';

  // Duration
  int fromDay = 1;
  String fromMonth = 'Feb';
  int fromYear = 2026;
  int toDay = 6;
  String toMonth = 'Feb';
  int toYear = 2026;

  // Time selection (max 3)
  final List<String> availableTimes = [
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
  List<String> selectedTimes = [];

  final List<String> months = [
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

  final List<String> frequencyTimesList = ['Once', 'Twice', 'Three times'];
  final List<String> frequencyPeriodList = [
    'Every Day',
    'Every Week',
    'Every Month',
  ];
  final List<String> dosageUnits = ['500gm', '250gm', '100gm', '50gm'];
  final List<String> types = ['Capsule', 'Syrup'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: '${widget.medicineName} ${widget.medicineSize}',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Widget _sectionIcon(IconData icon) {
    return Icon(icon, color: const Color(0xff2260FF), size: 22);
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
    );
  }

  Widget _dropdownBox({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
    double? width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Reminder Info",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Provide Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Row(
              children: [
                _sectionIcon(Icons.medication_outlined),
                const SizedBox(width: 8),
                _label("Name:"),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      style: const TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dosage
            Row(
              children: [
                _sectionIcon(Icons.local_pharmacy_outlined),
                const SizedBox(width: 8),
                _label("Dosage :"),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            if (dosageQuantity > 1) dosageQuantity--;
                          }),
                          child: const Icon(Icons.remove, size: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "$dosageQuantity",
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => dosageQuantity++),
                          child: const Icon(Icons.add, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "| $dosageUnit",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const Spacer(),
                        _dropdownBox(
                          value: dosageUnit,
                          items: dosageUnits,
                          onChanged: (v) => setState(() => dosageUnit = v!),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Frequency
            Row(
              children: [
                _sectionIcon(Icons.repeat),
                const SizedBox(width: 8),
                _label("Frequency :"),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _dropdownBox(
                          value: frequencyTimes,
                          items: frequencyTimesList,
                          onChanged: (v) => setState(() => frequencyTimes = v!),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _dropdownBox(
                          value: frequencyPeriod,
                          items: frequencyPeriodList,
                          onChanged: (v) =>
                              setState(() => frequencyPeriod = v!),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Type
            Row(
              children: [
                _sectionIcon(Icons.category_outlined),
                const SizedBox(width: 8),
                _label("Frequency :"),
                const SizedBox(width: 12),
                ...types.map((type) {
                  final isSelected = selectedType == type;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xff2260FF)
                              : const Color(0xffF0F0F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),

            // Duration
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionIcon(Icons.calendar_today_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Duration:"),
                      const SizedBox(height: 8),
                      // From row
                      Row(
                        children: [
                          const Text(
                            "From: ",
                            style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                          ),
                          _dropdownBox(
                            value: fromDay.toString(),
                            items: List.generate(31, (i) => (i + 1).toString()),
                            onChanged: (v) =>
                                setState(() => fromDay = int.parse(v!)),
                            width: devwidth * 0.15,
                          ),
                          const SizedBox(width: 6),
                          _dropdownBox(
                            value: fromMonth,
                            items: months,
                            onChanged: (v) => setState(() => fromMonth = v!),
                            width: devwidth * 0.17,
                          ),
                          const SizedBox(width: 6),
                          _dropdownBox(
                            value: fromYear.toString(),
                            items: ['2025', '2026', '2027', '2028'],
                            onChanged: (v) =>
                                setState(() => fromYear = int.parse(v!)),
                            width: devwidth * 0.20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // To row
                      Row(
                        children: [
                          const Text(
                            "To:     ",
                            style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                          ),
                          _dropdownBox(
                            value: toDay.toString(),
                            items: List.generate(31, (i) => (i + 1).toString()),
                            onChanged: (v) =>
                                setState(() => toDay = int.parse(v!)),
                            width: 60,
                          ),
                          const SizedBox(width: 6),
                          _dropdownBox(
                            value: toMonth,
                            items: months,
                            onChanged: (v) => setState(() => toMonth = v!),
                            width: 70,
                          ),
                          const SizedBox(width: 6),
                          _dropdownBox(
                            value: toYear.toString(),
                            items: ['2025', '2026', '2027', '2028'],
                            onChanged: (v) =>
                                setState(() => toYear = int.parse(v!)),
                            width: 80,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Select time
            const Text(
              "Select time",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Maximum 3 times",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.2,
              ),
              itemCount: availableTimes.length,
              itemBuilder: (context, index) {
                final time = availableTimes[index];
                final isSelected = selectedTimes.contains(time);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedTimes.remove(time);
                      } else if (selectedTimes.length < 3) {
                        selectedTimes.add(time);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Maximum 3 times allowed"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff2260FF)
                          : const Color(0xffEEF2FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Refill button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2260FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Refill",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Cancel Reminder button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Cancel Reminder",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
