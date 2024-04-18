import 'package:flutter/material.dart';
import 'package:moti/core/local_storage.dart';
import 'package:moti/features/activities/data/activities_service.dart';
import 'package:moti/features/activities/domain/activities_repository.dart';
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
      ],
      child: child,
    );
  }
}
