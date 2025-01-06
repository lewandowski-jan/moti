import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moti/core/local_storage.dart';
import 'package:moti/core/router.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/data/activity_service.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/home/application/moti_index_cubit.dart';
import 'package:moti/features/measurements/data/weight_service.dart';
import 'package:moti/features/measurements/domain/weight_repository.dart';
import 'package:moti/features/profile/application/profile_cubit.dart';
import 'package:moti/features/profile/data/profile_service.dart';
import 'package:moti/features/profile/domain/profile_repository.dart';
import 'package:moti/features/reminders/local_notifications.dart';
import 'package:moti/features/reminders/presentation/motivational_text_generator.dart';
import 'package:moti/features/settings/language/language_cubit.dart';
import 'package:moti/features/settings/theme/theme_cubit.dart';
import 'package:moti/features/statistics/application/statistics_cubit.dart';
import 'package:moti/l10n/localizations.dart';
import 'package:moti/l10n/localizations_en.dart';
import 'package:moti/l10n/localizations_pl.dart';
import 'package:provider/provider.dart';

class MTGlobalProviders extends StatelessWidget {
  const MTGlobalProviders({
    super.key,
    required this.activityStorage,
    required this.weightStorage,
    required this.profileStorage,
    required this.child,
  });

  final LocalStorage activityStorage;
  final LocalStorage weightStorage;
  final LocalStorage profileStorage;
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
        Provider<ActivityService>(
          create: (_) => ActivityService(
            storage: activityStorage,
          ),
        ),
        Provider<WeightService>(
          create: (_) => WeightService(
            storage: weightStorage,
          ),
        ),
        Provider<ProfileService>(
          create: (_) => ProfileService(
            profileStorage: profileStorage,
          ),
        ),
        Provider<ActivitiesRepository>(
          create: (context) => ActivitiesRepository(
            activityService: context.read(),
          ),
        ),
        Provider<WeightRepository>(
          create: (context) => WeightRepository(
            weightService: context.read(),
          ),
        ),
        Provider<ProfileRepository>(
          create: (context) => ProfileRepository(
            profileService: context.read(),
          ),
        ),
        BlocProvider<ActivitiesCubit>(
          create: (context) => ActivitiesCubit(
            activitiesRepository: context.read(),
            weightRepository: context.read(),
            profileRepository: context.read(),
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
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            weightRepository: context.read(),
            profileRepository: context.read(),
          )..init(),
        ),
        BlocProvider<MotiIndexCubit>(
          create: (context) => MotiIndexCubit(
            activitiesRepository: context.read(),
            profileRepository: context.read(),
          )..load(),
        ),
        BlocProvider<StatisticsCubit>(
          create: (context) => StatisticsCubit(
            activitiesRepository: context.read(),
          )..load(),
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
