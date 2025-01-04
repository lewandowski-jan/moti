import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:moti/core/colors.dart';

enum SpeedometerType {
  motiIndex(2, 0);

  const SpeedometerType(this.step, this.startAnimationAt);

  final double step;
  final double startAnimationAt;
}

typedef ColorMapper = MTColor Function(double value);

class SpeedometerProperties {
  factory SpeedometerProperties.motiIndex(
    MTColors colors,
    SpeedometerType type,
  ) {
    return SpeedometerProperties._(
      minValue: 0,
      maxValue: 100,
      step: type.step,
      labelsStep: 10,
      boldMarkStep: 5,
      colorMapper: (value) {
        if (value <= 20) {
          return colors.error;
        }
        if (value <= 40) {
          return colors.primaryWeak;
        }
        if (value <= 60) {
          return colors.primary;
        }
        if (value <= 80) {
          return colors.accent;
        }

        return colors.success;
      },
      neutralColor: colors.secondaryWeak,
    );
  }

  SpeedometerProperties._({
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.labelsStep,
    required this.boldMarkStep,
    required this.colorMapper,
    required this.neutralColor,
  })  : assert(
          minValue < maxValue,
          'min value $minValue must be smaller than max value $maxValue',
        ),
        assert(
          (maxValue - minValue) % step == 0,
          'Difference between max value ($maxValue) and min value ($minValue) (which equals ${maxValue - minValue}) must be divisible by step $step',
        );

  final double minValue;
  final double maxValue;
  final double step;
  final int labelsStep;
  final int boldMarkStep;
  final ColorMapper colorMapper;
  final MTColor neutralColor;

  double get valueRange => maxValue - minValue;
  int get markCount => valueRange ~/ step;

  double getAdjustedValue(double value) {
    final adjusted = value % step == 0 ? value : value + (step - value % step);

    return adjusted.clamp(minValue, maxValue);
  }

  static const markSize = Size(3, 18);
  static const indicatorSize = Size(5, 26);
  static const radius = 120;
  static const angleRange = math.pi * 21 / 20;
  static const leftAngle = math.pi / 2 + angleRange / 2;
  static const rightAngle = math.pi / 2 - angleRange / 2;

  static double get indicatorExtent =>
      (SpeedometerProperties.indicatorSize.height -
          SpeedometerProperties.markSize.height) /
      2;
}
