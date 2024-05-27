import 'package:collection/collection.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';

Widget bottomNavigationBar({
  required int currentIndex,
  required void Function(int) onTap,
}) {
  Image iconImage(String icon) => Image.asset(
        icon,
        height: height24,
        fit: BoxFit.fitHeight,
      );

  final List items = [
    {
      'icon': iconImage('assets/icon_image/home_unselected.png'),
      'active_icon': iconImage('assets/icon_image/home_icon.png'),
    },
    {
      'icon': iconImage('assets/icon_image/transaction_unselected.png'),
      'active_icon': iconImage('assets/icon_image/transaction_icon.png'),
    },
    {
      'icon': iconImage('assets/icon_image/group_unselected.png'),
      'active_icon': iconImage('assets/icon_image/group_icon.png'),
    },
    {
      'icon': iconImage('assets/icon_image/wallet_unselected.png'),
      'active_icon': iconImage('assets/icon_image/wallet_icon.png'),
    },
    {
      'icon': iconImage('assets/icon_image/profile_unselected.png'),
      'active_icon': iconImage('assets/icon_image/profile_icon.png'),
    },
  ];

  return Padding(
    padding: EdgeInsets.fromLTRB(width08 * 2, 0, width08 * 2, height20),
    child: Container(
      height: height10 * 7.2,
      padding: EdgeInsets.symmetric(
        horizontal: width08 * 2,
        vertical: height24 / 2,
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bottom_nav_background.png'),
              fit: BoxFit.fill)),
      child: Row(
        children: items.mapIndexed((i, e) {
          bool isActive = currentIndex == i;
          return Expanded(
            child: InkWell(
              onTap: () {
                onTap(i);
              },
              child: Stack(
                children: [
                  Entry.scale(visible: isActive, child: gradientContainer),
                  Center(
                    child: itemContainer(
                        isActive: isActive,
                        icon: e['icon'],
                        activeIcon: e['active_icon']),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget itemContainer({
  required Widget icon,
  required Widget activeIcon,
  required bool isActive,
}) {
  return isActive ? activeIcon : icon;
}

Container gradientContainer = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: const Alignment(-0.71, 0.71),
      end: const Alignment(0.71, -0.71),
      colors: [
        const Color(0xFF210077),
        primaryPurpleScale.shade600,
        primaryPurpleScale.shade400,
      ],
    ),
    shape: BoxShape.circle,
  ),
);
