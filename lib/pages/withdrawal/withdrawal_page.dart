import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/pages/withdrawal/widgets/available_balance_column.dart';
import 'package:ttpay/pages/withdrawal/widgets/full_withdrawal_textbutton.dart';
import 'package:ttpay/pages/withdrawal/widgets/withdrawal_amount_container.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key});

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  static const double availableNetBalance = 80828.93;
  final FocusNode _usdtAddressFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController(
    text: '0.00',
  );
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
  Widget build(BuildContext context) {
    void onPressedHistoryButton() {}

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

    void onPressedProceed() {}

    return unfocusGestureDetector(
      context,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: twoSimpleAppbar(
            onPressedButton: onPressedHistoryButton,
            leftButtonIcon: Padding(
              padding: EdgeInsets.only(right: width24 / 4),
              child: Image.asset(
                'assets/icon_image/Icon=clock.png',
                height: height08 * 2,
                fit: BoxFit.fitHeight,
              ),
            ),
            title: 'Withdrawal',
            buttonText: 'History'),
        body: backgroundContainer(
            padding: EdgeInsets.symmetric(
                horizontal: width08 * 2, vertical: height24 / 2),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  availableBalanceColumn(availableNetBalance),
                  SizedBox(
                    height: height24,
                  ),
                  withdrawalAmountContainer(
                      controller: _amountController,
                      onChangedAmount: onChangedAmount,
                      maxValue: availableNetBalance),
                  SizedBox(
                    height: height08,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: fullWithdrawalTextButton(
                        onPressed: onPressedFullWithdrawal, isFull: isFull),
                  ),
                  SizedBox(
                    height: height24,
                  ),
                  customInputTextfield(
                      isRequired: true,
                      focusNode: _usdtAddressFocusNode,
                      textLabel: 'USDT Address',
                      hintText: 'Paste your USDT address here',
                      showErrorWidget: false),
                  SizedBox(
                    height: height10 * 4.8,
                  ),
                  ctaButton(
                    onPressed: onPressedProceed,
                    isGradient: true,
                    text: 'Proceed',
                  )
                ],
              ),
            )),
      ),
    );
  }
}
