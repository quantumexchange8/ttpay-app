import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Column noNotificationColumn = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image.asset(
      'assets/images/no-notification.png',
      width: width100 * 3.2,
      height: height100 * 2.4,
      fit: BoxFit.cover,
    ),
    Text(
      'No Notifications Yet!',
      textAlign: TextAlign.center,
      style: textMd.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    SizedBox(height: height08),
    Text(
      'It looks like you\'re all caught up. Keep up the great work!',
      textAlign: TextAlign.center,
      style: textSm.copyWith(
        color: neutralGrayScale,
      ),
    ),
  ],
);
