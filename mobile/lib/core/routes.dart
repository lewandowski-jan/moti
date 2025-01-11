import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moti/features/activities/presentation/add_activity_screen.dart';
import 'package:moti/features/main/main_screen.dart';
import 'package:moti/features/profile/presentation/profile_screen.dart';
import 'package:moti/features/settings/settings_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

@TypedGoRoute<AddActivityRoute>(path: '/add-activity')
class AddActivityRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AddActivityScreen();
}

enum Tabs { home, statistics, measurements }

@TypedGoRoute<MainRoute>(
  path: '/:tab',
)
class MainRoute extends GoRouteData {
  MainRoute({required this.tab});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MainScreen(tab: tab);

  final Tabs tab;
}
