import 'package:flutter/material.dart';

extension WidgetPadding on Widget {
  Widget withPadding([EdgeInsets padding = const EdgeInsets.all(12)]) {
    return Padding(padding: padding, child: this);
  }

  Widget withMargin([EdgeInsets margin = const EdgeInsets.all(8)]) {
    return Container(margin: margin, child: this);
  }
}
