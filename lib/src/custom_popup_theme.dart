import 'dart:ui';

import 'package:custom_popup/custom_popup.dart';
import 'package:flutter/material.dart';

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

  /// The radius of the corners of the popup menu's button.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSmallBorderRadius].
  final double buttonRadius;

  /// The radius of the corners of the popup menu's large elements.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultBorderRadius].
  final double borderRadius;

  /// The spacing between the button in the popup menu.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSmallSpacing].
  final double itemSpacing;

  /// The spacing between default elements in the popup menu.
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSpacing].
  final double spacing;

  /// The padding of the button to open the popup
  ///
  /// Defaults to [CustomPopupThemeDefaults.defaultSmallSpacing].
  final double buttonPadding;

  const CustomPopupTheme({
    this.backgroundColor,
    this.position = CustomPopupPosition.relative,
    this.buttonTheme = const CustomPopupButtonTheme(),
    this.width = CustomPopupThemeDefaults.defaultWidth,
    this.buttonRadius = CustomPopupThemeDefaults.defaultSmallBorderRadius,
    this.borderRadius = CustomPopupThemeDefaults.defaultBorderRadius,
    this.itemSpacing = CustomPopupThemeDefaults.defaultSmallSpacing,
    this.spacing = CustomPopupThemeDefaults.defaultSpacing,
    this.buttonPadding = CustomPopupThemeDefaults.defaultSmallSpacing,
  });

  @override
  CustomPopupTheme copyWith({
    Color? backgroundColor,
    CustomPopupPosition? position,
    CustomPopupButtonTheme? buttonTheme,
    double? width,
    double? buttonRadius,
    double? borderRadius,
    double? itemSpacing,
    double? spacing,
    double? buttonPadding,
  }) {
    return CustomPopupTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      position: position ?? this.position,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      width: width ?? this.width,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      borderRadius: borderRadius ?? this.borderRadius,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      spacing: spacing ?? this.spacing,
      buttonPadding: buttonPadding ?? this.buttonPadding,
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
      buttonRadius: lerpDouble(
        buttonRadius,
        other.buttonRadius,
        t,
      )!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      itemSpacing: lerpDouble(itemSpacing, other.itemSpacing, t)!,
      spacing: lerpDouble(spacing, other.spacing, t)!,
      buttonPadding: lerpDouble(buttonPadding, other.buttonPadding, t)!,
    );
  }

  CustomPopupTheme.fallback() : this();
}

class CustomPopupButtonTheme extends ThemeExtension<CustomPopupButtonTheme> {
  /// Foreground color of the button. If null, the default color is used.
  final Color? foregroundColor;

  /// Background color of the button. If null, the default color is used.
  final Color? backgroundColor;

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
    ThemeExtension<CustomPopupButtonTheme>? other,
    double t,
  ) {
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
