import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Future<T?> showGroupDeleteWarningDialog<T>(
    {required BuildContext context, required String groupName}) {
  return showDialog(
    context: context,
    builder: (context) {
      return backgroundContainer(
        padding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24),
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icon_image/featured_warning_icon.png',
              width: height10 * 4.8,
              height: height10 * 4.8,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height20),
              child: Text(
                'Are you sure you want to delete $groupName?',
                textAlign: TextAlign.center,
                style: textSm.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ctaButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        bgColor: Colors.white.withOpacity(0.05),
                        text: 'Cancel')),
                SizedBox(width: width24 / 2),
                Expanded(
                    child: ctaButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        bgColor: errorRedScale.shade600,
                        text: 'Delete')),
              ],
            ),
          ],
        ),
      );
    },
  );
}
