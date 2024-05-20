# Custom Popup

A highly customizable popup widget, that is easy to integrate into your code.

## Features

- Custom Popup is a highly customizable popup widget, that is easy to integrate into your code.

## Getting started

Just add the widget in your code. The example below shows how to use the widget with [Phosphor icons package](https://pub.dev/packages/phosphor_flutter).

```Dart
CustomPopupButton(
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
        ...
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
)
```

