import 'package:custom_popup/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

sealed class CustomPopupMenuElement extends Widget {
  const CustomPopupMenuElement(this.calculateWidgetHeight, {super.key});

  final double Function(BuildContext context) calculateWidgetHeight;
}

class CustomPopupMenuItem extends StatelessWidget
    implements CustomPopupMenuElement {
  /// The label of the button
  final String label;

  /// The icon of the button
  final Widget icon;

  /// The function that is called when the button is pressed
  final void Function() onTap;

  /// The height of the button, default is 35
  final double height;

  /// The space between the icon and the label
  final double? spacing;

  /// The foreground color of the button
  final Color? foregroundColor;

  /// The background color of the button
  final Color? backgroundColor;

  /// A button in the popup
  const CustomPopupMenuItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.height = 35,
    this.spacing,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme = context.customPopupTheme;

    final double spacing = this.spacing ?? customPopupButtonTheme.spacing;
    final foregroundColor =
        this.foregroundColor ?? Theme.of(context).colorScheme.onSurface;
    final Color backgroundColor =
        this.backgroundColor ?? Theme.of(context).colorScheme.surface;

    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: customPopupButtonTheme.buttonTheme.spacing,
        ),
        child: Material(
          color: backgroundColor,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.all(
              Radius.circular(customPopupButtonTheme.buttonTheme.borderRadius),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                customPopupButtonTheme.buttonTheme.padding,
              ),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(
                      size: 18,
                      color: foregroundColor,
                    ),
                    child: icon,
                  ),
                  SizedBox(width: spacing),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: foregroundColor,
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
      margin: EdgeInsets.all(customPopupButtonTheme.itemSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(
          customPopupButtonTheme.borderRadius,
        ),
      ),
    );
  }

  @override
  double Function(BuildContext context) get calculateWidgetHeight =>
      (context) => height + context.customPopupTheme.itemSpacing * 2;
}
