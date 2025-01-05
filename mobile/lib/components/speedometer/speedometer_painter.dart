import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:moti/components/speedometer/speedometer_properties.dart';
import 'package:moti/core/colors.dart';
import 'package:moti/core/remap.dart';

class SpeedometerPainter extends CustomPainter {
  SpeedometerPainter({
    required this.value,
    required this.properties,
    required this.colors,
    required this.labelStyle,
    required this.locale,
    this.textDirection = TextDirection.ltr,
  });

  final double? value;
  final SpeedometerProperties properties;
  final MTColors colors;
  final TextStyle labelStyle;
  final Locale locale;
  final TextDirection textDirection;

  @override
  bool shouldRepaint(SpeedometerPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.properties != properties ||
        oldDelegate.colors != colors ||
        oldDelegate.labelStyle != labelStyle ||
        oldDelegate.locale != locale ||
        oldDelegate.textDirection != textDirection;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(
      size.width / 2,
      SpeedometerProperties.radius +
          SpeedometerProperties.markSize.height +
          SpeedometerProperties.indicatorExtent +
          SpeedometerProperties.indicatorSize.width / 2,
    );

    _drawMarks(canvas);

    _drawLabels(canvas);

    if (value != null) {
      _drawIndicator(canvas, value!);
    }
  }

  Offset _polarToCartesian({
    required double theta,
    required double radius,
  }) {
    final x = radius * math.cos(theta);
    final y = radius * math.sin(theta);

    return Offset(-x, -y);
  }

  void _drawMarkAtAngle(Canvas canvas, double angle, MTColor color, bool bold) {
    final p1 = _polarToCartesian(
      theta: angle,
      radius: SpeedometerProperties.radius.toDouble() - (bold ? 2 : 0),
    );
    final p2 = _polarToCartesian(
      theta: angle,
      radius:
          SpeedometerProperties.radius + SpeedometerProperties.markSize.height,
    );

    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = SpeedometerProperties.markSize.width
      ..color = color;

    canvas.drawLine(p1, p2, paint);
  }

  double _getAngleForValue(double value) {
    return value.remap(
      SpeedometerProperties.rightAngle,
      SpeedometerProperties.leftAngle,
      inputLowerLimit: properties.minValue,
      inputHigherLimit: properties.maxValue,
    );
  }

  void _drawMarks(Canvas canvas) {
    for (var v = properties.minValue;
        v <= properties.maxValue;
        v += properties.step) {
      final angle = _getAngleForValue(v);

      var opacity = 1.0;
      final bold = v % properties.boldMarkStep == 0;
      if (!bold) {
        opacity = 0.5;
      }

      final color = value != null
          ? properties.colorMapper(v).withOpacity(opacity)
          : colors.primary;

      _drawMarkAtAngle(canvas, angle, color, bold);
    }
  }

  void _drawLabelForValue(Canvas canvas, double value) {
    final text = value.round().toString();

    final textSpan = TextSpan(
      text: text,
      style: labelStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: textDirection,
      textAlign: TextAlign.center,
    )..layout();

    final angle = _getAngleForValue(value);
    final offset = _polarToCartesian(
      theta: angle,
      radius: SpeedometerProperties.radius - 16,
    );

    final textOffset = Offset(
      -textPainter.width / 2,
      -textPainter.height / 2,
    );

    textPainter.paint(canvas, offset + textOffset);
  }

  void _drawLabels(Canvas canvas) {
    for (var v = properties.minValue; v <= properties.maxValue; v++) {
      if (v % properties.labelsStep == 0) {
        _drawLabelForValue(canvas, v);
      }
    }
  }

  void _drawIndicatorAtAngle(Canvas canvas, double angle, MTColor color) {
    final p1 = _polarToCartesian(
      theta: angle,
      radius: SpeedometerProperties.radius.toDouble() -
          SpeedometerProperties.indicatorExtent,
    );
    final p2 = _polarToCartesian(
      theta: angle,
      radius: SpeedometerProperties.radius +
          SpeedometerProperties.markSize.height +
          SpeedometerProperties.indicatorExtent,
    );

    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = SpeedometerProperties.indicatorSize.width + 2
      ..color = color;

    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = SpeedometerProperties.indicatorSize.width
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5)
      ..color = Colors.black.withOpacity(0.1);

    canvas
      ..drawLine(
        Offset(p1.dx + 1, p1.dy + 2),
        Offset(p2.dx + 1, p2.dy + 2),
        shadowPaint,
      )
      ..drawLine(p1, p2, paint);
  }

  void _drawIndicator(Canvas canvas, double value) {
    final v = value.clamp(properties.minValue, properties.maxValue);

    final angle = _getAngleForValue(v);
    final color = properties.colorMapper(v);

    _drawIndicatorAtAngle(canvas, angle, color);
  }
}

Size getCanvasSize() {
  final maxRadius = SpeedometerProperties.radius +
      SpeedometerProperties.markSize.height +
      SpeedometerProperties.indicatorExtent;

  final indicatorThickness = SpeedometerProperties.indicatorSize.width;

  if (SpeedometerProperties.angleRange <= math.pi) {
    final w = 2 * maxRadius * math.sin(SpeedometerProperties.angleRange / 2) +
        indicatorThickness;
    final h = maxRadius * (1 - math.cos(SpeedometerProperties.angleRange / 2)) +
        indicatorThickness +
        SpeedometerProperties.indicatorSize.height *
            math.cos(SpeedometerProperties.angleRange / 2);

    return Size(w, h);
  }

  final w = 2 * maxRadius + indicatorThickness;
  final h = maxRadius +
      maxRadius *
          (math.sin(SpeedometerProperties.angleRange / 2 - math.pi / 2)) +
      indicatorThickness;

  return Size(w, h);
}
