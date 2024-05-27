import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/pinnable_list.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/group/widgets/new_group_bottomsheet.dart';
import 'package:ttpay/pages/home/widgets/no_transactions_found_column.dart';
import 'package:ttpay/pages/home/widgets/transaction_row.dart';
import 'package:ttpay/pages/transaction/transaction_detail_page.dart';
import 'package:ttpay/pages/transaction/widgets/date_picker.dart';
import 'package:ttpay/pages/transaction/widgets/filter_bottomsheet.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';
import 'package:ttpay/pages/transaction/widgets/transaction_top_bar.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Group> groupListData = groupController.groupList;
  List<Transaction> allTransactions = transactionController.transactionList;
  final TextEditingController _searchController = TextEditingController();
  String selectedTab = 'All';
  DateTime startDatePicked =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDatePicked = DateTime(DateTime.now().year, DateTime.now().month,
      determineTotalDaysOfMonth(DateTime.now().month));
  List<Transaction> currentTransaction = [];
  List<Transaction> pinnedTransaction = [];
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

  @override
  void initState() {
    super.initState();

    List<double> allAmount = allTransactions.map((e) => e.amount).toList();

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

    void onChangedSearch(String text) {
      setState(() {});
    }

    void onTapClear() {
      setState(() {
        _searchController.clear();
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

    Future<void> onPressedPin(bool isPinned, Transaction transaction) async {
      if (isPinned) {
        final newTransaction = transaction;
        newTransaction.pinnedGroup = null;
        transactionController.updateTransaction(
            id: transaction.id, newTransaction: newTransaction);
      } else {
        await customShowModalBottomSheet(
          context: context,
          builder: (context) => PinUnderBottomsheet(
            onPressedCreateGroup: () async {
              await customShowModalBottomSheet(
                context: context,
                builder: (context) => const NewGroupBottomsheet(),
              ).then((newGroup) {
                groupController.addGroup(newGroup);
              });
            },
            onTapGroup: (group) {
              Transaction newTransaction = transaction;
              newTransaction.pinnedGroup = group;
              transactionController.updateTransaction(
                  id: transaction.id, newTransaction: newTransaction);
              Navigator.pop(context);
            },
            groupList: groupListData,
          ),
        );
      }
    }

    return Obx(() {
      groupListData = groupController.groupList;
      allTransactions = transactionController.transactionList;
      pinnedTransaction =
          allTransactions.where((tr) => tr.pinnedGroup != null).toList();

      //tab filter
      if (selectedTab == 'All') {
        currentTransaction = allTransactions;
      } else {
        currentTransaction = allTransactions
            .where((element) =>
                element.transactionType == selectedTab.toLowerCase())
            .toList();
      }

      //filter date
      currentTransaction = currentTransaction
          .where((element) =>
              element.createdAt.isAfter(
                  startDatePicked.subtract(const Duration(seconds: 1))) &&
              element.createdAt
                  .isBefore(lastDatePicked.add(const Duration(seconds: 1))))
          .toList();

      //status filter
      currentTransaction = currentTransaction
          .where((element) => selectedStatus.contains(element.status))
          .toList();
      //amount range filter
      currentTransaction = currentTransaction
          .where((element) =>
              element.amount >= startAmount && element.amount <= endAmount)
          .toList();

      //search filter
      if (_searchController.text.isNotEmpty) {
        currentTransaction = currentTransaction.where(
          (element) {
            final searchText = _searchController.text.toLowerCase();

            return element.transactionNumber
                    .toLowerCase()
                    .contains(searchText) ||
                element.userInfo.name.toLowerCase().contains(searchText) ||
                element.userInfo.email.toLowerCase().contains(searchText);
          },
        ).toList();
      }

      //sort latest date first
      if (currentTransaction.length > 1) {
        currentTransaction.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
      }

      if (pinnedTransaction.length > 1) {
        pinnedTransaction.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
      }

      //pinned first
      currentTransaction.removeWhere(
        (element) => pinnedTransaction.contains(element),
      );
      currentTransaction.insertAll(0, pinnedTransaction);

      return CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          transactionTopBar(
              selectedTab: selectedTab,
              onTapTab: onTapTab,
              onChangedSearch: onChangedSearch,
              onTapDatePicker: onTapDatePicker,
              onTapFilter: onTapFilter,
              onTapClear: onTapClear,
              searchController: _searchController,
              startDatePicked: startDatePicked,
              lastDatePicked: lastDatePicked),
          currentTransaction.isEmpty
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed([
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height20 * 2, horizontal: width08 * 2),
                    child: _searchController.text.isNotEmpty
                        ? noSearchColumn
                        : noTransactionsColumn,
                  )
                ]))
              : SliverList.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  itemCount: currentTransaction.length,
                  itemBuilder: (context, index) {
                    final transaction = currentTransaction[index];
                    final isPinned = pinnedTransaction.contains(transaction);
                    return pinnableList(
                      onPressedPin: () async {
                        await onPressedPin(isPinned, transaction);
                      },
                      isPinned: isPinned,
                      child: InkWell(
                        onTap: () async {
                          await customShowModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                TransactionDetailPage(transaction: transaction),
                          );
                        },
                        child: transactionRow(
                            isPinned: isPinned,
                            transaction: transaction,
                            isLast: isLast(index, currentTransaction)),
                      ),
                    );
                  },
                )
        ],
      );
    });
  }
}

Column noSearchColumn = Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      'No Search Results',
      textAlign: TextAlign.center,
      style: textMd.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
    SizedBox(height: height08),
    Text(
      'Oops! It seems there are no results matching your search. Please try another phrase.',
      textAlign: TextAlign.center,
      style: textXS.copyWith(
        color: neutralGrayScale,
      ),
    ),
  ],
);
