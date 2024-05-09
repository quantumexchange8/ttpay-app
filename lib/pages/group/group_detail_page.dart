import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/pinnable_list.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/pages/group/widgets/group_detail_topbar.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String selectedTab = 'All';
  DateTime startDatePicked =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDatePicked = DateTime.now();
  List<Transaction> currentTransaction = [];
  List<Transaction> pinnedTransaction = [];
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

  @override
  void initState() {
    super.initState();

    allAmount = widget.group.transactionList.map((e) => e.amount).toList();

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
        currentTransaction = widget.group.transactionList
            .where((element) => element.transactionType == 'deposit')
            .toList();
      case 'Withdrawal':
        currentTransaction = widget.group.transactionList
            .where((element) => element.transactionType == 'withdrawal')
            .toList();
        break;
      default:
        currentTransaction = widget.group.transactionList;
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
            groupDetailTopBar(
                selectedTab: selectedTab,
                onTapTab: onTapTab,
                onTapDatePicker: onTapDatePicker,
                onTapFilter: onTapFilter,
                group: widget.group,
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
