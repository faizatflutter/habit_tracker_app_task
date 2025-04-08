import 'package:habit_tracker_app_task/src/features/habit_tracker/data/data_sources/remote_data_source.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/repository/habit_repo_abstract.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource remoteDataSource;

  HabitRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addHabit(Habit habit) {
    final habitModel = HabitModel(
      id: habit.id,
      name: habit.name,
      frequency: habit.frequency,
      startDate: habit.startDate,
      streakCount: habit.streakCount,
      completedDates: habit.completedDates,
    );
    return remoteDataSource.addHabit(habitModel);
  }

  @override
  Future<List<Habit>> getAllHabits() async {
    return await remoteDataSource.getAllHabits();
  }

  @override
  Future<void> markHabitDone(String habitId, DateTime date) {
    return remoteDataSource.markHabitAsDone(habitId, date);
  }
}
