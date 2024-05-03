import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Column noTransactionsColumn = Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Image.asset(
      'assets/images/no-transaction.png',
      height: height100 * 1.8,
      width: width100 * 2.4,
      fit: BoxFit.cover,
    ),
    Text(
      'No Transactions Found',
      textAlign: TextAlign.center,
      style: textMd.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    SizedBox(height: height08),
    Text(
      'It seems there are no transactions to display at the moment.',
      textAlign: TextAlign.center,
      style: textSm.copyWith(
        color: neutralGrayScale,
      ),
    ),
  ],
);
