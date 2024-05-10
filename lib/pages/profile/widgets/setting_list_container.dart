import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/profile/widgets/account_list_container.dart';

Row settingListRow({
  required String settingIconAddress,
  required String settingName,
}) {
  return Row(
    children: [
      Image.asset(
        settingIconAddress,
        height: height20,
        fit: BoxFit.fitHeight,
      ),
      SizedBox(width: width08),
      Expanded(
        child: Text(
          settingName,
          style: textSm.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Icon(
        Icons.arrow_forward_ios,
        size: height20,
        color: neutralGrayScale.shade400,
      ),
    ],
  );
}

Container settingListContainer({
  required List<Map<String, dynamic>> accountSettings,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width24 / 2),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: accountSettings
          .map((e) => paddingWithBottomDividerContainer(
                  child: InkWell(
                onTap: e['on_tap'],
                child: settingListRow(
                    settingIconAddress: e['icon_address'],
                    settingName: e['name']),
              )))
          .toList(),
    ),
  );
}
