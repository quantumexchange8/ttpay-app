import 'package:flutter/material.dart';
import 'package:smart_snackbars/enums/animate_from.dart';
import 'package:smart_snackbars/smart_snackbars.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

void showToastNotification(
  BuildContext context, {
  Duration? duration,
  String? type,
  required String title,
  String? description,
  bool? persist,
}) {
  final shadowColor;
  Widget icon;

  switch (type) {
    case 'success':
      icon = Icon(
        Icons.check_circle,
        color: successGreenScale.shade400,
        size: height24,
      );
      shadowColor = successGreenScale.shade600.withOpacity(0.2);
    case 'warning':
      icon = Image.asset(
        'assets/icon_image/warning_icon.png',
        fit: BoxFit.cover,
        height: height24,
      );
      shadowColor = warningEmberScale.withOpacity(0.2);
    case 'error':
      icon = Container(
        height: height24,
        width: height24,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: errorRedScale.shade400),
        child: Icon(
          Icons.close,
          color: neutralGrayScale.shade900,
          size: height20,
        ),
      );
      shadowColor = errorRedScale.shade800.withOpacity(0.2);
      break;
    default:
      icon = Icon(
        Icons.info,
        color: secondaryBlueScale.shade400,
        size: height20,
      );
      shadowColor = secondaryBlueScale.shade600.withOpacity(0.2);
  }

  return SmartSnackBars.showCustomSnackBar(
    context: context,
    animateFrom: AnimateFrom.fromTop,
    duration: duration ?? const Duration(seconds: 1, milliseconds: 500),
    persist: persist,
    child: Container(
      decoration: BoxDecoration(
        color: neutralGrayScale.shade900,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width08 * 2, vertical: height24 / 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [shadowColor, Colors.transparent]),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: height31,
              height: height31,
              padding: EdgeInsets.all(height05),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: icon,
            ),
            SizedBox(
              width: width24 / 2,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textSm.copyWith(fontWeight: FontWeight.w600),
                ),
                if (description != null)
                  SizedBox(
                    width: width100 * 2.52,
                    height: height20 * 2,
                    child: Text(
                      description,
                      style: textSm,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
