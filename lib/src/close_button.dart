import 'package:flutter/material.dart';

class CustomPopupCloseButton extends StatelessWidget {
  final Widget icon;
  final void Function() onClose;

  const CustomPopupCloseButton({
    super.key,
    required this.icon,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: icon,
        color: Theme.of(context).colorScheme.outline,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        onPressed: onClose,
      ),
    );
  }
}
