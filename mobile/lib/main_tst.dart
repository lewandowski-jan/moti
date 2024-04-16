import 'package:moti/app_configuration.dart';
import 'package:moti/main_common.dart';

Future<void> main() => mainCommon(
      const AppConfiguration(environment: Environment.tst),
    );
