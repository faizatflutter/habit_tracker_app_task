import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_tracker_app_task/src/core/services/connectivity_service.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/data_sources/remote_data_source.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/data/repositories/habit_repo_imp.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/repository/habit_repo_abstract.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/use_cases/habit_use_cases.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_bloc.dart';

final sl = GetIt.instance;

void initInjections() {
  // Third Party Services
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Register Services
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // Registering DateSources
  sl.registerLazySingleton<HabitRemoteDataSource>(() => HabitRemoteDataSourceImpl(sl()));

  // Register Repositories
  sl.registerLazySingleton<HabitRepository>(() => HabitRepositoryImpl(sl()));

  // Register Use Cases
  sl.registerLazySingleton(() => AddHabitUseCase(sl()));
  sl.registerLazySingleton(() => GetAllHabitsUseCase(sl()));
  sl.registerLazySingleton(() => MarkHabitDoneUseCase(sl()));

  // Register BLoCs
  sl.registerFactory(() => HabitBloc(getHabitsUseCase: sl(), addHabitUseCase: sl(), markHabitAsDoneUseCase: sl()));
}
