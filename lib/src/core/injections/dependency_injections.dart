import 'package:get_it/get_it.dart';
import 'package:habit_tracker_app_task/src/core/services/connectivity_service.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/repositories/habit_repo_imp.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/repository/habit_repo_abstract.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/use_cases/habit_use_cases.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_bloc.dart';

final sl = GetIt.instance;

void initInjections() {
  // Register Services
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  // Register Repositories
  sl.registerLazySingleton<HabitRepository>(() => HabitRepositoryImpl(sl()));

  // Register Use Cases
  sl.registerLazySingleton(() => AddHabitUseCase(sl()));
  sl.registerLazySingleton(() => GetAllHabitsUseCase(sl()));
  sl.registerLazySingleton(() => MarkHabitDoneUseCase(sl()));

  // Register BLoCs
  sl.registerFactory(() => HabitBloc(getHabitsUseCase: sl(), addHabitUseCase: sl(), markHabitAsDoneUseCase: sl()));
}
