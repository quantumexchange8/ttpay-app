import 'package:flutter/material.dart';
import 'package:ttpay/component/status_badges.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';

Widget transactionRow({
  required Transaction transaction,
  required bool isLast,
}) {
  String amountIndicator;
  if (transaction.transactionType.toLowerCase() == 'deposit') {
    amountIndicator = '+';
  } else {
    amountIndicator = '-';
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: height08,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rowDateFormat.format(transaction.createdAt),
            style: textXS.copyWith(
              color: neutralGrayScale.shade300,
            ),
          ),
          statusBadges(transaction.status)
        ],
      ),
      SizedBox(height: height08 / 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            transaction.transactionNumber,
            style: textSm.copyWith(),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '$amountIndicator \$ ${amountFormatter.format(transaction.amount)} ',
                  style: textMd.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'USDT',
                  style: textXXS.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      if (!isLast)
        Padding(
          padding: EdgeInsets.only(top: height08),
          child: Divider(
            thickness: 0.5,
            color: neutralGrayScale.shade800,
          ),
        )
    ],
  );
}
