import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/core/injections/dependency_injections.dart';
import 'package:habit_tracker_app_task/src/core/routing/app_routes.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_bloc.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp();

  // Set up dependency injection
  initInjections();

  runApp(const MiniHabitApp());
}

class MiniHabitApp extends StatelessWidget {
  const MiniHabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitBloc>(
          create: (context) => sl<HabitBloc>()..add(LoadHabitsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.introScreen,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
