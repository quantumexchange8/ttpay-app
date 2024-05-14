import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';

Widget bottomNavigationBar({
  required int currentIndex,
  void Function(int)? onTap,
}) {
  LinearGradient buttonGradient = LinearGradient(
    begin: const Alignment(-0.71, -0.71),
    end: const Alignment(0.71, 0.71),
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

  return SnakeNavigationBar.gradient(
    backgroundGradient: const RadialGradient(
        colors: [Colors.black, Color(0xFFB5A6FF)], radius: 15),
    snakeViewGradient: buttonGradient,
    behaviour: SnakeBarBehaviour.floating,
    currentIndex: currentIndex,
    height: height10 * 7.2,
    onTap: onTap,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: primaryPurpleScale.shade300)),
    padding: EdgeInsets.fromLTRB(
        width08 * 4, height24 / 2, width08 / 2, height24 / 2),
    snakeShape: SnakeShape.circle,
    items: items
        .map((e) => BottomNavigationBarItem(
            icon: e['icon'], activeIcon: e['active_icon']))
        .toList(),
  );
}
