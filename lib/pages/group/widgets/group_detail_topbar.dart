import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/tab_picker_row.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/pages/group/widgets/overview_container.dart';
import 'package:ttpay/pages/transaction/widgets/date_filter_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SliverAppBarBuilder groupDetailTopBar(BuildContext context,
    {void Function()? onTapDatePicker,
    void Function()? onTapFilter,
    required void Function(String) onTapTab,
    required Group group,
    required DateTime startDatePicked,
    required DateTime lastDatePicked,
    required String selectedTab}) {
  Map<String, dynamic> overviewData = {
    AppLocalizations.of(context)!.total_deposit_number:
        group.totalDepositNumber.toString(),
    AppLocalizations.of(context)!.total_deposit_amount_gross:
        '\$ ${amountFormatter.format(group.totalGrossDepositAmount)}',
    AppLocalizations.of(context)!.total_deposit_amount_net:
        '\$ ${amountFormatter.format(group.totalNetDepositAmount)}',
    AppLocalizations.of(context)!.total_withdrawal_number:
        group.totalWithdrawalNumber.toString(),
    AppLocalizations.of(context)!.total_withdrawal_amount_gross:
        '\$ ${amountFormatter.format(group.totalGrossWithdrawalAmount)}',
    AppLocalizations.of(context)!.total_withdrawal_amount_net:
        '\$ ${amountFormatter.format(group.totalNetWithdrawalAmount)}',
  };

  return SliverAppBarBuilder(
    leadingActions: const [],
    backgroundColorBar: Colors.transparent,
    backgroundColorAll: Colors.transparent,
    initialBarHeight: height100 * 3.6,
    contentBelowBar: false,
    barHeight: height100 * 1.5,
    initialContentHeight: 0,
    pinned: true,
    contentBuilder:
        (context, expandRatio, contentHeight, centerPadding, overlapsContent) {
      return backgroundContainer(
          child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height24 / 2, horizontal: width08 * 2),
        color: Colors.white.withOpacity(0.05),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: height24,
                    ),
                  ),
                  SizedBox(
                    width: width24 / 2,
                  ),
                  Text(
                    group.name,
                    style: textLg.copyWith(fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: height08 / 4,
              ),
              if (contentHeight >= height100 * 3)
                Padding(
                  padding: EdgeInsets.only(top: height24 / 2),
                  child: overviewContainer(overviewData: overviewData),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height24 / 2),
                child: dateFilterRow(
                    onTapDatePicker: onTapDatePicker,
                    onTapFilter: onTapFilter,
                    startDatePicked: startDatePicked,
                    lastDatePicked: lastDatePicked),
              ),
              tabPickerRow(
                  transactionTypeList: transactionTypeList,
                  tabNameList: tabNameList(context),
                  selectedTab: selectedTab,
                  onTapTab: onTapTab)
            ],
          ),
        ),
      ));
    },
  );
}
