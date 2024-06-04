import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget summartBoxBelowAppBar(
  BuildContext context, {
  required int totalDepositNumber,
  required double totalFreezingAmount,
}) {
  return Row(
    children: [
      Expanded(
        child: _summaryBox(
          title: '${AppLocalizations.of(context)!.total_deposit_number} ',
          subtitle: amountFormatterWithoutDecimal.format(totalDepositNumber),
        ),
      ),
      SizedBox(width: width24 / 2),
      Expanded(
        child: _summaryBox(
          title: AppLocalizations.of(context)!.total_freezing_amount,
          subtitle: '\$ ${amountFormatter.format(totalFreezingAmount)}',
        ),
      )
    ],
  );
}

Container _summaryBox({
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: EdgeInsets.all(height24 / 2),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textXS.copyWith(
            color: neutralGrayScale,
          ),
        ),
        SizedBox(height: height08 / 2),
        Text(
          subtitle,
          style: textMd.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
