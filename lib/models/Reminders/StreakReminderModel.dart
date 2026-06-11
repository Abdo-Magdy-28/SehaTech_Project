class WeeklyAdherence {
  final String date;
  final bool hasReminders;
  final bool? complete;

  WeeklyAdherence({
    required this.date,
    required this.hasReminders,
    this.complete,
  });

  factory WeeklyAdherence.fromJson(Map<String, dynamic> json) {
    return WeeklyAdherence(
      date: json['date'],
      hasReminders: json['hasReminders'],
      complete: json['complete'],
    );
  }
}

class StreakModel {
  final int currentStreak;
  final int longestStreak;
  final String lastCompletedDate;
  final bool isStreakActiveToday;
  final List<WeeklyAdherence> weeklyAdherence;
  final int adherenceRate;
  final int nextMilestone;

  StreakModel({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastCompletedDate,
    required this.isStreakActiveToday,
    required this.weeklyAdherence,
    required this.adherenceRate,
    required this.nextMilestone,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentStreak: json['currentStreak'],
      longestStreak: json['longestStreak'],
      lastCompletedDate: json['lastCompletedDate'],
      isStreakActiveToday: json['isStreakActiveToday'],
      weeklyAdherence: (json['weeklyAdherence'] as List)
          .map((e) => WeeklyAdherence.fromJson(e))
          .toList(),
      adherenceRate: json['adherenceRate'],
      nextMilestone: json['nextMilestone'],
    );
  }

  /// 🔢 Percentage progress toward 7-day streak
  int get streakPercentage => ((currentStreak / 7) * 100).round();

  /// 📉 Missed days out of 7
  int get missedDays => 7 - currentStreak;
}
