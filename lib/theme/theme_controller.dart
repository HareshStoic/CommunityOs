import 'package:flutter/material.dart';

/// Global theme mode — any widget can read or change this directly,
/// with no need to pass onThemeChanged through constructors.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);