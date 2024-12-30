import 'package:flutter/material.dart';
import 'package:flutter_comms/flutter_comms.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LanguageCubit extends HydratedCubit<Locale?> with StateSender {
  LanguageCubit() : super(null);

  Future<void> init({
    required List<Locale> systemLocales,
    required List<Locale> appLocales,
  }) async {
    if (state != null) {
      return;
    }

    final resolvedLocale = basicLocaleListResolution(
      systemLocales,
      appLocales,
    );

    emit(resolvedLocale);
  }

  void setLanguage(Locale? locale) {
    emit(locale);
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    final value = json['Language'];

    return Locale(value);
  }

  @override
  Map<String, dynamic>? toJson(Locale? state) {
    return {
      'Language': state?.toLanguageTag(),
    };
  }
}
