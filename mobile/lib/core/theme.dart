import 'package:flutter/material.dart';
import 'package:moti/core/colors.dart';

sealed class MTTheme {
  static ThemeData light(BuildContext context) {
    const brightness = Brightness.light;

    return _build(
      context: context,
      primary: MTColors.ofBrightness(brightness).primary,
      secondary: MTColors.ofBrightness(brightness).secondary,
      lighterText: MTColors.ofBrightness(brightness).white,
      darkerText: MTColors.ofBrightness(brightness).black,
      surface: MTColors.ofBrightness(brightness).background,
      error: MTColors.ofBrightness(brightness).error,
      onError: MTColors.ofBrightness(brightness).white,
      brightness: brightness,
    );
  }

  static ThemeData dark(BuildContext context) {
    const brightness = Brightness.dark;

    return _build(
      context: context,
      primary: MTColors.ofBrightness(brightness).primary,
      secondary: MTColors.ofBrightness(brightness).secondary,
      lighterText: MTColors.ofBrightness(brightness).black,
      darkerText: MTColors.ofBrightness(brightness).white,
      surface: MTColors.ofBrightness(brightness).background,
      error: MTColors.ofBrightness(brightness).error,
      onError: MTColors.ofBrightness(brightness).white,
      brightness: brightness,
    );
  }

  static ThemeData _build({
    required BuildContext context,
    required Brightness brightness,
    required MTColor primary,
    required MTColor secondary,
    required MTColor lighterText,
    required MTColor darkerText,
    required MTColor surface,
    required MTColor error,
    required MTColor onError,
  }) {
    final defaultTextColor = brightness == Brightness.dark
        ? MTColors.ofBrightness(brightness).white
        : MTColors.ofBrightness(brightness).black;

    return ThemeData.from(
      colorScheme: ColorScheme(
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: error,
        onPrimary: lighterText,
        onSecondary: darkerText,
        onSurface: darkerText,
        onError: onError,
        brightness: brightness,
      ),
    ).copyWith(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      scaffoldBackgroundColor: surface,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 96,
          color: defaultTextColor,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: TextStyle(
          color: defaultTextColor,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          fontFamily: 'Poppins',
        ),
        displaySmall: TextStyle(
          color: defaultTextColor,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        headlineLarge: TextStyle(
          color: defaultTextColor,
          fontSize: 36,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        headlineMedium: TextStyle(
          color: defaultTextColor,
          fontSize: 32,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        headlineSmall: TextStyle(
          color: defaultTextColor,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        titleLarge: TextStyle(
          color: defaultTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        titleMedium: TextStyle(
          color: defaultTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        titleSmall: TextStyle(
          color: defaultTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        bodyLarge: TextStyle(
          color: defaultTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        bodyMedium: TextStyle(
          color: defaultTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        labelLarge: TextStyle(
          color: defaultTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        bodySmall: TextStyle(
          color: defaultTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        labelSmall: TextStyle(
          color: defaultTextColor,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
