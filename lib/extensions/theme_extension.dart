import 'package:custom_popup/src/custom_popup_theme.dart';
import 'package:flutter/material.dart';

extension CustomPopupThemeExtension on BuildContext {
  CustomPopupTheme get customPopupTheme =>
      Theme.of(this).extension<CustomPopupTheme>() ??
      const CustomPopupTheme.fallback();
}
