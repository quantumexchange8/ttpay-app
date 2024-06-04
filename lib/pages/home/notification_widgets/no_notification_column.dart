import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Column noNotificationColumn(BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/no-notification.png',
          width: width100 * 3.2,
          height: height100 * 2.4,
          fit: BoxFit.cover,
        ),
        Text(
          AppLocalizations.of(context)!.no_notifications,
          textAlign: TextAlign.center,
          style: textMd.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height08),
        Text(
          AppLocalizations.of(context)!.no_notifications_description,
          textAlign: TextAlign.center,
          style: textSm.copyWith(
            color: neutralGrayScale,
          ),
        ),
      ],
    );
