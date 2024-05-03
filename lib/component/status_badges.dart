import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Container statusBadges(String status) {
  Color borderColor;
  Color backgroundColor;
  Color textColor;

  switch (status) {
    case 'success':
      borderColor = successGreenScale.shade600;
      backgroundColor = successGreenScale.shade600.withOpacity(0.1);
      textColor = successGreenScale;
    case 'rejected':
      borderColor = errorRedScale.shade600;
      backgroundColor = errorRedScale.shade600.withOpacity(0.1);
      textColor = errorRedScale.shade600;
    case 'freezing':
      borderColor = secondaryBlueScale;
      backgroundColor = secondaryBlueScale.withOpacity(0.1);
      textColor = secondaryBlueScale;
      break;
    default:
      borderColor = warningEmberScale;
      backgroundColor = warningEmberScale.withOpacity(0.1);
      textColor = warningEmberScale;
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: width08, vertical: height08 / 4),
    decoration: ShapeDecoration(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: borderColor),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Text(
      status.capitalizeFirst ?? status,
      style: textXXS.copyWith(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
