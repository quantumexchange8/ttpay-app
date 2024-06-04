import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextButton fullWithdrawalTextButton(
  BuildContext context, {
  required void Function()? onPressed,
  required bool isFull,
}) {
  return TextButton(
      onPressed: onPressed,
      child: Text(
        isFull
            ? AppLocalizations.of(context)!.clear
            : AppLocalizations.of(context)!.full_withdrawal,
        textAlign: TextAlign.center,
        style: textMd.copyWith(
          color: isFull ? errorRedScale.shade600 : primaryPurpleScale.shade600,
          fontWeight: isFull ? FontWeight.w600 : FontWeight.w700,
        ),
      ));
}
