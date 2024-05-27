Custom Popup
===

![Custom Popup Logo](https://github.com/zTomz/custom_popup/raw/main/media/custom_popup_logo.png)

<p align="center">
  <img src="https://img.shields.io/pub/likes/custom_popup?style=flat-square&logo=flutter" alt="Pub Likes"/>
  <img src="https://img.shields.io/badge/STYLE-lint-blue?style=flat-square&logo=flutter" alt="Static Badge"/>
  <img src="https://img.shields.io/github/stars/zTomz/custom_popup?style=flat-square&logo=github" alt="GitHub Repo stars"/>
</p>

A highly customizable popup widget, that is easy to integrate into your code.

Features
---

- Custom Popup is a highly customizable popup widget, that is easy to integrate into your code.

Getting started
---

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
        ...
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
)
```

Showcase
---

<p align="center">
  <img src="https://github.com/zTomz/custom_popup/raw/main/media/custom_popup.gif" alt="Showcase GIF" style="border-radius:16px"/>
</p>