import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';

class HabitModel extends Habit {
  HabitModel({
    required super.id,
    required super.name,
    required super.frequency,
    required super.startDate,
    required super.streakCount,
    required super.completedDates,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json, String docId) {
    return HabitModel(
      id: docId,
      name: json['name'],
      frequency: json['frequency'],
      startDate: (json['startDate'] as Timestamp).toDate(),
      streakCount: json['streakCount'] ?? 0,
      completedDates: List<DateTime>.from(
        (json['completedDates'] as List).map((e) => (e as Timestamp).toDate()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'frequency': frequency,
      'startDate': startDate,
      'streakCount': streakCount,
      'completedDates': completedDates,
    };
  }
}
