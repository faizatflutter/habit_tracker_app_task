class Habit {
  final String id;
  final String name;
  final String frequency; // 'daily' or 'weekly'
  final DateTime startDate;
  final int streakCount;
  final List<DateTime> completedDates;

  const Habit({
    required this.id,
    required this.name,
    required this.frequency,
    required this.startDate,
    required this.streakCount,
    required this.completedDates,
  });

  bool isCompletedToday() {
    final today = DateTime.now();
    return completedDates.any(
      (date) => date.year == today.year && date.month == today.month && date.day == today.day,
    );
  }

  int get currentStreak {
    final sortedDates = [...completedDates]..sort((a, b) => b.compareTo(a));
    int streak = 0;
    DateTime today = DateTime.now();

    for (final date in sortedDates) {
      final diff = today.difference(date).inDays;
      if (diff == 0 || diff == streak) {
        streak++;
        today = today.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }
}
