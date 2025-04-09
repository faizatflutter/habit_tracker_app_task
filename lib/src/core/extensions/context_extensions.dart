import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_colors.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  ThemeData get theme => Theme.of(this);

  navigateWithName(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  navigateAndReplaceWithName(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }

  // Snackbar

  showSnackBarMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppStyles.errorColor : AppStyles.successColor,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
