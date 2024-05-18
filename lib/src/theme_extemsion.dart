import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPopupThemeExtension
    extends ThemeExtension<CustomPopupThemeExtension> {
  final Color? backgroundColor;

  final double width;

  final double borderRadius;

  final double smallSpacing;
  final double defaultSpacing;

  const CustomPopupThemeExtension({
    this.backgroundColor,
    this.width = 200,
    this.borderRadius = 8,
    this.smallSpacing = 4,
    this.defaultSpacing = 8,
  });

  @override
  CustomPopupThemeExtension copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? borderRadius,
    double? smallSpacing,
    double? defaultSpacing,
  }) {
    return CustomPopupThemeExtension(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      width: width ?? this.width,
      borderRadius: borderRadius ?? this.borderRadius,
      smallSpacing: smallSpacing ?? this.smallSpacing,
      defaultSpacing: defaultSpacing ?? this.defaultSpacing,
    );
  }

  @override
  CustomPopupThemeExtension lerp(
      ThemeExtension<CustomPopupThemeExtension>? other, double t) {
    if (other is! CustomPopupThemeExtension) {
      return this;
    }

    return CustomPopupThemeExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      width: lerpDouble(width, other.width, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      smallSpacing: lerpDouble(smallSpacing, other.smallSpacing, t)!,
      defaultSpacing: lerpDouble(defaultSpacing, other.defaultSpacing, t)!,
    );
  }
}
