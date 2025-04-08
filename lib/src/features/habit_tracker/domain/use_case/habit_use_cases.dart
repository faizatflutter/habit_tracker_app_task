import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/repository/habit_repo_abstract.dart';

class AddHabit {
  final HabitRepository habitRepository;

  AddHabit(this.habitRepository);

  Future<void> call(Habit habit) async {
    return await habitRepository.addHabit(habit);
  }
}

class GetAllHabits {
  final HabitRepository habitRepository;

  GetAllHabits(this.habitRepository);

  Future<List<Habit>> call() async {
    return await habitRepository.getAllHabits();
  }
}

class MarkHabitDone {
  final HabitRepository habitRepository;

  MarkHabitDone(this.habitRepository);

  Future<void> call(String habitId, DateTime date) async {
    return await habitRepository.markHabitDone(habitId, date);
  }
}
