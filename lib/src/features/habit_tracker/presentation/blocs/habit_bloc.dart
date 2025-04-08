import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/use_case/habit_use_cases.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_event.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetAllHabits getHabits;
  final AddHabit addHabit;
  final MarkHabitDone markHabitAsDone;

  HabitBloc({
    required this.getHabits,
    required this.addHabit,
    required this.markHabitAsDone,
  }) : super(HabitInitialState()) {
    on<LoadHabitsEvent>(_onLoadHabits);
    on<AddHabitEvent>(_onAddHabit);
    on<MarkHabitAsDoneEvent>(_onMarkHabitAsDone);
  }

  Future<void> _onLoadHabits(
    LoadHabitsEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoadingState());
    try {
      final habits = await getHabits();
      emit(HabitLoadedState(habits));
    } catch (e) {
      emit(HabitErrorState(e.toString()));
    }
  }

  Future<void> _onAddHabit(
    AddHabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    try {
      final habit = Habit(
        id: '',
        // Leave empty if Firestore auto-generates it
        name: event.name,
        frequency: event.frequency,
        startDate: event.startDate,
        completedDates: [],
        streakCount: 0,
      );

      await addHabit(habit);
      add(LoadHabitsEvent()); // Refresh the list
    } catch (e) {
      emit(HabitErrorState(e.toString()));
    }
  }

  Future<void> _onMarkHabitAsDone(
    MarkHabitAsDoneEvent event,
    Emitter<HabitState> emit,
  ) async {
    try {
      await markHabitAsDone(event.habitId, event.date);
      add(LoadHabitsEvent()); // Refresh the list
    } catch (e) {
      emit(HabitErrorState(e.toString()));
    }
  }
}
