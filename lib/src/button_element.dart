import 'package:custom_popup/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

sealed class CustomPopupMenuElement extends Widget {
  const CustomPopupMenuElement(this.calculateWidgetHeight, {super.key});

  final double Function(BuildContext context) calculateWidgetHeight;
}

class CustomPopupButtonItem extends StatelessWidget
    implements CustomPopupMenuElement {
  /// The label of the button
  final String label;

  /// The icon of the button
  final Widget icon;

  /// The function that is called when the button is pressed
  final void Function() onTap;

  /// The height of the button, default is 35
  final double height;

  /// A button in the popup
  const CustomPopupButtonItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.height = 35,
  });

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme = context.customPopupTheme;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.all(
              Radius.circular(customPopupButtonTheme.smallBorderRadius),
            ),
            child: Padding(
              padding: EdgeInsets.all(customPopupButtonTheme.smallSpacing),
              child: Row(
                children: [
                  IconTheme(
                    data: const IconThemeData(
                      size: 18,
                    ),
                    child: icon,
                  ),
                  SizedBox(width: customPopupButtonTheme.defaultSpacing),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double Function(BuildContext context) get calculateWidgetHeight =>
      (_) => height;
}

class CustomPopupMenuDivider extends StatelessWidget
    implements CustomPopupMenuElement {
  /// The height of the divider. Default to 1
  final double height;

  /// Used to divide the items in the menu
  const CustomPopupMenuDivider({
    super.key,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme = context.customPopupTheme;

    return Container(
      height: height,
      margin: EdgeInsets.all(customPopupButtonTheme.smallSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius:
            BorderRadius.circular(customPopupButtonTheme.borderRadius),
      ),
    );
  }

  @override
  double Function(BuildContext context) get calculateWidgetHeight =>
      (context) => height + context.customPopupTheme.smallSpacing * 2;
}
