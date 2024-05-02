import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

MaterialBanner toastNotification({
  required String type,
  required String title,
  String? description,
}) {
  final transparentColor = Colors.white.withOpacity(0.05);
  Widget icon;

  switch (type) {
    case 'success':
      icon = Icon(
        Icons.check_circle,
        color: successGreenScale.shade400,
        size: height24,
      );
    case 'warning':
      icon = Container(
        height: height24,
        width: height24,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: warningEmberScale.shade400),
        child: Container(
          color: transparentColor,
          child: Icon(
            Icons.warning,
            color: Colors.transparent,
            size: height24,
          ),
        ),
      );
    case 'error':
      icon = Container(
        height: height24,
        width: height24,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: errorRedScale.shade400),
        child: Icon(
          Icons.close,
          color: transparentColor,
          size: height20,
        ),
      );
      break;
    default:
      icon = Icon(
        Icons.info,
        color: secondaryBlueScale.shade400,
        size: height24,
      );
  }

  return MaterialBanner(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          if (description != null)
            Text(
              description,
              style: textSm,
            )
        ],
      ),
      leading: Container(
        width: height31,
        height: height31,
        decoration: BoxDecoration(
          color: transparentColor,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Positioned(
              left: -84,
              top: -84,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
      dividerColor: Colors.transparent,
      backgroundColor: neutralGrayScale.shade900,
      surfaceTintColor: neutralGrayScale.shade900,
      shadowColor: Color(0x1E0000000),
      elevation: 2,
      padding:
          EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24 / 2),
      margin: EdgeInsets.symmetric(horizontal: width08 * 2),
      actions: const []);
}
