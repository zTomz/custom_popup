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
      home: Scaffold(
        body: Center(
          child: CustomPopupButton(
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
                  PhosphorIcons.share(),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
