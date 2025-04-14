import 'package:flutter/material.dart';

extension StyleExtension on BuildContext {
  TextTheme get styles => Theme.of(this).textTheme;
}
