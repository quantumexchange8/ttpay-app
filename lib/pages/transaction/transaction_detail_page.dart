import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/status_badges.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionDetailPage extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    bool isDeposit = transaction.transactionType == 'deposit';
    String indicator = isDeposit ? '+' : '-';

    Map<String, dynamic> userData = {
      AppLocalizations.of(context)!.name: transaction.userInfo.name,
      AppLocalizations.of(context)!.email: transaction.userInfo.email,
      AppLocalizations.of(context)!.under_group:
          transaction.pinnedGroup == null ? '-' : transaction.pinnedGroup!.name
    };

    Map<String, dynamic> feeAmount = {
      AppLocalizations.of(context)!.transaction_id:
          transaction.transactionNumber,
      AppLocalizations.of(context)!.approval_date:
          transaction.approvalDate == null
              ? '-'
              : rowDateFormat.format(transaction.approvalDate!),
      AppLocalizations.of(context)!.amount:
          '$indicator\$ ${amountFormatter.format(transaction.amount)} USDT',
      AppLocalizations.of(context)!.fee:
          '\$ ${amountFormatter.format(transaction.fee)} USDT',
    };

    Map<String, dynamic> addressData = {
      AppLocalizations.of(context)!.txid: transaction.txId,
      AppLocalizations.of(context)!.sent_address: transaction.sentAddress,
      AppLocalizations.of(context)!.receiving_address:
          transaction.receivingAddress
    };

    return backgroundContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      padding: EdgeInsets.symmetric(
        vertical: height24,
        horizontal: width08 * 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBottomsheet(
              context, AppLocalizations.of(context)!.transaction_details),
          SizedBox(height: height24),
          Text(
            '$indicator \$ ${amountFormatter.format(transaction.amount)}',
            style: textXL.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: height08 / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rowDateFormat.format(transaction.createdAt),
                style: textSm.copyWith(
                  color: neutralGrayScale.shade300,
                ),
              ),
              StatusBadges(status: transaction.status),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height20),
            child: containerOnlyTopBorder(
              child: transactionInfoColumn(userData),
            ),
          ),
          containerOnlyTopBorder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                transactionInfoColumn(feeAmount),
                Padding(
                  padding: EdgeInsets.only(top: height08),
                  child: transactionInfoRow(
                      key: AppLocalizations.of(context)!.net_amount,
                      value:
                          '$indicator\$ ${amountFormatter.format(transaction.netAmount)} USDT',
                      valueStyle: textSm.copyWith(
                          color: isDeposit
                              ? successGreenScale
                              : errorRedScale.shade600)),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height20),
            child: addressContainer(
                onTapCopy: (address) async {
                  copyToClipboard(context, address);
                },
                addressData: addressData),
          ),
          if (transaction.description != null)
            descriptionContainer(context,
                description: transaction.description!),
        ],
      ),
    );
  }
}

Container containerOnlyTopBorder({Widget? child}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(top: height24 / 2),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 1, color: neutralGrayScale.shade800),
      ),
    ),
    child: child,
  );
}

Container addressContainer(
    {required void Function(String address) onTapCopy,
    required Map<String, dynamic> addressData}) {
  return containerOnlyTopBorder(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: addressData.entries
          .mapIndexed((i, e) => Padding(
                padding: EdgeInsets.only(
                    bottom:
                        isLast(i, addressData.entries.toList()) ? 0 : height08),
                child: addressColumn(
                    onTapCopy: () {
                      onTapCopy(e.value);
                    },
                    key: e.key,
                    value: e.value),
              ))
          .toList(),
    ),
  );
}

Container descriptionContainer(BuildContext context,
    {required String description}) {
  return containerOnlyTopBorder(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.description,
          style: textXS.copyWith(
            color: neutralGrayScale,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: height08 / 2),
        Text(
          description,
          style: textSm,
        ),
      ],
    ),
  );
}

Column transactionInfoColumn(
  Map<String, dynamic> infoList,
) {
  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infoList.entries
          .mapIndexed(
            (i, e) => Padding(
              padding: EdgeInsets.only(
                  bottom: isLast(i, infoList.entries.toList()) ? 0 : height08),
              child: transactionInfoRow(
                key: e.key,
                value: e.value,
              ),
            ),
          )
          .toList());
}

Row transactionInfoRow({
  required String key,
  required String value,
  TextStyle? keyStyle,
  TextStyle? valueStyle,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          key,
          style: keyStyle ??
              textXS.copyWith(
                color: neutralGrayScale,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          value,
          style: valueStyle ?? textSm,
        ),
      ),
    ],
  );
}

Column addressColumn({
  void Function()? onTapCopy,
  required String key,
  required String value,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        key,
        style: textXS.copyWith(
          color: neutralGrayScale,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: height08 / 2),
      Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: textSm.copyWith(),
            ),
          ),
          SizedBox(width: width08),
          InkWell(
            onTap: onTapCopy,
            child: Image.asset(
              'assets/icon_image/copy_icon.png',
              height: height08 * 2,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    ],
  );
}
