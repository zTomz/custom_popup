import 'package:custom_popup/extensions/theme_extension.dart';
import 'package:custom_popup/src/button_element.dart';
import 'package:custom_popup/src/close_button.dart';
import 'package:custom_popup/src/custom_popup_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

const _popupBorderWidth = 2.0;
const _popupAnimationDuration = Duration(milliseconds: 120);

class CustomPopupButton extends StatefulWidget {
  /// The icon that opens the popup
  final Widget icon;

  /// The icon that closes the popup
  final Widget? closeIcon;

  /// The items inside of the popup
  ///
  /// Choose between [CustomPopupMenuItem] and [CustomPopupMenuDivider]
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
    final popupStyle = _resolvePopupStyle(context);
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      key: _iconButtonKey,
      icon: OverlayPortal(
        controller: _portalController,
        overlayChildBuilder: (context) =>
            _buildPopupMenu(context, popupStyle: popupStyle),
        child: widget.icon,
      ),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(popupStyle.buttonRadius),
        ),
        backgroundColor: popupStyle.backgroundColor,
        padding: EdgeInsets.all(popupStyle.buttonPadding),
      ),
      constraints: const BoxConstraints(),
      onPressed: _portalController.toggle,
    );
  }

  _ResolvedPopupStyle _resolvePopupStyle(BuildContext context) {
    final popupTheme = context.customPopupTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return _ResolvedPopupStyle(
      width: widget.width ?? popupTheme.width,
      spacing: widget.spacing ?? popupTheme.spacing,
      itemSpacing: popupTheme.itemSpacing,
      backgroundColor:
          widget.backgroundColor ??
          popupTheme.backgroundColor ??
          colorScheme.surface,
      position: widget.position ?? popupTheme.position,
      buttonRadius: widget.buttonRadius ?? popupTheme.buttonRadius,
      borderRadius: widget.borderRadius ?? popupTheme.borderRadius,
      buttonPadding: widget.buttonPadding ?? popupTheme.buttonPadding,
    );
  }

  /// This builds the popup menu
  Widget _buildPopupMenu(
    BuildContext context, {
    required _ResolvedPopupStyle popupStyle,
  }) {
    final Widget popupMenu =
        Container(
          width: popupStyle.width,
          padding: EdgeInsets.all(popupStyle.spacing),
          decoration: BoxDecoration(
            color: popupStyle.backgroundColor,
            borderRadius: BorderRadius.circular(popupStyle.borderRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPopupCloseButton(
                icon: widget.closeIcon ?? const Icon(Icons.cancel_outlined),
                onClose: () {
                  _portalController.hide();
                },
              ),
              SizedBox(height: popupStyle.spacing),
              ...widget.items,
            ],
          ),
        ).animate().scale(
          alignment: widget.animationAlignment,
          curve: Curves.easeIn,
          duration: _popupAnimationDuration,
        );

    if (popupStyle.position == CustomPopupPosition.centered) {
      return Center(child: popupMenu);
    }

    final iconButtonBox =
        _iconButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (iconButtonBox == null) {
      return const SizedBox.shrink();
    }

    final buttonPosition = _calculateRelativePosition(
      context,
      iconButtonBox,
      popupStyle,
    );

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
    _ResolvedPopupStyle popupStyle,
  ) {
    final screenSize = MediaQuery.sizeOf(context);

    final buttonPosition = iconButtonBox.localToGlobal(Offset.zero);
    final popupMenuSize = _calculateMenuSize(context, popupStyle);

    final bool displayAbove =
        buttonPosition.dy +
            iconButtonBox.size.height +
            popupMenuSize.height +
            popupStyle.itemSpacing >
        screenSize.height;
    final double relativeXPosition =
        (buttonPosition.dx + iconButtonBox.size.width / 2) / screenSize.width;

    return Offset(
      (-popupStyle.width + iconButtonBox.size.width) * relativeXPosition +
          buttonPosition.dx,
      displayAbove
          ? buttonPosition.dy -
                popupMenuSize.height -
                popupStyle.itemSpacing -
                _popupBorderWidth // Account for the popup border width.
          : buttonPosition.dy +
                iconButtonBox.size.height +
                popupStyle.itemSpacing,
    );
  }

  /// This calculates the size of the menu based on the number of items inside of it and the themes width.
  Size _calculateMenuSize(
    BuildContext context,
    _ResolvedPopupStyle popupStyle,
  ) {
    double height = popupStyle.spacing * 3 + CustomPopupCloseButton.size;

    for (final CustomPopupMenuElement item in widget.items) {
      height += item.calculateWidgetHeight(context);
    }

    return Size(popupStyle.width, height);
  }
}

class _ResolvedPopupStyle {
  const _ResolvedPopupStyle({
    required this.width,
    required this.spacing,
    required this.itemSpacing,
    required this.backgroundColor,
    required this.position,
    required this.buttonRadius,
    required this.borderRadius,
    required this.buttonPadding,
  });

  final double width;
  final double spacing;
  final double itemSpacing;
  final Color backgroundColor;
  final CustomPopupPosition position;
  final double buttonRadius;
  final double borderRadius;
  final double buttonPadding;
}
