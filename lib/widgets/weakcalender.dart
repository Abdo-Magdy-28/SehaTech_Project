import 'package:flutter/material.dart';

class WeekScheduleWidget extends StatefulWidget {
  const WeekScheduleWidget({Key? key}) : super(key: key);

  @override
  State<WeekScheduleWidget> createState() => _WeekScheduleWidgetState();
}

class _WeekScheduleWidgetState extends State<WeekScheduleWidget> {
  DateTime selectedDate = DateTime.now();
  late DateTime weekStart;

  @override
  void initState() {
    super.initState();
    weekStart = _getWeekStart(selectedDate);
  }

  DateTime _getWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday % 7));
  }

  List<DateTime> _getWeekDays() {
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  void _previousWeek() {
    setState(() {
      weekStart = weekStart.subtract(const Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      weekStart = weekStart.add(const Duration(days: 7));
    });
  }

  String _getDayName(int weekday) {
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return days[weekday % 7];
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays();
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    final dayWidth = (screenWidth - 80) / 7;
    final dayHeight = dayWidth * 1.3;
    final fontSize = isSmallScreen ? 12.0 : 14.0;
    final dayFontSize = isSmallScreen ? 16.0 : 20.0;
    final headerFontSize = isSmallScreen ? 14.0 : 18.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with arrows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousWeek,
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: isSmallScreen ? 20 : 24,
                ),
              ),
              Flexible(
                child: Text(
                  "Today's Schedule",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: _nextWeek,
                icon: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: isSmallScreen ? 20 : 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 20),
          // Week days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weekDays.map((date) {
              final isSelected =
                  date.day == selectedDate.day &&
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;

              return Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: dayWidth.clamp(45, 60),
                    height: dayHeight.clamp(60, 80),
                    margin: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 2 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getDayName(date.weekday),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 2 : 4),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: dayFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
