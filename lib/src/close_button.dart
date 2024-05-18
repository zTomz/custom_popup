import 'package:flutter/material.dart';

class CustomPopupCloseButton extends StatelessWidget {
  final Widget icon;
  final void Function() onClose;

  const CustomPopupCloseButton({
    super.key,
    required this.icon,
    required this.onClose,
  });

  static const double size = 24;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: icon,
        iconSize: size,
        color: Theme.of(context).colorScheme.outline,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        onPressed: onClose,
      ),
    );
  }
}
