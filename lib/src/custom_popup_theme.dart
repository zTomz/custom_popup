import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:custom_popup/custom_popup.dart';

class CustomPopupTheme extends ThemeExtension<CustomPopupTheme> {
  /// Background color of the popup menu.
  ///
  /// If null, the default color scheme's surface color is used.
  final Color? backgroundColor;

  /// The position of the popup menu.
  ///
  /// Defaults to [CustomPopupPosition.relative].
  final CustomPopupPosition position;

  /// The theme of the button inside the popup menu.
  ///
  /// Defaults to [CustomPopupButtonTheme].
  final CustomPopupButtonTheme buttonTheme;

  /// The width of the popup menu.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultWidth].
  final double width;

  /// The radius of the corners of the popup menu's small elements.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSmallBorderRadius].
  final double smallBorderRadius;

  /// The radius of the corners of the popup menu's large elements.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultBorderRadius].
  final double borderRadius;

  /// The spacing between small elements in the popup menu.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSmallSpacing].
  final double smallSpacing;

  /// The spacing between default elements in the popup menu.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSpacing].
  final double defaultSpacing;

  const CustomPopupTheme({
    this.backgroundColor,
    this.position = CustomPopupPosition.relative,
    this.buttonTheme = const CustomPopupButtonTheme(),
    this.width = CustomPopupThemeDefaults.defaultWidth,
    this.smallBorderRadius = CustomPopupThemeDefaults.defaultSmallBorderRadius,
    this.borderRadius = CustomPopupThemeDefaults.defaultBorderRadius,
    this.smallSpacing = CustomPopupThemeDefaults.defaultSmallSpacing,
    this.defaultSpacing = CustomPopupThemeDefaults.defaultSpacing,
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
  CustomPopupTheme lerp(ThemeExtension<CustomPopupTheme>? other, double t) {
    if (other is! CustomPopupTheme) {
      return this;
    }

    return CustomPopupTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      position: other.position,
      buttonTheme: buttonTheme.lerp(other.buttonTheme, t),
      width: lerpDouble(width, other.width, t)!,
      smallBorderRadius: lerpDouble(
        smallBorderRadius,
        other.smallBorderRadius,
        t,
      )!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      smallSpacing: lerpDouble(smallSpacing, other.smallSpacing, t)!,
      defaultSpacing: lerpDouble(defaultSpacing, other.defaultSpacing, t)!,
    );
  }

  CustomPopupTheme.fallback() : this();
}

class CustomPopupButtonTheme extends ThemeExtension<CustomPopupButtonTheme> {
  /// Background color of the button. If null, the default color is used.
  final Color? backgroundColor;

  /// Foreground color of the button. If null, the default color is used.
  final Color? foregroundColor;

  /// Padding of the button.
  /// The default padding is [CustomPopupThemeDefaults.defaultSmallSpacing].
  final double padding;

  /// Spacing between the button and its child.
  /// The default spacing is 2.
  final double spacing;

  /// Border radius of the button.
  /// The default border radius is [CustomPopupThemeDefaults.defaultSmallBorderRadius].
  final double borderRadius;

  const CustomPopupButtonTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.padding = CustomPopupThemeDefaults.defaultSmallSpacing,
    this.spacing = 2,
    this.borderRadius = CustomPopupThemeDefaults.defaultSmallBorderRadius,
  });

  @override
  CustomPopupButtonTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? padding,
    double? spacing,
    double? borderRadius,
  }) {
    return CustomPopupButtonTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      padding: padding ?? this.padding,
      spacing: spacing ?? this.spacing,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  CustomPopupButtonTheme lerp(
      ThemeExtension<CustomPopupButtonTheme>? other, double t) {
    if (other is! CustomPopupButtonTheme) {
      return this;
    }

    return CustomPopupButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      padding: lerpDouble(padding, other.padding, t)!,
      spacing: lerpDouble(spacing, other.spacing, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
    );
  }
}

sealed class CustomPopupThemeDefaults {
  static const double defaultWidth = 200;
  static const double defaultSmallBorderRadius = 4;
  static const double defaultBorderRadius = 8;
  static const double defaultSmallSpacing = 4;
  static const double defaultSpacing = 8;
}
