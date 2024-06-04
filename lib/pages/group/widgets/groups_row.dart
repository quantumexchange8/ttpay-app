import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/pages/group/widgets/group_action.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Container groupsRow(BuildContext context,
    {required Group group,
    void Function()? onTapEdit,
    void Function()? onTapDelete}) {
  return Container(
    width: double.infinity,
    padding:
        EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24 / 2),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.50, color: neutralGrayScale.shade800),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: height24 / 2,
              height: height24 / 2,
              decoration: BoxDecoration(
                color: convertColorCode(group.colorCode),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: width08),
            Expanded(
              child: Text(
                group.name,
                style: textMd.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            moreButton(
              onTapEdit: onTapEdit,
              onTapDelete: onTapDelete,
            ),
          ],
        ),
        SizedBox(height: height08),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.gross_deposit_amount,
                    style: textXS.copyWith(
                      color: neutralGrayScale,
                    ),
                  ),
                  Text(
                    '\$ ${amountFormatter.format(group.totalGrossDepositAmount)}',
                    style: textSm.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.gross_withdrawal_amount,
                    style: textXS.copyWith(
                      color: neutralGrayScale,
                    ),
                  ),
                  Text(
                    '\$ ${amountFormatter.format(group.totalGrossWithdrawalAmount)}',
                    style: textSm.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
