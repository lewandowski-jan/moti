import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moti/core/local_storage.dart';
import 'package:moti/core/router.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/data/activities_service.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/reminders/local_notifications.dart';
import 'package:moti/features/reminders/presentation/motivational_text_generator.dart';
import 'package:moti/features/settings/language/language_cubit.dart';
import 'package:moti/features/settings/theme/theme_cubit.dart';
import 'package:moti/l10n/localizations.dart';
import 'package:moti/l10n/localizations_en.dart';
import 'package:moti/l10n/localizations_pl.dart';
import 'package:provider/provider.dart';

class MTGlobalProviders extends StatelessWidget {
  const MTGlobalProviders({
    super.key,
    required this.activitiesStorage,
    required this.child,
  });

  final LocalStorage activitiesStorage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final systemLocales = WidgetsBinding.instance.platformDispatcher.locales;
    const appLocales = AppLocalizations.supportedLocales;

    return MultiProvider(
      providers: [
        Provider<MTRouter>(
          create: (_) => MTRouter(),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<LocalNotifications>(
          create: (_) => LocalNotifications(
            FlutterLocalNotificationsPlugin(),
          )..init(),
        ),
        Provider<ActivitiesService>(
          create: (_) => ActivitiesService(
            storage: activitiesStorage,
          ),
        ),
        Provider<ActivitiesRepository>(
          create: (context) => ActivitiesRepository(
            service: context.read(),
          ),
        ),
        BlocProvider<ActivitiesCubit>(
          create: (context) => ActivitiesCubit(
            context.read(),
          )..fetchActivitiesData(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit()
            ..init(
              systemLocales: systemLocales,
              appLocales: appLocales,
            ),
        ),
      ],
      child: BlocConsumer<LanguageCubit, Locale?>(
        listener: (context, state) {
          Future<void> check() async {
            final hasScheduledNotifications = await context
                .read<LocalNotifications>()
                .hasScheduledNotifications();

            if (!hasScheduledNotifications) {
              return;
            }

            if (state == const Locale('pl')) {
              return context.read<LocalNotifications>().rescheduleNotifications(
                    AppLocalizationsPl().reminders_reminder_title,
                    () => MotivationalTextGenerator.generate(
                      AppLocalizationsPl(),
                    ),
                  );
            }

            if (state == const Locale('en')) {
              return context.read<LocalNotifications>().rescheduleNotifications(
                    AppLocalizationsEn().reminders_reminder_title,
                    () => MotivationalTextGenerator.generate(
                      AppLocalizationsEn(),
                    ),
                  );
            }
          }

          unawaited(check());
        },
        builder: (context, state) {
          return Localizations(
            locale: state ?? appLocales.first,
            delegates: const [
              ...AppLocalizations.localizationsDelegates,
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            child: Builder(
              builder: (context) {
                return child;
              },
            ),
          );
        },
      ),
    );
  }
}
