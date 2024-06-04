import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/checkbox.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RiskDisclaimerDialog extends StatefulWidget {
  const RiskDisclaimerDialog({super.key});

  @override
  State<RiskDisclaimerDialog> createState() => _RiskDisclaimerDialogState();
}

class _RiskDisclaimerDialogState extends State<RiskDisclaimerDialog> {
  List<String> selectedRisk = [];

  @override
  Widget build(BuildContext context) {
    void onSelectedRisk(String risk) {
      setState(() {
        if (selectedRisk.contains(risk)) {
          selectedRisk.remove(risk);
        } else {
          selectedRisk.add(risk);
        }
      });
    }

    void onPressedAcknowledge() {
      if (selectedRisk.length < 3) {
        showToastNotification(context,
            type: 'warning',
            title:
                AppLocalizations.of(context)!.terms_and_conditions_unchecked);
        return;
      }
      Navigator.pop(context, true);
    }

    void onPressedCancel() {
      Navigator.pop(context);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: EdgeInsets.symmetric(horizontal: width24 / 2),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width08 * 2, vertical: height24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.risk_disclaimer,
                  textAlign: TextAlign.center,
                  style: textMd.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height20),
                ...riskList(context).mapIndexed((i, risk) => Padding(
                      padding: EdgeInsets.only(
                          bottom: isLast(i, riskList(context)) ? 0 : height08),
                      child: checkRiskRow(
                        riskText: risk,
                        isCheck: selectedRisk.contains(risk),
                        onChanged: (selected) {
                          onSelectedRisk(risk);
                        },
                      ),
                    )),
                SizedBox(height: height08 * 2),
                Text(
                  AppLocalizations.of(context)!.by_clicking_aknowledge,
                  style: textXS,
                ),
                SizedBox(height: height31),
                ctaButton(
                    onPressed: onPressedAcknowledge,
                    isGradient: true,
                    text: AppLocalizations.of(context)!.acknowledge),
                SizedBox(height: height24 / 2),
                ctaButton(
                    onPressed: onPressedCancel,
                    text: AppLocalizations.of(context)!.cancel)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row checkRiskRow({
  required String riskText,
  required bool isCheck,
  required void Function(bool?)? onChanged,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
          height: height20,
          width: height20,
          child: customCheckbox(isCheck: isCheck, onChanged: onChanged)),
      SizedBox(width: width24 / 2),
      Expanded(
        child: Text(
          riskText,
          style: textXXS.copyWith(
            color: neutralGrayScale.shade300,
          ),
        ),
      ),
    ],
  );
}

List<String> riskList(BuildContext context) => [
      AppLocalizations.of(context)!.risk_disclaimer_one,
      AppLocalizations.of(context)!.risk_disclaimer_two,
      AppLocalizations.of(context)!.risk_disclaimer_three,
    ];
