import 'package:flutter/material.dart';

import '../core/theme/colors.dart';
import '../core/theme/fontsize.dart';

ThemeData customTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(successColor),
    surface: Colors.white,
  ),
  primaryColor: const Color(successColor),
  primaryColorDark: const Color(primaryColorDark),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(textColor)),
    displayMedium: TextStyle(color: Color(textColor)),
    displaySmall: TextStyle(color: Color(textColor)),
    headlineLarge: TextStyle(color: Color(textColor)),
    headlineMedium: TextStyle(color: Color(textColor)),
    headlineSmall: TextStyle(color: Color(textColor)),
    titleLarge: TextStyle(color: Color(textColor)),
    titleMedium: TextStyle(color: Color(textColor)),
    titleSmall: TextStyle(color: Color(textColor)),
    bodyLarge: TextStyle(color: Color(textColor)),
    bodyMedium: TextStyle(color: Color(textColor)),
    bodySmall: TextStyle(color: Color(textColor)),
    labelLarge: TextStyle(color: Color(textColor)),
    labelMedium: TextStyle(color: Color(textColor)),
    labelSmall: TextStyle(color: Color(textColor)),
  ),
  fontFamily: fontFamily,
);
