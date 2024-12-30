import 'package:go_router/go_router.dart';
import 'package:moti/core/routes.dart';

class MTRouter {
  MTRouter();

  late final GoRouter router = GoRouter(
    initialLocation: HomeRoute().location,
    routes: $appRoutes,
  );

  void dispose() {
    router.dispose();
  }
}
