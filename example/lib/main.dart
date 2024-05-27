import 'package:custom_popup/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: const [
          CustomPopupTheme(),
        ],
      ),
      home: const Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: CustomButton(
                animationAlignment: Alignment.topLeft,
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: CustomButton(
                animationAlignment: Alignment.topRight,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: CustomButton(
                animationAlignment: Alignment.bottomLeft,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CustomButton(
                animationAlignment: Alignment.bottomRight,
              ),
            ),
            Center(
              child: CustomButton(
                animationAlignment: Alignment.topCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Alignment animationAlignment;

  const CustomButton({
    super.key,
    required this.animationAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPopupButton(
      icon: PhosphorIcon(
        PhosphorIcons.dotsThreeVertical(),
      ),
      closeIcon: PhosphorIcon(
        PhosphorIcons.xCircle(),
      ),
      items: [
        CustomPopupMenuItem(
          label: 'Edit',
          icon: PhosphorIcon(
            PhosphorIcons.pencilLine(),
          ),
          onTap: () {},
        ),
        CustomPopupMenuItem(
          label: 'Duplicate',
          icon: PhosphorIcon(
            PhosphorIcons.copy(),
          ),
          onTap: () {},
        ),
        CustomPopupMenuItem(
          label: 'Favorite',
          icon: PhosphorIcon(
            PhosphorIcons.heart(),
          ),
          onTap: () {},
        ),
        CustomPopupMenuItem(
          label: 'Share',
          icon: PhosphorIcon(
            PhosphorIcons.share(),
          ),
          onTap: () {},
        ),
        const CustomPopupMenuDivider(),
        CustomPopupMenuItem(
          label: 'Delete',
          icon: PhosphorIcon(
            PhosphorIcons.trash(),
          ),
          foregroundColor: Colors.red,
          onTap: () {},
        ),
      ],
      animationAlignment: animationAlignment,
    );
  }
}
