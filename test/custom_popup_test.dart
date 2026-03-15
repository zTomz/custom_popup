import 'package:custom_popup/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp({
    double? width,
    double? spacing,
    Color? backgroundColor,
    CustomPopupPosition? position,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.topLeft,
          child: CustomPopupButton(
            icon: const Icon(Icons.more_vert),
            closeIcon: const Icon(Icons.close),
            width: width,
            spacing: spacing,
            backgroundColor: backgroundColor,
            position: position,
            items: [
              CustomPopupMenuItem(
                label: 'Edit',
                icon: const Icon(Icons.edit),
                onTap: () {},
              ),
              const CustomPopupMenuDivider(),
            ],
          ),
        ),
      ),
    );
  }

  testWidgets('positions the popup using the resolved width override', (
    tester,
  ) async {
    const popupWidth = 320.0;

    await tester.pumpWidget(buildTestApp(width: popupWidth));

    final buttonBox = tester.renderObject<RenderBox>(find.byType(IconButton));
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final screenWidth =
        tester.view.physicalSize.width / tester.view.devicePixelRatio;
    final relativeXPosition =
        (buttonPosition.dx + buttonBox.size.width / 2) / screenWidth;
    final expectedLeft =
        (-popupWidth + buttonBox.size.width) * relativeXPosition +
        buttonPosition.dx;

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    final popupPosition = tester.widget<Positioned>(find.byType(Positioned));
    expect(popupPosition.left, closeTo(expectedLeft, 0.001));
  });

  testWidgets('renders the configured popup styling and closes it', (
    tester,
  ) async {
    const popupWidth = 280.0;
    const popupSpacing = 20.0;
    const popupColor = Colors.orange;

    await tester.pumpWidget(
      buildTestApp(
        width: popupWidth,
        spacing: popupSpacing,
        backgroundColor: popupColor,
      ),
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.text('Edit'), findsOneWidget);
    final popupFinder = find.byWidgetPredicate((widget) {
      if (widget is! Container) {
        return false;
      }

      final decoration = widget.decoration;
      return decoration is BoxDecoration &&
          decoration.color == popupColor &&
          widget.padding == const EdgeInsets.all(popupSpacing);
    });
    expect(popupFinder, findsOneWidget);
    expect(tester.getSize(popupFinder).width, popupWidth);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('Edit'), findsNothing);
  });
}
