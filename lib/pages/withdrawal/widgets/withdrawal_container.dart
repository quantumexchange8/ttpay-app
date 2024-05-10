import 'package:flutter/material.dart';
import 'package:ttpay/component/status_badges.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';

Container withdrawalContainer(Transaction transaction) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24 / 2),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
    ),
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
            statusBadges(transaction.status)
          ],
        ),
        SizedBox(height: height08 / 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transaction.transactionNumber,
              style: textSm,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '- \$ ${amountFormatter.format(transaction.amount)} ',
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
