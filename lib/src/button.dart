import 'package:custom_popup/src/close_button.dart';
import 'package:flutter/material.dart';
import 'package:custom_popup/custom_popup.dart';

class CustomPopupButton extends StatefulWidget {
  /// The icon that opens the popup
  final Widget icon;

  /// The icon that closes the popup
  final Widget? closeIcon;

  /// The items inside of the popup
  ///
  /// Choose between [CustomPopupButtonItem] and [CustomPopupMenuDivider]
  final List<CustomPopupMenuElement> items;

  const CustomPopupButton({
    super.key,
    required this.icon,
    this.closeIcon,
    required this.items,
  });

  @override
  State<CustomPopupButton> createState() => _CustomPopupButtonState();
}

class _CustomPopupButtonState extends State<CustomPopupButton> {
  final OverlayPortalController _portalController = OverlayPortalController();
  final GlobalKey _iconButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme =
        Theme.of(context).extension<CustomPopupThemeExtension>() ??
            CustomPopupThemeExtension.fallback();

    return IconButton(
      key: _iconButtonKey,
      icon: OverlayPortal(
        controller: _portalController,
        overlayChildBuilder: (context) => popupMenuBuilder(
          context,
          customPopupButtonTheme,
        ),
        child: widget.icon,
      ),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(customPopupButtonTheme.borderRadius),
          ),
        ),
        backgroundColor: customPopupButtonTheme.backgroundColor ??
            Theme.of(context).colorScheme.surface,
        padding: EdgeInsets.all(customPopupButtonTheme.smallSpacing),
      ),
      constraints: const BoxConstraints(),
      onPressed: () {
        _portalController.toggle();
      },
    );
  }

  Widget popupMenuBuilder(
      BuildContext context, CustomPopupThemeExtension theme) {
    RenderBox iconButtonBox =
        _iconButtonKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = iconButtonBox.localToGlobal(Offset.zero);

    return Positioned(
      top: position.dy + iconButtonBox.size.height + theme.smallSpacing,
      left: position.dx - theme.width / 2 + iconButtonBox.size.width / 2,
      child: Container(
        width: theme.width,
        padding: EdgeInsets.all(theme.defaultSpacing),
        decoration: BoxDecoration(
          color: theme.backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(
            Radius.circular(theme.borderRadius),
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          children: [
            CustomPopupCloseButton(
              icon: widget.closeIcon ??
                  const Icon(
                    Icons.cancel_outlined,
                  ),
              onClose: () {
                _portalController.hide();
              },
            ),
            SizedBox(height: theme.defaultSpacing),
            ...widget.items,
          ],
        ),
      ),
    );
  }
}
