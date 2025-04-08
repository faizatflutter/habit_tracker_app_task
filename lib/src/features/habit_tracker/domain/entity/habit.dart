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
}
