import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/colors.dart';
import 'package:moti/core/context.dart';
import 'package:moti/core/routes.dart';
import 'package:moti/l10n/localizations.dart';

class MTBottomNavigationBar extends HookWidget {
  const MTBottomNavigationBar({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  final Tabs currentTab;
  final ValueChanged<Tabs> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: max(0, 40 - bottomPadding)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 300,
                height: 60,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: context.colors.primaryWeak,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              _BottomNavigationBubble(currentTab: currentTab),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: Tabs.values
                      .map(
                        (tab) => _BottomNavigationItem(
                          tab: tab,
                          selected: tab == currentTab,
                          onTap: () => onTabChanged(tab),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends HookWidget {
  const _BottomNavigationItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final Tabs tab;
  final bool selected;
  final VoidCallback onTap;

  static const _colorAnimationDuration = Duration(milliseconds: 300);
  static const _sizeAnimationDuration = Duration(milliseconds: 200);
  static const _animationCurve = Curves.easeIn;

  IconData _getIcon(Tabs tab) {
    switch (tab) {
      case Tabs.home:
        return Icons.home;
      case Tabs.statistics:
        return Icons.bar_chart;
      case Tabs.measurements:
        return Icons.scale;
    }
  }

  String _getBottomNavigationLabel(AppLocalizations l10n, Tabs tab) {
    return switch (tab) {
      Tabs.home => l10n.tab_home,
      Tabs.statistics => l10n.tab_statistics,
      Tabs.measurements => l10n.tab_measurements,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.colors.white : context.colors.primaryWeak;
    final colorTween = MTColorTween(
      begin: color,
      end: color,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIcon(tab),
              color: context.colors.white,
              size: 24,
            ),
            const SizedBox(height: 2),
            AnimatedSize(
              duration: _sizeAnimationDuration,
              curve: _animationCurve,
              alignment: Alignment.topCenter,
              child: SizedOverflowBox(
                alignment: Alignment.topCenter,
                size: Size.fromHeight(selected ? 18 : 0),
                child: FittedBox(
                  child: TweenAnimationBuilder(
                    duration: _colorAnimationDuration,
                    curve: _animationCurve,
                    tween: colorTween,
                    builder: (context, color, _) {
                      return Text(
                        _getBottomNavigationLabel(context.l10n, tab),
                        style: context.textTheme.labelSmall!.copyWith(
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBubble extends StatelessWidget {
  const _BottomNavigationBubble({required this.currentTab});

  final Tabs currentTab;

  static const _animationDuration = Duration(milliseconds: 300);
  static const _animationCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositionedDirectional(
      duration: _animationDuration,
      curve: _animationCurve,
      start: currentTab.index * 100,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
