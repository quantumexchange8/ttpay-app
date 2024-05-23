import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/home/notification_page.dart';
import 'package:ttpay/pages/home/widgets/home_sliver_appbar.dart';
import 'package:ttpay/pages/home/widgets/no_transactions_found_column.dart';
import 'package:ttpay/pages/home/widgets/summary_box_below_appbar.dart';
import 'package:ttpay/pages/home/widgets/transaction_row.dart';
import 'package:ttpay/component/tab_picker_row.dart';

class HomePage extends StatefulWidget {
  final void Function(int index)? onChangeTab;
  const HomePage({super.key, this.onChangeTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTransactionType = 'All';
  final List<String> tabNameList = ['All', 'Deposit', 'Withdrawal'];
  List<Transaction> currentTransactions = [];

  @override
  Widget build(BuildContext context) {
    const netAmount = 8280828.93;
    const grossAmount = 8973728.37;
    const feeAmount = 8362.38;
    const totalDepositNumber = 1372;
    const totalFreezingAmount = 8362.38;

    void onTapNoti() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationPage(),
          ));
    }

    void onTapProfile() {
      if (widget.onChangeTab != null) {
        widget.onChangeTab!(4);
      }
    }

    return Obx(() {
      final allTransactions = transactionController.transactionList;
      final notifications = notificationController.notificationList;

      final unreadNoti =
          notifications.map((element) => element.unread).contains(true);

      final depositTransactions = allTransactions
          .where(
              (element) => element.transactionType.toLowerCase() == 'deposit')
          .toList();
      final withdrawalTransactions = allTransactions
          .where((element) =>
              element.transactionType.toLowerCase() == 'withdrawal')
          .toList();

      switch (selectedTransactionType) {
        case 'Deposit':
          currentTransactions = depositTransactions;
        case 'Withdrawal':
          currentTransactions = withdrawalTransactions;
          break;
        default:
          currentTransactions = allTransactions;
      }

      currentTransactions = currentTransactions
          .where(
            (element) => element.createdAt.month == DateTime.now().month,
          )
          .toList();
      currentTransactions.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );

      return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          homeSliverAppbar(
            onTapProfile: onTapProfile,
            onTapNoti: onTapNoti,
            feeAmount: feeAmount,
            grossAmount: grossAmount,
            netAmount: netAmount,
            unreadNoti: unreadNoti,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width08 * 2),
                  child: summartBoxBelowAppBar(
                      totalDepositNumber: totalDepositNumber,
                      totalFreezingAmount: totalFreezingAmount),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width08 * 2, vertical: height08),
                  child: Text(
                    'Current Month Transactions',
                    style: textMd.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width08 * 2),
                  child: tabPickerRow(
                      onTapTab: (tabName) {
                        setState(() {
                          selectedTransactionType = tabName;
                        });
                      },
                      tabNameList: tabNameList,
                      selectedTab: selectedTransactionType),
                ),
                SizedBox(
                  height: height08,
                ),
                if (currentTransactions.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height20),
                    child: noTransactionsColumn,
                  )
              ],
            ),
          ),
          SliverList.builder(
            itemCount: currentTransactions.length,
            itemBuilder: (context, index) {
              final transaction = currentTransactions[index];
              return transactionRow(
                  transaction: transaction,
                  isLast: isLast(index, currentTransactions));
            },
          )
        ],
      );
    });
  }
}
