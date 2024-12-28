import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moti/core/local_storage.dart';
import 'package:moti/features/activities/application/activities_cubit.dart';
import 'package:moti/features/activities/data/activities_service.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
import 'package:moti/features/reminders/local_notifications.dart';
import 'package:provider/provider.dart';

class MtGlobalProviders extends StatelessWidget {
  const MtGlobalProviders({
    super.key,
    required this.activitiesStorage,
    required this.child,
  });

  final LocalStorage activitiesStorage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      ],
      child: child,
    );
  }
}
