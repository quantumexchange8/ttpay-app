import 'package:flutter/material.dart';
import 'package:ttpay/component/profile_image_container.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/user.dart';

Row accountListRow({
  String? accountPhoto,
  required String accountName,
}) {
  return Row(
    children: [
      profileImageContainer(accountPhoto: accountPhoto, size: height20),
      SizedBox(width: width08),
      Text(
        accountName,
        style: textXS.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Row addAccountRow() {
  return Row(
    children: [
      Icon(
        Icons.add,
        size: height20,
        color: primaryPurpleScale.shade600,
      ),
      SizedBox(width: width08),
      Expanded(
        child: Text(
          'Add Account',
          style: textSm.copyWith(
            color: primaryPurpleScale.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Container paddingWithBottomDividerContainer({Widget? child}) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: height24 / 2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.50, color: neutralGrayScale.shade800),
        ),
      ),
      child: child);
}

Container accountListContainer(
    {required List<User> userAccounts, void Function()? onTapAddAccount}) {
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
      children: [
        ...userAccounts.map(
          (e) => paddingWithBottomDividerContainer(
              child: accountListRow(
                  accountName: e.name, accountPhoto: e.profilePhoto)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: height24 / 2),
          child: InkWell(onTap: onTapAddAccount, child: addAccountRow()),
        )
      ],
    ),
  );
}
