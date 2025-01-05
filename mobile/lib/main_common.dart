import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:moti/app.dart';
import 'package:moti/app_configuration.dart';
import 'package:moti/core/local_storage.dart';
import 'package:moti/global_providers/global_providers.dart';
import 'package:path_provider/path_provider.dart';

Future<void> mainCommon(AppConfiguration appConfiguration) async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await Hive.initFlutter();

  final activityStorage = await LocalStorage.init(id: 'activities');
  final weightStorage = await LocalStorage.init(id: 'weights');
  final profileStorage = await LocalStorage.init(id: 'profile');

  runApp(
    MTGlobalProviders(
      activityStorage: activityStorage,
      weightStorage: weightStorage,
      profileStorage: profileStorage,
      child: const MTApp(),
    ),
  );
}
