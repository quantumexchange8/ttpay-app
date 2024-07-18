import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusBadges extends StatelessWidget {
  final String status;
  const StatusBadges({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color backgroundColor;
    Color textColor;
    String text;
    switch (status) {
      case 'success':
        borderColor = successGreenScale.shade600;
        backgroundColor = successGreenScale.shade600.withOpacity(0.1);
        textColor = successGreenScale;
        text = AppLocalizations.of(context)!.success;
      case 'rejected' || 'fail' || 'failed':
        borderColor = errorRedScale.shade600;
        backgroundColor = errorRedScale.shade600.withOpacity(0.1);
        textColor = errorRedScale.shade600;
        text = AppLocalizations.of(context)!.rejected;
      case 'freezing':
        borderColor = secondaryBlueScale;
        backgroundColor = secondaryBlueScale.withOpacity(0.1);
        textColor = secondaryBlueScale;
        text = AppLocalizations.of(context)!.freezing;
        break;
      default:
        borderColor = warningEmberScale;
        backgroundColor = warningEmberScale.withOpacity(0.1);
        textColor = warningEmberScale;
        text = AppLocalizations.of(context)!.pending;
    }

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width08, vertical: height08 / 4),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: textXXS.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
