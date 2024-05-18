import 'package:custom_popup/src/custom_popup_button_element.dart';
import 'package:flutter/material.dart';

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

  static const double _popupMenuWitdth = 230;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: iconButtonKey,
      icon: OverlayPortal(
        controller: _portalController,
        overlayChildBuilder: (context) {
          RenderBox iconButtonBox =
              iconButtonKey.currentContext?.findRenderObject() as RenderBox;
          Offset position = iconButtonBox.localToGlobal(Offset.zero);

          return Positioned(
            top: position.dy + iconButtonBox.size.height,
            left: position.dx -
                _popupMenuWitdth / 2 +
                iconButtonBox.size.width / 2,
            child: Container(
              width: _popupMenuWitdth,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon:
                          widget.closeIcon ?? const Icon(Icons.cancel_outlined),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _portalController.hide();
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.items,
                ],
              ),
            ),
          );
        },
        child: widget.icon,
      ),
      style: IconButton.styleFrom(
        shape: const RoundedRectangleBorder(
          side: BorderSide(),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(4),
      ),
      constraints: const BoxConstraints(),
      onPressed: () {
        _portalController.toggle();
      },
    );
  }
}
