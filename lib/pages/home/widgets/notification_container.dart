import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';

Widget notificationContainer(bool unreadNoti) {
  return Container(
    padding: EdgeInsets.all(height24 / 4),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Image.asset(
      'assets/icon_image/Icon=notification-${unreadNoti ? '2' : '1'}.png',
      height: height24,
      fit: BoxFit.fitHeight,
    ),
  );
}
