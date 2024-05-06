import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
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

  @override
  Widget build(BuildContext context) {
    void onTapTab(String tabName) {
      setState(() {
        selectedTab = tabName;
      });
    }

    void onChangedSearch(String text) {}

    void onTapDatePicker() {}

    void onTapFilter() {}

    return Scaffold(
      body: backgroundContainer(
          child: CustomScrollView(
        slivers: [
          transactionTopBar(
              selectedTab: selectedTab,
              onTapTab: onTapTab,
              onChangedSearch: onChangedSearch,
              onTapDatePicker: onTapDatePicker,
              onTapFilter: onTapFilter,
              searchController: _searchController,
              startDatePicked: startDatePicked,
              lastDatePicked: lastDatePicked)
        ],
      )),
    );
  }
}
