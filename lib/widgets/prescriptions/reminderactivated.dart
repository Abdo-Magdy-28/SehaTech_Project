import 'package:flutter/material.dart';

class ReminderActivatedDialog extends StatelessWidget {
  final List<String> selectedTimes;
  final VoidCallback onGoHome;

  const ReminderActivatedDialog({
    super.key,
    required this.selectedTimes,
    required this.onGoHome,
  });

  String get _timesText {
    if (selectedTimes.isEmpty) return '8:00';
    if (selectedTimes.length == 1) return selectedTimes.first;
    final last = selectedTimes.last;
    final rest = selectedTimes.sublist(0, selectedTimes.length - 1);
    return '${rest.join(', ')}, and $last';
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sw * 0.06),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: sw * 0.08),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sw * 0.07,
          vertical: sh * 0.04,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Check circle
            Container(
              width: sw * 0.18,
              height: sw * 0.18,
              decoration: const BoxDecoration(
                color: Color(0xFF3B5BDB),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: sw * 0.1),
            ),
            SizedBox(height: sh * 0.025),

            Text(
              'Reminder Activated',
              style: TextStyle(
                fontSize: sw * 0.052,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: const Color(0xFF111111),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sh * 0.015),

            Text(
              "You'll receive notifications to take your medication daily at $_timesText.",
              style: TextStyle(
                fontSize: sw * 0.037,
                color: Colors.grey.shade600,
                fontFamily: 'Cairo',
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sh * 0.035),

            // Go home button
            SizedBox(
              width: double.infinity,
              height: sh * 0.065,
              child: ElevatedButton(
                onPressed: onGoHome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B5BDB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(sw * 0.1),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Go home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sw * 0.045,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
