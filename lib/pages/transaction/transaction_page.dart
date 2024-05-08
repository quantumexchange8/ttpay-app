import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/pinnable_list.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/dummyData/transactions_history.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/home/widgets/transaction_row.dart';
import 'package:ttpay/pages/transaction/transaction_detail_page.dart';
import 'package:ttpay/pages/transaction/widgets/date_picker.dart';
import 'package:ttpay/pages/transaction/widgets/filter_bottomsheet.dart';
import 'package:ttpay/pages/transaction/widgets/transaction_top_bar.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedTab = 'All';
  DateTime startDatePicked =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDatePicked = DateTime.now();
  final allTransactions = listTransactionFromListMap(dummyTransactions);
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
    switch (selectedTab) {
      case 'Deposit':
        currentTransaction = allTransactions
            .where((element) => element.transactionType == 'deposit')
            .toList();
      case 'Withdrawal':
        currentTransaction = allTransactions
            .where((element) => element.transactionType == 'withdrawal')
            .toList();
        break;
      default:
        currentTransaction = allTransactions;
    }

    for (var element in currentTransaction) {
      if (pinnedTransaction.contains(element)) {
        currentTransaction.remove(element);
        currentTransaction.insert(0, element);
      }
    }

    currentTransaction = currentTransaction
        .where((element) => selectedStatus.contains(element.status))
        .toList();
    currentTransaction = currentTransaction
        .where((element) =>
            element.amount >= startAmount && element.amount <= endAmount)
        .toList();

    if (_searchController.text.isNotEmpty) {
      currentTransaction = currentTransaction
          .where(
            (element) => element.transactionNumber
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()),
          )
          .toList();
    }

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

    return unfocusGestureDetector(
      context,
      child: Scaffold(
        body: backgroundContainer(
            child: CustomScrollView(
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
            SliverList.builder(
              itemCount: currentTransaction.length,
              itemBuilder: (context, index) {
                final transaction = currentTransaction[index];
                bool isPinned = pinnedTransaction.contains(transaction);
                return pinnableList(
                  onPressedPin: () {
                    setState(() {
                      if (isPinned) {
                        pinnedTransaction.remove(transaction);
                      } else {
                        pinnedTransaction.add(transaction);
                      }
                    });
                  },
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
        )),
      ),
    );
  }
}
