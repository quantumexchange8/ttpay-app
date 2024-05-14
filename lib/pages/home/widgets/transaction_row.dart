import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/status_badges.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';

Widget transactionRow({
  required Transaction transaction,
  required bool isLast,
  bool isPinned = false,
}) {
  String amountIndicator;
  if (transaction.transactionType.toLowerCase() == 'deposit') {
    amountIndicator = '+';
  } else {
    amountIndicator = '-';
  }

  return backgroundContainer(
    padding: EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height08),
    border: isLast
        ? null
        : Border(
            bottom: BorderSide(width: 0.5, color: neutralGrayScale.shade800)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rowDateFormat.format(transaction.createdAt),
              style: textXS.copyWith(
                color: neutralGrayScale.shade300,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isPinned)
                  Image.asset(
                    'assets/icon_image/purple_pin_icon.png',
                    height: height08 * 2,
                    fit: BoxFit.fitHeight,
                  ),
                SizedBox(
                  width: width08,
                ),
                statusBadges(transaction.status),
              ],
            )
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
      ],
    ),
  );
}
