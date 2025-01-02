import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moti/features/home/presentation/home_screen.dart';
import 'package:moti/features/profile/presentation/profile_screen.dart';
import 'package:moti/features/settings/settings_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<SettingsRoute>(path: 'settings'),
    TypedGoRoute<ProfileRoute>(path: 'profile'),
  ],
)
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}
