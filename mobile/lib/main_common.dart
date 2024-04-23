import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moti/app.dart';
import 'package:moti/app_configuration.dart';
import 'package:moti/core/local_storage.dart';
import 'package:moti/global_providers/global_providers.dart';

Future<void> mainCommon(AppConfiguration appConfiguration) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final activitiesStorage = await LocalStorage.init(id: 'activities');

  runApp(
    MtGlobalProviders(
      activitiesStorage: activitiesStorage,
      child: const MtApp(),
    ),
  );
}
