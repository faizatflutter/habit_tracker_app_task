import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_constants.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/models/habit_model.dart';

abstract class HabitRemoteDataSource {
  Future<void> addHabit(HabitModel habit);

  Future<List<HabitModel>> getAllHabits();

  Future<void> markHabitAsDone(String habitId, DateTime date);
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final FirebaseFirestore firestore;

  HabitRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addHabit(HabitModel habit) async {
    await firestore.collection(AppConstants.habitCollectionName).add(habit.toJson());
  }

  @override
  Future<List<HabitModel>> getAllHabits() async {
    final snapshot = await firestore.collection(AppConstants.habitCollectionName).get();
    return snapshot.docs.map((doc) => HabitModel.fromJson(doc.data(), doc.id)).toList();
  }

  @override
  Future<void> markHabitAsDone(String habitId, DateTime date) async {
    final docRef = firestore.collection(AppConstants.habitCollectionName).doc(habitId);

    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        throw Exception(AppStrings.habitNotFound);
      }
      final habitModel = HabitModel.fromJson(snapshot.data()!, snapshot.id);

      final completedDates = List<DateTime>.from(habitModel.completedDates);
      completedDates.add(date);

      final streakCount = habitModel.streakCount + 1;
      // Update Firestore with updated values
      transaction.update(docRef, {
        'completedDates': completedDates.map((e) => Timestamp.fromDate(e)).toList(),
        'streakCount': streakCount,
      });
    });
  }
}
