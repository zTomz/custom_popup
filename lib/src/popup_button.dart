import 'package:custom_popup/custom_popup.dart';
import 'package:custom_popup/extensions/theme_extension.dart';
import 'package:custom_popup/src/close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomPopupButton extends StatefulWidget {
  /// The icon that opens the popup
  final Widget icon;

  /// The icon that closes the popup
  final Widget? closeIcon;

  /// The items inside of the popup
  ///
  /// Choose between [CustomPopupButtonItem] and [CustomPopupMenuDivider]
  final List<CustomPopupMenuElement> items;

  /// The background color of the popup
  ///
  /// If not set it will default to the surface color of the theme
  final Color? backgroundColor;

  /// The position of the popup
  ///
  /// If not set it will default to the position of the theme
  final CustomPopupPosition? position;

  /// The width of the popup
  ///
  /// If not set it will default to the width of the theme
  final double? width;

  /// The border radius of the popup
  ///
  /// If not set it will default to the border radius of the theme
  final double? buttonRadius;

  /// The border radius of the popup
  ///
  /// If not set it will default to the border radius of the theme
  final double? borderRadius;

  /// The spacing between the elements
  ///
  /// If not set it will default to the spacing of the theme
  final double? spacing;

  /// The padding of the button
  ///
  /// If not set it will default to the padding of the theme
  final double? buttonPadding;

  /// From where the scale animation starts.
  ///
  /// Defaults to [Alignment.topCenter]
  final Alignment animationAlignment;

  const CustomPopupButton({
    super.key,
    required this.icon,
    required this.items,
    this.closeIcon,
    this.backgroundColor,
    this.position,
    this.width,
    this.buttonRadius,
    this.borderRadius,
    this.spacing,
    this.buttonPadding,
    this.animationAlignment = Alignment.topCenter,
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

    final double width = widget.width ?? customPopupButtonTheme.width;
    final double spacing = widget.spacing ?? customPopupButtonTheme.spacing;
    final Color backgroundColor = widget.backgroundColor ??
        customPopupButtonTheme.backgroundColor ??
        Theme.of(context).colorScheme.surface;
    final double buttonRadius =
        widget.buttonRadius ?? customPopupButtonTheme.buttonRadius;
    final double borderRadius =
        widget.borderRadius ?? customPopupButtonTheme.borderRadius;
    final CustomPopupPosition position =
        widget.position ?? customPopupButtonTheme.position;
    final double buttonPadding =
        widget.buttonPadding ?? customPopupButtonTheme.buttonPadding;

    return IconButton(
      key: _iconButtonKey,
      icon: OverlayPortal(
        controller: _portalController,
        overlayChildBuilder: (context) => popupMenuBuilder(
          context,
          width: width,
          spacing: spacing,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
          position: position,
        ),
        child: widget.icon,
      ),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(buttonRadius),
          ),
        ),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.all(buttonPadding),
      ),
      constraints: const BoxConstraints(),
      onPressed: () {
        _portalController.toggle();
      },
    );
  }

  /// This builds the popup menu
  Widget popupMenuBuilder(
    BuildContext context, {
    required double width,
    required double spacing,
    required double borderRadius,
    required Color backgroundColor,
    required CustomPopupPosition position,
  }) {
    final RenderBox iconButtonBox =
        _iconButtonKey.currentContext!.findRenderObject()! as RenderBox;

    late Offset buttonPosition;
    final Widget popupMenu = Container(
      width: width,
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
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
          SizedBox(height: spacing),
          ...widget.items,
        ],
      ),
    ).animate().scale(
          alignment: widget.animationAlignment,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 120),
        );

    if (position == CustomPopupPosition.centered) {
      return Center(
        child: popupMenu,
      );
    } else {
      buttonPosition = _calculateRelativePosition(
        context,
        iconButtonBox,
        position,
      );

      return Positioned(
        top: buttonPosition.dy,
        left: buttonPosition.dx,
        child: popupMenu,
      );
    }
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
            theme.itemSpacing >
        screenSize.height;
    final double relativeXPosition =
        (buttonPosition.dx + iconButtonBox.size.width / 2) / screenSize.width;

    return Offset(
      (-theme.width + iconButtonBox.size.width) * relativeXPosition +
          buttonPosition.dx,
      displayAbove
          ? buttonPosition.dy -
              popupMenuSize.height -
              theme.itemSpacing -
              2 // - 2 because of the border allignment
          : buttonPosition.dy + iconButtonBox.size.height + theme.itemSpacing,
    );
  }

  /// This calculates the size of the menu based on the number of items inside of it and the themes width.
  Size calculateMenuSize(
    CustomPopupTheme theme,
  ) {
    double height = 0;

    height += theme.spacing * 2;
    height += CustomPopupCloseButton.size;
    height += theme.spacing;

    for (final CustomPopupMenuElement item in widget.items) {
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
