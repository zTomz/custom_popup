import 'package:flutter/material.dart';

import '../src/custom_popup_theme.dart';

extension CustomPopupThemeExtension on BuildContext {
  CustomPopupTheme get customPopupTheme =>
      Theme.of(this).extension<CustomPopupTheme>() ??
      CustomPopupTheme.fallback();
}
