import 'package:flutter/material.dart';
import 'package:moti/components/speedometer/speedometer_painter.dart';
import 'package:moti/components/speedometer/speedometer_properties.dart';
import 'package:moti/core/context.dart';

class Speedometer extends StatelessWidget {
  const Speedometer({
    super.key,
    required this.type,
    required this.animated,
    this.value,
  });

  final SpeedometerType type;
  final int? value;
  final bool animated;

  static const _duration = Duration(seconds: 1);
  static const _curve = Curves.easeInOut;

  void _onEnd(BuildContext context) {
    // no-op
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final properties = SpeedometerProperties.motiIndex(colors, type);

    final canvasSize = getCanvasSize();

    final endAnimationAt = properties.getAdjustedValue(value?.toDouble() ?? 0);

    final startAnimationAt = animated
        ? type.startAnimationAt * properties.valueRange + properties.minValue
        : endAnimationAt;

    final tween = Tween<double>(
      begin: startAnimationAt,
      end: endAnimationAt,
    );

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: tween,
              duration: _duration,
              curve: _curve,
              onEnd: () => _onEnd(context),
              builder: (context, v, _) {
                return CustomPaint(
                  painter: SpeedometerPainter(
                    properties: properties,
                    value: value != null ? v : null,
                    colors: colors,
                    labelStyle: context.textTheme.bodySmall!.copyWith(
                      color: colors.onBackground,
                    ),
                    locale: context.locale,
                  ),
                  size: canvasSize,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Text(
                value.toString(),
                style: context.textTheme.displayMedium,
              ),
            ),
          ],
        ),
        Text(
          context.l10n.moti_index,
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
