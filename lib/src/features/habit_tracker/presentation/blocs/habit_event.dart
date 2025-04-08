abstract class HabitEvent {}

class LoadHabitsEvent extends HabitEvent {}

class AddHabitEvent extends HabitEvent {
  final String name;
  final String frequency;
  final DateTime startDate;

  AddHabitEvent({
    required this.name,
    required this.frequency,
    required this.startDate,
  });
}

class MarkHabitAsDoneEvent extends HabitEvent {
  final String habitId;
  final DateTime date;

  MarkHabitAsDoneEvent({
    required this.habitId,
    required this.date,
  });
}