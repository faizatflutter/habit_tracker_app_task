import 'package:dartz/dartz.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';
import 'package:habit_tracker_app_task/src/shared/domain/entity/failure.dart';

abstract class HabitRepository {
  Future<Either<Failure, void>> addHabit(Habit habit);

  Future<Either<Failure, List<Habit>>> getAllHabits();

  Future<Either<Failure, void>> markHabitDone(String habitId, DateTime date);
}
