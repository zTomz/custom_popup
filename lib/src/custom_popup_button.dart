import 'package:flutter/material.dart';
import 'package:custom_popup/custom_popup.dart';

class CustomPopupButton extends StatefulWidget {
  final Widget icon;
  final Widget? closeIcon;
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
  GlobalKey iconButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme =
        Theme.of(context).extension<CustomPopupThemeExtension>() ??
            CustomPopupThemeExtension.fallback();

    return IconButton(
      key: iconButtonKey,
      icon: OverlayPortal(
        controller: _portalController,
        overlayChildBuilder: (context) {
          RenderBox iconButtonBox =
              iconButtonKey.currentContext?.findRenderObject() as RenderBox;
          Offset position = iconButtonBox.localToGlobal(Offset.zero);

          return Positioned(
            top: position.dy +
                iconButtonBox.size.height +
                customPopupButtonTheme.smallSpacing,
            left: position.dx -
                customPopupButtonTheme.width / 2 +
                iconButtonBox.size.width / 2,
            child: Container(
              width: customPopupButtonTheme.width,
              padding: EdgeInsets.all(customPopupButtonTheme.defaultSpacing),
              decoration: BoxDecoration(
                color: customPopupButtonTheme.backgroundColor ??
                    Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.all(
                  Radius.circular(customPopupButtonTheme.borderRadius),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: widget.closeIcon ??
                          const Icon(
                            Icons.cancel_outlined,
                          ),
                      color: Theme.of(context).colorScheme.outline,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _portalController.hide();
                      },
                    ),
                  ),
                  SizedBox(height: customPopupButtonTheme.defaultSpacing),
                  ...widget.items,
                ],
              ),
            ),
          );
        },
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
}
