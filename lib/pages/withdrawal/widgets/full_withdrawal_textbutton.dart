import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/text_style.dart';

TextButton fullWithdrawalTextButton({
  required void Function()? onPressed,
  required bool isFull,
}) {
  return TextButton(
      onPressed: onPressed,
      child: Text(
        isFull ? 'Clear' : 'FULL WITHDRAWAL',
        textAlign: TextAlign.center,
        style: textMd.copyWith(
          color: isFull ? errorRedScale.shade600 : primaryPurpleScale.shade600,
          fontWeight: isFull ? FontWeight.w600 : FontWeight.w700,
        ),
      ));
}
