import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/const.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final void Function(int index)? onChangeTab;
  const HomePage({super.key, this.onChangeTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTransactionType = 'All';
  List<Transaction> currentTransactions = [];

  @override
  Widget build(BuildContext context) {
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
      final merchantWallet = userController.merchantWallet.value!;
      final profilePhoto = userController.user.value?.profilePhoto;

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
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          homeSliverAppbar(
            profilePhoto: profilePhoto,
            onTapProfile: onTapProfile,
            onTapNoti: onTapNoti,
            feeAmount: merchantWallet.totalDepositFee,
            grossAmount: merchantWallet.grossDeposit,
            netAmount: merchantWallet.netDeposit,
            unreadNoti: unreadNoti,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width08 * 2),
                  child: summartBoxBelowAppBar(context,
                      totalDepositNumber: merchantWallet.totalDepositNumber,
                      totalFreezingAmount: merchantWallet.totalFreezingAmount),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width08 * 2, vertical: height08),
                  child: Text(
                    AppLocalizations.of(context)!.current_month_transactions,
                    style: textMd.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width08 * 2),
                  child: tabPickerRow(
                      onTapTab: (transactionType) {
                        setState(() {
                          selectedTransactionType = transactionType;
                        });
                      },
                      transactionTypeList: transactionTypeList,
                      tabNameList: tabNameList(context),
                      selectedTab: selectedTransactionType),
                ),
                SizedBox(
                  height: height08,
                ),
                if (currentTransactions.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height20),
                    child: noTransactionsColumn(context),
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
