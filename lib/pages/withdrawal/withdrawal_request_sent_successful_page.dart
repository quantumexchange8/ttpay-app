import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WithdrawalRequestSentSuccessfulPage extends StatelessWidget {
  const WithdrawalRequestSentSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> withdrawalRequestDetails = {
      AppLocalizations.of(context)!.transaction_id: 'TXN7890123',
      AppLocalizations.of(context)!.date_and_time: '28 Apr 2024  13:26:02',
      AppLocalizations.of(context)!.amount: '\$ 8,000.00 USDT',
      AppLocalizations.of(context)!.usdt_address:
          'TAzY2emMte5Zs4vJu2La8KmXwkzoE78qgs',
    };

    void onPressedDone() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: backgroundContainer(
          padding:
              EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24),
          child: Column(
            children: [
              SizedBox(
                height: height30 * 2,
              ),
              SizedBox(
                height: height100 * 2,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/icon_image/featured_success_icon.png',
                        width: height30 * 5,
                        height: height30 * 5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .withdrawal_request_sent_successful,
                            textAlign: TextAlign.center,
                            style: textMd.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: height08),
                          Text(
                            AppLocalizations.of(context)!
                                .your_withdrawal_will_be_processed,
                            textAlign: TextAlign.center,
                            style: textSm,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height24),
              detailsContainer(withdrawalRequestDetails),
              const Expanded(child: SizedBox()),
              ctaButton(
                  onPressed: onPressedDone,
                  isGradient: true,
                  text: AppLocalizations.of(context)!.done),
              SizedBox(
                height: height24,
              )
            ],
          )),
    );
  }
}

Container detailsContainer(Map<String, dynamic> details) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: height24 / 2, vertical: width08 * 2),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: details.entries
          .mapIndexed((i, e) => Padding(
                padding: EdgeInsets.only(
                    bottom:
                        isLast(i, details.entries.toList()) ? 0 : height24 / 2),
                child: _detailsRow(key: e.key, value: e.value),
              ))
          .toList(),
    ),
  );
}

Row _detailsRow({
  required String key,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          key,
          style: textXS.copyWith(
            color: neutralGrayScale,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          value,
          style: textSm,
        ),
      ),
    ],
  );
}
