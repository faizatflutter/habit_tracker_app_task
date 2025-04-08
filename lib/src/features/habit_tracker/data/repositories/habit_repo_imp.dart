import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/data_sources/remote_data_source.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/repository/habit_repo_abstract.dart';
import 'package:habit_tracker_app_task/src/shared/domain/entity/failure.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource remoteDataSource;

  HabitRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addHabit(Habit habit) async {
    final habitModel = HabitModel(
      id: habit.id,
      name: habit.name,
      frequency: habit.frequency,
      startDate: habit.startDate,
      streakCount: habit.streakCount,
      completedDates: habit.completedDates,
    );

    try {
      await remoteDataSource.addHabit(habitModel);
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> getAllHabits() async {
    try {
      List<Habit> habits = await remoteDataSource.getAllHabits();
      return Right(habits);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markHabitDone(String habitId, DateTime date) async {
    try {
      final result = await remoteDataSource.markHabitAsDone(habitId, date);
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error while marking habit'));
    } catch (e) {
      return Left(UnknownFailure('Unknown error: ${e.toString()}'));
    }
  }
}
