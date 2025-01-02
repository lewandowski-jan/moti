import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moti/core/context.dart';
import 'package:moti/features/settings/language/language_cubit.dart';
import 'package:moti/features/settings/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                return SettingGroup(
                  value: state,
                  header: context.l10n.settings_theme,
                  onChanged: context.read<ThemeCubit>().setTheme,
                  options: [
                    (ThemeMode.system, context.l10n.theme_system),
                    (ThemeMode.dark, context.l10n.theme_dark),
                    (ThemeMode.light, context.l10n.theme_light),
                  ],
                );
              },
            ),
            BlocBuilder<LanguageCubit, Locale?>(
              builder: (context, state) {
                return SettingGroup(
                  value: state,
                  header: context.l10n.settings_language,
                  onChanged: (newLanguage) {
                    context.read<LanguageCubit>().setLanguage(newLanguage);
                  },
                  options: [
                    (const Locale('pl'), context.l10n.language_polish),
                    (const Locale('en'), context.l10n.language_english),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

typedef SettingOption<T> = (T, String);

class SettingGroup<T> extends StatelessWidget {
  const SettingGroup({
    super.key,
    required this.value,
    required this.header,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final String header;
  final List<SettingOption<T>> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: context.textTheme.titleLarge,
        ),
        ...options.map(
          (option) => RadioListTile(
            title: Text(option.$2),
            value: option.$1,
            groupValue: value,
            onChanged: (v) => v != null ? onChanged(v) : null,
          ),
        ),
      ],
    );
  }
}
