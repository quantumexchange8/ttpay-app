import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Column availableBalanceColumn(BuildContext context, {required double balance}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations.of(context)!.available_net_balance,
        style: textXS.copyWith(
          color: neutralGrayScale.shade300,
        ),
      ),
      SizedBox(height: height08 / 2),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '\$ ${amountFormatter.format(balance)} ',
              style: textXXL.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: 'USDT',
              style: textSm.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
