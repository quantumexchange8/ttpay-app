import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/pinnable_list.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/group/widgets/group_detail_topbar.dart';
import 'package:ttpay/pages/home/widgets/no_transactions_found_column.dart';
import 'package:ttpay/pages/home/widgets/transaction_row.dart';
import 'package:ttpay/pages/transaction/transaction_detail_page.dart';
import 'package:ttpay/pages/transaction/widgets/date_picker.dart';
import 'package:ttpay/pages/transaction/widgets/filter_bottomsheet.dart';

class GroupDetailPage extends StatefulWidget {
  final Group group;
  const GroupDetailPage({super.key, required this.group});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  List<Transaction> groupTransaction = [];
  String selectedTab = 'All';
  DateTime startDatePicked =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDatePicked = DateTime.now();
  List<Transaction> currentTransaction = [];
  List<double> allAmount = [];
  List<String> selectedStatus = [
    'success',
    'rejected',
    'pending',
    'freezing',
  ];
  double minAmount = 0;
  double maxAmount = 30000;
  late double startAmount;
  late double endAmount;

  List<Transaction> getGroupTransaction(List<Transaction> transactionList) {
    return transactionList.where((tr) {
      if (tr.pinnedGroup != null) {
        return tr.pinnedGroup!.id == widget.group.id;
      } else {
        return false;
      }
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    groupTransaction =
        getGroupTransaction(transactionController.transactionList);
    allAmount = groupTransaction.map((e) => e.amount).toList();

    if (allAmount.isNotEmpty) {
      minAmount = allAmount.min;
      maxAmount = allAmount.max;
      startAmount = minAmount;
      endAmount = maxAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    void onTapTab(String tabName) {
      setState(() {
        selectedTab = tabName;
      });
    }

    void onTapDatePicker() async {
      await customShowModalBottomSheet(
        context: context,
        builder: (context) => DatePickerBottomsheet(
          firstDatePicked: startDatePicked,
          lastDatePicked: lastDatePicked,
        ),
      ).then((value) {
        if (value != null) {
          setState(() {
            startDatePicked = value[0];
            lastDatePicked = value[1];
          });
        }
      });
    }

    void onTapFilter() async {
      await customShowModalBottomSheet(
        context: context,
        builder: (context) => FilterBottomsheet(
          selectedStatus: selectedStatus,
          maxAmount: maxAmount,
          minAmount: minAmount,
          startAmount: startAmount,
          endAmount: endAmount,
        ),
      ).then((value) {
        if (value != null) {
          setState(() {
            selectedStatus = value[0];
            startAmount = value[1];
            endAmount = value[2];
          });
        }
      });
    }

    return unfocusGestureDetector(
      context,
      child: Scaffold(
        body: backgroundContainer(child: Obx(() {
          groupTransaction =
              getGroupTransaction(transactionController.transactionList);

          //switch tab filter
          if (selectedTab == 'All') {
            currentTransaction = groupTransaction;
          } else {
            currentTransaction = groupTransaction
                .where((element) =>
                    element.transactionType == selectedTab.toLowerCase())
                .toList();
          }

          //status filter
          currentTransaction = currentTransaction
              .where((element) => selectedStatus.contains(element.status))
              .toList();

          //amount range filter
          currentTransaction = currentTransaction
              .where((element) =>
                  element.amount >= startAmount && element.amount <= endAmount)
              .toList();

          //filter date
          currentTransaction = currentTransaction
              .where((element) =>
                  element.createdAt.isAfter(
                      startDatePicked.subtract(const Duration(seconds: 1))) &&
                  element.createdAt
                      .isBefore(lastDatePicked.add(const Duration(seconds: 1))))
              .toList();

          //sort latest date first
          if (currentTransaction.length > 1) {
            currentTransaction.sort(
              (a, b) => b.createdAt.compareTo(a.createdAt),
            );
          }

          return CustomScrollView(
            slivers: [
              groupDetailTopBar(
                  selectedTab: selectedTab,
                  onTapTab: onTapTab,
                  onTapDatePicker: onTapDatePicker,
                  onTapFilter: onTapFilter,
                  group: widget.group,
                  startDatePicked: startDatePicked,
                  lastDatePicked: lastDatePicked),
              currentTransaction.isEmpty
                  ? SliverList(
                      delegate: SliverChildListDelegate.fixed([
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height20 * 2, horizontal: width08 * 2),
                        child: noTransactionsColumn,
                      )
                    ]))
                  : SliverList.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemCount: currentTransaction.length,
                      itemBuilder: (context, index) {
                        final transaction = currentTransaction[index];
                        return pinnableList(
                          onPressedPin: () {
                            final newTransaction = transaction;
                            newTransaction.pinnedGroup = null;
                            transactionController.updateTransaction(
                                id: transaction.id,
                                newTransaction: newTransaction);
                          },
                          isPinned: true,
                          child: InkWell(
                            onTap: () async {
                              await customShowModalBottomSheet(
                                context: context,
                                builder: (context) => TransactionDetailPage(
                                    transaction: transaction),
                              );
                            },
                            child: transactionRow(
                                isPinned: false,
                                transaction: transaction,
                                isLast: isLast(index, currentTransaction)),
                          ),
                        );
                      },
                    )
            ],
          );
        })),
      ),
    );
  }
}
