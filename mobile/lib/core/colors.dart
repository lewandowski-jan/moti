import 'package:flutter/material.dart';

class MTColor extends Color {
  const MTColor._(super.value);

  MTColor._color(Color color) : super(color.value);

  MTColor alphaBlend(MTColor background) {
    return MTColor._color(Color.alphaBlend(this, background));
  }

  @override
  MTColor withOpacity(double opacity) {
    return MTColor._color(super.withOpacity(opacity));
  }
}

class MTColorTween extends Tween<MTColor> {
  MTColorTween({super.begin, super.end});

  @override
  MTColor lerp(double t) => MTColor._color(Color.lerp(begin, end, t)!);
}

abstract class MTColors {
  const MTColors._();

  static MTColors of(BuildContext context) =>
      MTColors.ofBrightness(Theme.of(context).brightness);

  static MTColors ofBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return const _ColorsLight();
      case Brightness.dark:
        return const _ColorsDark();
    }
  }

  MTColor get white => MTColor._(Colors.white.value);
  MTColor get black => MTColor._(Colors.black.value);
  MTColor get transparent => MTColor._(Colors.transparent.value);

  MTColor get primary;
  MTColor get primaryWeak;

  MTColor get secondary;
  MTColor get secondaryWeak;

  MTColor get accent;

  MTColor get error;
  MTColor get success;

  MTColor get background;
  MTColor get onBackground;
}

class _ColorsLight extends MTColors {
  const _ColorsLight() : super._();

  @override
  MTColor get accent => const MTColor._(0xFF99FE63);

  @override
  MTColor get background => const MTColor._(0xFFF1F6FF);

  @override
  MTColor get error => const MTColor._(0xFFFE655C);

  @override
  MTColor get primary => const MTColor._(0xFF6399FE);

  @override
  MTColor get primaryWeak => const MTColor._(0xFF9FC1FE);

  @override
  MTColor get secondary => const MTColor._(0xFFFE6399);

  @override
  MTColor get secondaryWeak => const MTColor._(0xFFFEADC9);

  @override
  MTColor get success => const MTColor._(0xFF5CFEA6);

  @override
  MTColor get onBackground => black;
}

class _ColorsDark extends MTColors {
  const _ColorsDark() : super._();

  @override
  MTColor get accent => const MTColor._(0xFF2AFC85);

  @override
  MTColor get background => const MTColor._(0xFF121212);

  @override
  MTColor get error => const MTColor._(0xFFCF6679);

  @override
  MTColor get primary => const MTColor._(0xFF1A73E8);

  @override
  MTColor get primaryWeak => const MTColor._(0xFF43609B);

  @override
  MTColor get secondary => const MTColor._(0xFFE91E63);

  @override
  MTColor get secondaryWeak => const MTColor._(0xFF7E0F40);

  @override
  MTColor get success => const MTColor._(0xFF66BB6A);

  @override
  MTColor get onBackground => white;
}
