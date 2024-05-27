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
            type: 'warning', title: 'Terms & Conditions Unchecked!');
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
                  'Risk Disclaimer',
                  textAlign: TextAlign.center,
                  style: textMd.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height20),
                ...riskList.mapIndexed((i, risk) => Padding(
                      padding: EdgeInsets.only(
                          bottom: isLast(i, riskList) ? 0 : height08),
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
                  'By clicking “Acknowledge”, you signify your acceptance of these terms and conditions. If you do not agree with any part of this agreement, please refrain from initiating the withdrawal process.',
                  style: textXS,
                ),
                SizedBox(height: height31),
                ctaButton(
                    onPressed: onPressedAcknowledge,
                    isGradient: true,
                    text: 'Aknowledge'),
                SizedBox(height: height24 / 2),
                ctaButton(onPressed: onPressedCancel, text: 'Cancel')
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

const List<String> riskList = [
  'All withdrawal transactions processed through the Payment Gateway are typically completed within 24 hours. However, discrepancies may occur between the withdrawal amount and the amount received due to fees charged by the wallet platform.',
  'Please ensure the accuracy of the USDT Address you provide. Inaccurate or incorrect USDT addresses, or addresses associated with illicit digital currencies, may result in partial or complete loss of funds. The payment gateway disclaims any responsibility for compensation, whether partial or full, as well as any criminal liability, arising from such incidents.',
  'When withdrawing funds, please ensure to input your withdrawal password diligently and maintain confidentiality to prevent any unnecessary losses.',
];
