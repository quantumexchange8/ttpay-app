import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<T?> showWarningDialog<T>({
  required BuildContext context,
  required String title,
  required String redButtonText,
}) =>
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: backgroundContainer(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: EdgeInsets.fromLTRB(width08 * 2, 0, width08 * 2, height24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: height100 * 1.5,
                  child: Stack(
                    children: [
                      Positioned(
                        left: width10 * 6.5,
                        bottom: height10 * 4,
                        child: Image.asset(
                          'assets/icon_image/featured_warning_icon.png',
                          width: height100 * 1.2,
                          height: height100 * 1.2,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height20),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: textSm.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                            text: AppLocalizations.of(context)!.cancel)),
                    SizedBox(width: width24 / 2),
                    Expanded(
                        child: ctaButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            bgColor: errorRedScale.shade600,
                            text: redButtonText)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
