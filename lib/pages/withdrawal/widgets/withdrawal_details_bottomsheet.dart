import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/status_badges.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/transaction/transaction_detail_page.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';

class WithdrawalDetailsBottomsheet extends StatelessWidget {
  final Transaction withdrawal;
  const WithdrawalDetailsBottomsheet({super.key, required this.withdrawal});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> withdrawalDetails = {
      'Transaction ID': withdrawal.transactionNumber,
      'Requested Date': rowDateFormat.format(withdrawal.createdAt),
      'Approval Date': withdrawal.approvalDate == null
          ? '-'
          : rowDateFormat.format(withdrawal.approvalDate!),
      'Amount': '\$ ${amountFormatter.format(withdrawal.amount)} USDT',
      'Fee': '\$ ${amountFormatter.format(withdrawal.fee)} USDT',
    };

    Map<String, dynamic> addressData = {
      'From': withdrawal.receivingAddress,
      'To': withdrawal.sentAddress,
    };

    return backgroundContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: height24,
          horizontal: width08 * 2,
        ),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            topBottomsheet(context, 'Withdrawal Details'),
            SizedBox(height: height24),
            transactionInfoColumn(withdrawalDetails),
            Padding(
              padding: EdgeInsets.only(top: height08),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Status',
                      style: textXS.copyWith(
                        color: neutralGrayScale,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        statusBadges(withdrawal.status),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height20),
              child: addressContainer(
                  onTapCopy: (address) {
                    copyToClipboard(context, address);
                  },
                  addressData: addressData),
            ),
            if (withdrawal.description != null)
              descriptionContainer(withdrawal.description!),
          ],
        ),
      ),
    );
  }
}
