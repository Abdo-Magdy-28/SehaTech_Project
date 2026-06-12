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
      longestStreak: json['longestStreak'] ?? "",
      lastCompletedDate: json['lastCompletedDate'] ?? "",
      isStreakActiveToday: json['isStreakActiveToday'] ?? "",
      weeklyAdherence: (json['weeklyAdherence'] as List)
          .map((e) => WeeklyAdherence.fromJson(e))
          .toList(),
      adherenceRate: json['adherenceRate'] ?? "",
      nextMilestone: json['nextMilestone'] ?? "",
    );
  }

  /// Days with reminders that were fully completed
  int get completedDays =>
      weeklyAdherence.where((d) => d.complete == true).length;

  /// Days with reminders that were NOT completed (has reminders but complete is false or null)
  int get missedDays => weeklyAdherence.where((d) => d.complete != true).length;

  /// Percentage: completedDays / 7 * 100
  int get streakPercentage => ((completedDays / 7) * 100).round();
}
