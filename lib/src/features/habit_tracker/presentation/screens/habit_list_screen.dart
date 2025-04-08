import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/core/extensions/widget_extensions.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator().withPadding(),
            Text(AppStrings.appName, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
