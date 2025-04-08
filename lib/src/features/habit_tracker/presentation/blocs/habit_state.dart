import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';

abstract class HabitState {}

class HabitInitialState extends HabitState {}

class HabitLoadingState extends HabitState {}

class HabitLoadedState extends HabitState {
  final List<Habit> habits;

  HabitLoadedState(this.habits);
}

class HabitErrorState extends HabitState {
  final String message;

  HabitErrorState(this.message);
}

class HabitUpdatedState extends HabitState {}