import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Column emptyImageColumn(
    {required String imageAddress,
    required String title,
    required String description}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        imageAddress,
        height: height100 * 1.8,
        width: width100 * 2.4,
        fit: BoxFit.cover,
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: textMd.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: height08),
      Text(
        title,
        textAlign: TextAlign.center,
        style: textSm.copyWith(
          color: neutralGrayScale,
        ),
      ),
    ],
  );
}
