import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/withdrawal/enter_account_password_page.dart';
import 'package:ttpay/pages/withdrawal/widgets/available_balance_column.dart';
import 'package:ttpay/pages/withdrawal/widgets/full_withdrawal_textbutton.dart';
import 'package:ttpay/pages/withdrawal/widgets/risk_disclaimer_dialog.dart';
import 'package:ttpay/pages/withdrawal/widgets/withdrawal_amount_container.dart';
import 'package:ttpay/pages/withdrawal/withdrawal_history_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final TextEditingController _usdtAddressController = TextEditingController();
  String? usdtErrorText;
  static const double availableNetBalance = 80828.93;
  final FocusNode _usdtAddressFocusNode = FocusNode();
  final TextEditingController _amountController =
      TextEditingController(text: '0.00');
  bool isFull = false;

  @override
  void initState() {
    super.initState();
    _amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: _amountController.text.length),
    );
  }

  String getUnformattedAmount(String formattedAmount) {
    return formattedAmount.replaceAll(RegExp(r','), '');
  }

  @override
  void dispose() {
    _usdtAddressController.dispose();
    _usdtAddressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double minimumAmount = 100;

    void onPressedHistoryButton() {
      List<Transaction> withdrawalList = transactionController.transactionList
          .where((element) => element.transactionType == 'withdrawal')
          .toList();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WithdrawalHistoryPage(withdrawalTransaction: withdrawalList),
          ));
    }

    void onChangedAmount(String amount) {
      setState(() {
        if (amount.isEmpty) {
          _amountController.text = '0.00';
        }
        isFull = double.parse(getUnformattedAmount(_amountController.text)) ==
            availableNetBalance;
      });
    }

    void onPressedFullWithdrawal() {
      setState(() {
        if (isFull) {
          _amountController.text = '0.00';
        } else {
          _amountController.text = amountFormatter.format(availableNetBalance);
        }
        isFull = !isFull;
      });
    }

    void onPressedProceed() async {
      double currentAmount =
          double.parse(getUnformattedAmount(_amountController.text));
      if (currentAmount < minimumAmount) {
        showToastNotification(context,
            type: 'warning',
            title: AppLocalizations.of(context)!.minimum_amount_required,
            description:
                '${AppLocalizations.of(context)!.the_minimum_withdrawal_amount_must_be} \$ ${minimumAmount.toInt()} USDT');
        return;
      }

      if (currentAmount > availableNetBalance) {
        showToastNotification(context,
            type: 'warning',
            title: AppLocalizations.of(context)!.insufficient_balance);
        return;
      }

      if (_usdtAddressController.text.isEmpty) {
        setState(() {
          usdtErrorText = 'Address is required';
        });
        return;
      } else {
        setState(() {
          usdtErrorText = null;
        });
      }

      await showDialog(
        context: context,
        builder: (context) => const RiskDisclaimerDialog(),
      ).then((value) {
        if (value != null && value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EnterAccountPasswordPage(
                  amount: _amountController.text,
                  usdtAddress: _usdtAddressController.text,
                ),
              ));
        }
      });
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(width08 * 2, 0, width08 * 2, height24 / 2),
            child: twoSimpleAppbar(
                onPressedButton: onPressedHistoryButton,
                leftButtonIcon: Padding(
                  padding: EdgeInsets.only(right: width24 / 4),
                  child: Image.asset(
                    'assets/icon_image/Icon=clock.png',
                    height: height08 * 2,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                title: AppLocalizations.of(context)!.withdrawal,
                buttonText: AppLocalizations.of(context)!.history),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: width08 * 2, vertical: height24 / 2),
              children: [
                availableBalanceColumn(context, balance: availableNetBalance),
                SizedBox(
                  height: height24,
                ),
                withdrawalAmountContainer(
                  context,
                  controller: _amountController,
                  minimumAmount: minimumAmount,
                  onChangedAmount: onChangedAmount,
                ),
                SizedBox(
                  height: height08,
                ),
                Align(
                  alignment: Alignment.center,
                  child: fullWithdrawalTextButton(context,
                      onPressed: onPressedFullWithdrawal, isFull: isFull),
                ),
                // Obx(() {
                //   return Padding(
                //     padding: EdgeInsets.symmetric(vertical: height08 * 2),
                //     child: _feeContainer(
                //         feePercentage:
                //             transactionController.feeChargePercentage.value,
                //         currentAmount: double.parse(_amountController.text)),
                //   );
                // }),
                SizedBox(height: height24),
                customInputTextfield(
                    isRequired: true,
                    errorText: usdtErrorText ?? '',
                    controller: _usdtAddressController,
                    focusNode: _usdtAddressFocusNode,
                    textLabel: AppLocalizations.of(context)!.usdt_address,
                    hintText: AppLocalizations.of(context)!
                        .paste_your_usdt_address_here,
                    showErrorWidget: usdtErrorText != null),
                SizedBox(
                  height: height10 * 4.8,
                ),
                ctaButton(
                  onPressed: onPressedProceed,
                  padding: EdgeInsets.symmetric(
                    horizontal: width20,
                    vertical: height08 * 2,
                  ),
                  isGradient: true,
                  text: AppLocalizations.of(context)!.proceed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container _feeContainer({
  required double feePercentage,
  required double currentAmount,
}) {
  final feeAmount = currentAmount * feePercentage;
  final netAmount = currentAmount - feeAmount;
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width24 / 2, vertical: height08 * 2),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width100 * 1.2,
              child: Text(
                'Fee Charge (${(feePercentage * 100).round()}%)',
                style: textXS.copyWith(color: const Color(0xFF6B7280)),
              ),
            ),
            Expanded(
              child: Text(
                currentAmount == 0
                    ? '-'
                    : '\$${amountFormatter.format(feeAmount)}USDT',
                style: textSm,
              ),
            ),
          ],
        ),
        SizedBox(height: height08),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width100 * 1.2,
              child: Text(
                'Net Amount',
                style: textXS.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Text(
                    netAmount == 0
                        ? '-'
                        : '\$${amountFormatter.format(currentAmount)}USDT',
                    style: textSm),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
