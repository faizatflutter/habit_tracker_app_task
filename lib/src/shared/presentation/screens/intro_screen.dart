import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';

class IntroScreen extends StatelessWidget {
  final String? errorMessage;

  const IntroScreen({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage ?? AppStrings.somethingWentWrong),
      ),
    );
  }
}
