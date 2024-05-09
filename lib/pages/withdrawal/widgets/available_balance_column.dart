import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Column availableBalanceColumn(double balance) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Available Net Balance',
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
