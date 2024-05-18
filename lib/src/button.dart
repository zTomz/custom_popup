import 'package:custom_popup/extensions/theme_extension.dart';
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

  final CustomPopupPosition? position;

  const CustomPopupButton({
    super.key,
    required this.icon,
    this.closeIcon,
    required this.items,
    this.position,
  });

  @override
  State<CustomPopupButton> createState() => _CustomPopupButtonState();
}

class _CustomPopupButtonState extends State<CustomPopupButton> {
  final OverlayPortalController _portalController = OverlayPortalController();
  final GlobalKey _iconButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final customPopupButtonTheme = context.customPopupTheme;

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

  /// This builds the popup menu
  Widget popupMenuBuilder(BuildContext context, CustomPopupTheme theme) {
    RenderBox iconButtonBox =
        _iconButtonKey.currentContext?.findRenderObject() as RenderBox;

    late Offset buttonPosition;
    final Widget popupMenu = Container(
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
        mainAxisSize: MainAxisSize.min,
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
    );

    if (widget.position == CustomPopupPosition.centered) {
      return Center(
        child: popupMenu,
      );
    } else if (widget.position == CustomPopupPosition.relative) {
      buttonPosition = _calculateRelativePosition(
        context,
        iconButtonBox,
        widget.position!,
      );
    } else {
      if (theme.position == CustomPopupPosition.centered) {
        return Center(
          child: popupMenu,
        );
      } else {
        buttonPosition = _calculateRelativePosition(
          context,
          iconButtonBox,
          theme.position,
        );
      }
    }

    return Positioned(
      top: buttonPosition.dy,
      left: buttonPosition.dx,
      child: popupMenu,
    );
  }

  /// This function calculates the relative position of the popup to the button
  Offset _calculateRelativePosition(
    BuildContext context,
    RenderBox iconButtonBox,
    CustomPopupPosition position,
  ) {
    final theme = context.customPopupTheme;
    final screenSize = MediaQuery.sizeOf(context);

    final buttonPosition = iconButtonBox.localToGlobal(Offset.zero);
    final popupMenuSize = calculateMenuSize(theme);

    final bool displayAbove = buttonPosition.dy +
            iconButtonBox.size.height +
            popupMenuSize.height +
            theme.smallSpacing >
        screenSize.height;
    final double relativeXPosition =
        (buttonPosition.dx + iconButtonBox.size.width / 2) / screenSize.width;

    return Offset(
      (-theme.width + iconButtonBox.size.width) * relativeXPosition +
          buttonPosition.dx,
      displayAbove
          ? buttonPosition.dy -
              popupMenuSize.height -
              theme.smallSpacing -
              2 // - 2 because of the border allignment
          : buttonPosition.dy + iconButtonBox.size.height + theme.smallSpacing,
    );
  }

  /// This calculates the size of the menu based on the number of items inside of it and the themes width.
  Size calculateMenuSize(
    CustomPopupTheme theme,
  ) {
    double height = 0;

    height += theme.defaultSpacing * 2;
    height += CustomPopupCloseButton.size;
    height += theme.defaultSpacing;

    for (CustomPopupMenuElement item in widget.items) {
      height += item.calculateWidgetHeight(context);
    }

    return Size(
      theme.width,
      height,
    );
  }
}

enum CustomPopupPosition {
  /// If the popup is positioned relative to the button
  relative,

  /// If the popup is positioned centered on the screen like a dialog
  centered;
}
