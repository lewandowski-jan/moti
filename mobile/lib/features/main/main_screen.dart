import 'package:flutter/material.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/components/bottom_navigation_bar.dart';
import 'package:moti/core/routes.dart';
import 'package:moti/features/home/presentation/home_screen.dart';
import 'package:moti/features/measurements/presentation/measurements_screen.dart';
import 'package:moti/features/statistics/presentation/statistics_screen.dart';

class MainScreen extends HookWidget {
  const MainScreen({
    super.key,
    required this.tab,
  });

  final Tabs tab;

  TabController _useTabControllerEffect() {
    final tabController = useTabController(
      initialLength: Tabs.values.length,
      initialIndex: tab.index,
    );

    useEffect(
      () {
        tabController.animateTo(tab.index);

        return null;
      },
      [tab],
    );

    return tabController;
  }

  @override
  Widget build(BuildContext context) {
    final tabController = _useTabControllerEffect();

    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: Tabs.values.map((t) => t.mapToScreen()).toList(),
          ),
          MTBottomNavigationBar(
            currentTab: tab,
            onTabChanged: (tab) => MainRoute(tab: tab).go(context),
          ),
        ],
      ),
    );
  }
}

extension TabScreens on Tabs {
  int get index => Tabs.values.indexOf(this);

  Widget mapToScreen() {
    switch (this) {
      case Tabs.home:
        return const HomeScreen();
      case Tabs.statistics:
        return const StatisticsScreen();
      case Tabs.measurements:
        return const MeasurementsScreen();
    }
  }
}
