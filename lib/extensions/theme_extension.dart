import 'package:custom_popup/custom_popup.dart';
import 'package:flutter/material.dart';

extension CustomPopupThemeExtension on BuildContext {
  CustomPopupTheme get customPopupTheme =>
      Theme.of(this).extension<CustomPopupTheme>() ??
      CustomPopupTheme.fallback();
}
