import 'dart:ui';

import 'package:custom_popup/custom_popup.dart';
import 'package:flutter/material.dart';

class CustomPopupTheme
    extends ThemeExtension<CustomPopupTheme> {
  final Color? backgroundColor;

  final CustomPopupPosition position;

  final double width;

  final double smallBorderRadius;
  final double borderRadius;

  final double smallSpacing;
  final double defaultSpacing;

  const CustomPopupTheme({
    this.backgroundColor,
    this.position = CustomPopupPosition.relative,
    this.width = 200,
    this.smallBorderRadius = 4,
    this.borderRadius = 8,
    this.smallSpacing = 4,
    this.defaultSpacing = 8,
  });

  @override
  CustomPopupTheme copyWith({
    Color? backgroundColor,
    CustomPopupPosition? position,
    double? width,
    double? smallBorderRadius,
    double? borderRadius,
    double? smallSpacing,
    double? defaultSpacing,
  }) {
    return CustomPopupTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      position: position ?? this.position,
      width: width ?? this.width,
      smallBorderRadius: smallBorderRadius ?? this.smallBorderRadius,
      borderRadius: borderRadius ?? this.borderRadius,
      smallSpacing: smallSpacing ?? this.smallSpacing,
      defaultSpacing: defaultSpacing ?? this.defaultSpacing,
    );
  }

  @override
  CustomPopupTheme lerp(
      ThemeExtension<CustomPopupTheme>? other, double t) {
    if (other is! CustomPopupTheme) {
      return this;
    }

    return CustomPopupTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      position: other.position,
      width: lerpDouble(width, other.width, t)!,
      smallBorderRadius:
          lerpDouble(smallBorderRadius, other.smallBorderRadius, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      smallSpacing: lerpDouble(smallSpacing, other.smallSpacing, t)!,
      defaultSpacing: lerpDouble(defaultSpacing, other.defaultSpacing, t)!,
    );
  }

  static CustomPopupTheme fallback() =>
      const CustomPopupTheme();
}
