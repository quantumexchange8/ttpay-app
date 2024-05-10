import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/component/two_simple_appbar.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/dummyData/transactions_history.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/withdrawal/enter_account_password_page.dart';
import 'package:ttpay/pages/withdrawal/widgets/available_balance_column.dart';
import 'package:ttpay/pages/withdrawal/widgets/full_withdrawal_textbutton.dart';
import 'package:ttpay/pages/withdrawal/widgets/risk_disclaimer_dialog.dart';
import 'package:ttpay/pages/withdrawal/widgets/withdrawal_amount_container.dart';
import 'package:ttpay/pages/withdrawal/withdrawal_history_page.dart';

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
    double minimumAmount = 100;

    void onPressedHistoryButton() {
      List<Transaction> withdrawalList =
          listTransactionFromListMap(dummyTransactions)
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
            title: 'Minimum Amount Required!',
            description:
                'The minimum withdrawal amount must be \$ ${minimumAmount.toInt()} USDT');
        return;
      }

      if (currentAmount > availableNetBalance) {
        showToastNotification(context,
            type: 'warning', title: 'Insufficient Balance');
        return;
      }

      await showDialog(
        context: context,
        builder: (context) => const RiskDisclaimerDialog(),
      ).then((value) {
        if (value != null && value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EnterAccountPasswordPage(),
              ));
        }
      });
    }

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
              child: ListView(
                children: [
                  availableBalanceColumn(availableNetBalance),
                  SizedBox(
                    height: height24,
                  ),
                  withdrawalAmountContainer(
                    controller: _amountController,
                    minimumAmount: minimumAmount,
                    onChangedAmount: onChangedAmount,
                  ),
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
