import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext{
  Color get primaryColor=>Theme.of(this).colorScheme.primary;
  Color get secondaryColor=>Theme.of(this).colorScheme.secondary;
  ThemeData get themeData=>Theme.of(this);
  TextTheme get textTheme=>Theme.of(this).textTheme;
  double get width=>MediaQuery.of(this).size.width;
  double get height=>MediaQuery.of(this).size.height;
}