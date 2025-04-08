import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/use_cases/habit_use_cases.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_event.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetAllHabitsUseCase getHabitsUseCase;
  final AddHabitUseCase addHabitUseCase;
  final MarkHabitDoneUseCase markHabitAsDoneUseCase;

  HabitBloc({
    required this.getHabitsUseCase,
    required this.addHabitUseCase,
    required this.markHabitAsDoneUseCase,
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

    final result = await getHabitsUseCase();

    result.fold(
      (failure) => emit(HabitErrorState(failure.message)),
      (habits) => emit(HabitLoadedState(habits)),
    );
  }

  Future<void> _onAddHabit(
    AddHabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    final habit = Habit(
      id: '',
      // Firestore will generate it
      name: event.name,
      frequency: event.frequency,
      startDate: event.startDate,
      completedDates: [],
      streakCount: 0,
    );

    final result = await addHabitUseCase(habit);

    result.fold(
      (failure) => emit(HabitErrorState(failure.message)),
      (_) => add(LoadHabitsEvent()),
    );
  }

  Future<void> _onMarkHabitAsDone(
    MarkHabitAsDoneEvent event,
    Emitter<HabitState> emit,
  ) async {
    final result = await markHabitAsDoneUseCase(event.habitId, event.date);

    result.fold(
      (failure) => emit(HabitErrorState(failure.message)),
      (_) => add(LoadHabitsEvent()),
    );
  }
}
