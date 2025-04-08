import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/screens/add_habit_screen.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/screens/habit_list_screen.dart';
import 'package:habit_tracker_app_task/src/shared/presentation/screens/error_screen.dart';
import 'package:habit_tracker_app_task/src/shared/presentation/screens/intro_screen.dart';

class AppRoutes {
  static const introScreen = '/introScreen';
  static const habitListScreen = '/habitListScreen';
  static const addHabitScreen = '/addHabitScreen';
  static const errorScreen = '/errorScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case introScreen:
        return MaterialPageRoute(
          builder: (_) => const IntroScreen(),
          settings: settings,
        );

      case habitListScreen:
        return MaterialPageRoute(
          builder: (_) => const HabitListScreen(),
          settings: settings,
        );

      case addHabitScreen:
        return MaterialPageRoute(
          builder: (_) => const AddHabitScreen(),
          settings: settings,
        );

      case errorScreen:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => ErrorScreen(
            errorMessage: "${AppStrings.noRouteDefinedFor} ${settings.name}",
          ),
        );
    }
  }
}
