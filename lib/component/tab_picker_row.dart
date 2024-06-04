import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';

Widget tabPickerRow(
    {required List<String> tabNameList,
    required List<String> transactionTypeList,
    required String selectedTab,
    required void Function(String transactionType) onTapTab}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...tabNameList.mapIndexed((i, e) {
        final transactionType = transactionTypeList[i];

        return Padding(
          padding:
              EdgeInsets.only(right: isLast(i, tabNameList) ? 0 : width08 / 2),
          child: GestureDetector(
            onTap: () {
              onTapTab(transactionType);
            },
            child: tabContainer(
                tabName: e, isSelected: selectedTab == transactionType),
          ),
        );
      })
    ],
  );
}

Widget tabContainer({required String tabName, required bool isSelected}) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width24 / 2, vertical: height24 / 4),
    decoration: ShapeDecoration(
      color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Text(
      tabName,
      textAlign: TextAlign.center,
      style: textXS.copyWith(),
    ),
  );
}
