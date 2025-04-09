import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/core/extensions/context_extensions.dart';
import 'package:habit_tracker_app_task/src/core/extensions/widget_extensions.dart';
import 'package:habit_tracker_app_task/src/core/routing/app_routes.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      Future.delayed(const Duration(seconds: 2), () {
        context.navigateWithName(AppRoutes.habitListScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator().withPaddingAll(),
            Text(AppStrings.appName, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
