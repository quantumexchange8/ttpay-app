import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:ttpay/component/tab_picker_row.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/transaction/widgets/date_filter_row.dart';
import 'package:ttpay/pages/transaction/widgets/search_bar.dart';

SliverAppBarBuilder transactionTopBar({
  required String selectedTab,
  required void Function(String) onTapTab,
  required TextEditingController searchController,
  void Function()? onTapDatePicker,
  void Function()? onTapFilter,
  required DateTime startDatePicked,
  required DateTime lastDatePicked,
  void Function(String)? onChangedSearch,
}) {
  List<String> tabNameList = [
    'All',
    'Deposit',
    'Withdrawal',
  ];

  return SliverAppBarBuilder(
    leadingActions: const [],
    backgroundColorBar: Colors.transparent,
    backgroundColorAll: Colors.transparent,
    initialBarHeight: height100 * 2.48,
    contentBelowBar: false,
    barHeight: height100 * 1.78,
    initialContentHeight: 0,
    contentBuilder:
        (context, expandRatio, contentHeight, centerPadding, overlapsContent) {
      bool isSmall = contentHeight <= height100 * 1.78;

      return Container(
        decoration: BoxDecoration(
          color: isSmall ? Colors.white.withOpacity(0.05) : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  isSmall ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Text(
                  'Transactions',
                  style: textLg.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: isSmall ? height10 * 1.4 : height20,
                  ),
                ),
              ],
            ),
            if (!isSmall)
              searchBar(
                  onChanged: onChangedSearch, controller: searchController),
            dateFilterRow(
                startDatePicked: startDatePicked,
                lastDatePicked: lastDatePicked,
                onTapDatePicker: onTapDatePicker,
                onTapFilter: onTapFilter),
            tabPickerRow(
                tabNameList: tabNameList,
                selectedTab: selectedTab,
                onTapTab: onTapTab)
          ],
        ),
      );
    },
    pinned: true,
    floating: true,
  );
}
