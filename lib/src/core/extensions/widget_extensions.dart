import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_constants.dart';

extension WidgetPadding on Widget {
  Widget withPaddingAll([EdgeInsets padding = const EdgeInsets.all(AppConstants.contentPadding)]) {
    return Padding(padding: padding, child: this);
  }

  Widget withPaddingHorizontal(double hPadding) {
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: hPadding);
    return Padding(padding: padding, child: this);
  }

  Widget withPaddingVertical(double vPadding) {
    EdgeInsets padding = EdgeInsets.symmetric(vertical: vPadding);
    return Padding(padding: padding, child: this);
  }

  Widget withMargin([EdgeInsets margin = const EdgeInsets.all(AppConstants.contentMargin)]) {
    return Container(margin: margin, child: this);
  }
}
