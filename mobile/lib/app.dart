import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/context.dart';
import 'package:moti/core/router.dart';
import 'package:moti/core/theme.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/settings/theme/theme_cubit.dart';
import 'package:moti/l10n/localizations.dart';

class MTApp extends HookWidget {
  const MTApp({super.key});

  @override
  Widget build(BuildContext context) {
    useOnAppLifecycleStateChange((previous, current) {
      final wasPaused = previous == AppLifecycleState.paused;
      final wasInactive = previous == AppLifecycleState.inactive;
      final isResumed = current == AppLifecycleState.resumed;
      final isInactive = current == AppLifecycleState.inactive;

      if (isInactive && !wasPaused) {
        // app close
      }

      if ((wasPaused || wasInactive) && isResumed) {
        context.read<ActivitiesCubit>().fetchActivitiesData();
      }
    });

    final themeMode = context.watch<ThemeCubit>().state;
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final iOSBrightness = themeMode.iOSBrightness(platformBrightness);
    final androidBrightness = themeMode.androidBrightness(platformBrightness);

    final locale = context.locale;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: iOSBrightness,
        statusBarIconBrightness: androidBrightness,
        systemNavigationBarIconBrightness: androidBrightness,
      ),
      child: MaterialApp.router(
        theme: MTTheme.light(context),
        darkTheme: MTTheme.dark(context),
        themeMode: themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        routerConfig: context.read<MTRouter>().router,
      ),
    );
  }
}
