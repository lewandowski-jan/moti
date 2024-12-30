import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

extension ThemeModeX on ThemeMode {
  Map<String, dynamic> toJson() {
    return switch (this) {
      ThemeMode.system => {'ThemeMode': 'system'},
      ThemeMode.light => {'ThemeMode': 'light'},
      ThemeMode.dark => {'ThemeMode': 'dark'}
    };
  }

  static ThemeMode? fromJson(Map<String, dynamic> json) {
    final value = json['ThemeMode'];

    switch (value) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
    }

    return null;
  }

  Brightness iOSBrightness(Brightness platformBrightness) {
    if (this == ThemeMode.system) {
      return platformBrightness;
    }

    if (this == ThemeMode.dark) {
      return Brightness.dark;
    }

    return Brightness.light;
  }

  Brightness androidBrightness(Brightness platformBrightness) {
    if (this == ThemeMode.system) {
      if (platformBrightness == Brightness.dark) {
        return Brightness.light;
      }

      return Brightness.dark;
    }

    if (this == ThemeMode.dark) {
      return Brightness.light;
    }

    return Brightness.dark;
  }
}

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void setTheme(ThemeMode setting) => emit(setting);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) => ThemeModeX.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => state.toJson();
}
