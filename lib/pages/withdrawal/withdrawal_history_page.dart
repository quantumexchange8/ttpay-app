import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/empty_image_column.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/withdrawal/widgets/withdrawal_container.dart';
import 'package:ttpay/pages/withdrawal/widgets/withdrawal_details_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WithdrawalHistoryPage extends StatelessWidget {
  final List<Transaction> withdrawalTransaction;
  const WithdrawalHistoryPage({super.key, required this.withdrawalTransaction});

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Transaction>> groupWithdrawalsPerMonth =
        groupBy(withdrawalTransaction, (withdrawal) {
      DateTime createdAt = withdrawal.createdAt;
      return DateTime(createdAt.year, createdAt.month);
    });
    final entries = groupWithdrawalsPerMonth.entries.toList();

    return Scaffold(
      appBar: simpleAppBar(
          onTapBack: () {
            Navigator.pop(context);
          },
          title: AppLocalizations.of(context)!.withdrawal_history),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          padding:
              EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height20),
          child: entries.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: emptyImageColumn(
                      imageAddress: 'assets/images/no-transaction.png',
                      title: AppLocalizations.of(context)!
                          .withdrawal_history_empty,
                      description: AppLocalizations.of(context)!
                          .withdrawal_history_empty_description),
                )
              : SafeArea(
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: isLast(index, entries) ? 0 : height24),
                        child: withdrawalPerMonthColumn(
                            onTapWithdrawal: (withdrawal) {
                              customShowModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      WithdrawalDetailsBottomsheet(
                                          withdrawal: withdrawal));
                            },
                            groupMonth: entry.key,
                            groupTransactions: entry.value),
                      );
                    },
                  ),
                )),
    );
  }
}

Column withdrawalPerMonthColumn({
  required void Function(Transaction withdrawal) onTapWithdrawal,
  required DateTime groupMonth,
  required List<Transaction> groupTransactions,
}) {
  groupTransactions.sort(
    (a, b) => b.createdAt.compareTo(a.createdAt),
  );

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        DateFormat('MMMM yyyy').format(groupMonth),
        style: textSm.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: height08),
      ...groupTransactions.mapIndexed((i, e) => Padding(
            padding: EdgeInsets.only(
                bottom: isLast(i, groupTransactions) ? 0 : height08),
            child: InkWell(
                onTap: () {
                  onTapWithdrawal(e);
                },
                child: withdrawalContainer(e)),
          ))
    ],
  );
}
