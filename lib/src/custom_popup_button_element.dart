import 'package:custom_popup/custom_popup.dart';
import 'package:flutter/material.dart';

sealed class CustomPopupMenuElement extends Widget {
  const CustomPopupMenuElement({super.key});
}

class CustomPopupButtonItem extends StatelessWidget
    implements CustomPopupMenuElement {
  final String label;
  final Widget icon;
  final void Function() onTap;

  const CustomPopupButtonItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme =
        Theme.of(context).extension<CustomPopupThemeExtension>() ??
            CustomPopupThemeExtension.fallback();

    return Padding(
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
    );
  }
}

class CustomPopupMenuDivider extends StatelessWidget
    implements CustomPopupMenuElement {
  const CustomPopupMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme =
        Theme.of(context).extension<CustomPopupThemeExtension>() ??
            CustomPopupThemeExtension.fallback();

    return Container(
      height: 1,
      margin: EdgeInsets.all(customPopupButtonTheme.smallSpacing),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius:
            BorderRadius.circular(customPopupButtonTheme.borderRadius),
      ),
    );
  }
}
