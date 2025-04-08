import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';

abstract class HabitRepository {
  Future<void> addHabit(Habit habit);

  Future<List<Habit>> getAllHabits();

  Future<void> markHabitDone(String habitId, DateTime date);
}
