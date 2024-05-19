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
              child: CustomButton(),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: CustomButton(),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: CustomButton(),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: CustomButton(),
            ),
            Center(
              child: CustomButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

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
        CustomPopupButtonItem(
          label: 'Edit',
          icon: PhosphorIcon(
            PhosphorIcons.pencilLine(),
          ),
          onTap: () {},
        ),
        CustomPopupButtonItem(
          label: 'Duplicate',
          icon: PhosphorIcon(
            PhosphorIcons.copy(),
          ),
          onTap: () {},
        ),
        CustomPopupButtonItem(
          label: 'Favorite',
          icon: PhosphorIcon(
            PhosphorIcons.heart(),
          ),
          onTap: () {},
        ),
        CustomPopupButtonItem(
          label: 'Share',
          icon: PhosphorIcon(
            PhosphorIcons.share(),
          ),
          onTap: () {},
        ),
        const CustomPopupMenuDivider(),
        CustomPopupButtonItem(
          label: 'Delete',
          icon: PhosphorIcon(
            PhosphorIcons.trash(),
          ),
          foregroundColor: Colors.red,
          onTap: () {},
        ),
      ],
      position: CustomPopupPosition.relative,
    );
  }
}
