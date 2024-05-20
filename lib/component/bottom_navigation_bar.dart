import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';

Widget bottomNavigationBar({
  required int currentIndex,
  void Function(int)? onTap,
}) {
  LinearGradient buttonGradient = LinearGradient(
    begin: const Alignment(-0.71, 0.71),
    end: const Alignment(0.71, -0.71),
    colors: [
      const Color(0xFF210077),
      primaryPurpleScale.shade600,
      primaryPurpleScale.shade400,
    ],
  );

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

  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bottom_nav_background.png'),
            fit: BoxFit.fill)),
    child: SnakeNavigationBar.gradient(
      backgroundGradient: const RadialGradient(
        colors: [Colors.transparent, Colors.transparent],
      ),
      snakeViewGradient: buttonGradient,
      behaviour: SnakeBarBehaviour.floating,
      currentIndex: currentIndex,
      height: height10 * 7.2,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width08 * 2,
        vertical: height24 / 2,
      ),
      snakeShape: SnakeShape.circle,
      items: items
          .map((e) => BottomNavigationBarItem(
              icon: e['icon'], activeIcon: e['active_icon']))
          .toList(),
    ),
  );
}
