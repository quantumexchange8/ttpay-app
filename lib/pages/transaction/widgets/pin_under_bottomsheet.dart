import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';

Column noGroupsCreatedColumn({
  required void Function()? onPressedCreateGroup,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        'assets/images/empty.png',
        width: width100 * 2.8,
        fit: BoxFit.fitWidth,
      ),
      Text(
        'No Groups Created Yet',
        textAlign: TextAlign.center,
        style: textMd.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: height08),
      Text(
        'It seems like you haven\'t created any groups yet. Start by creating your first one now! 🌟',
        textAlign: TextAlign.center,
        style: textSm.copyWith(
          color: neutralGrayScale,
        ),
      ),
      SizedBox(
        height: height31,
      ),
      ctaButton(
          onPressed: onPressedCreateGroup,
          bgColor: primaryPurpleScale.shade700,
          text: 'Create Group')
    ],
  );
}

Row topBottomsheet(
  BuildContext context,
  String title,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: textMd.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          color: neutralGrayScale.shade400,
          size: height20,
        ),
        padding: EdgeInsets.zero,
        focusColor: primaryPurpleScale.shade300.withOpacity(0.3),
      ),
    ],
  );
}

Column groupRow({
  required bool isLast,
  required Color groupColor,
  required String groupName,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: height10 * 1.4),
        child: Row(
          children: [
            Container(
              width: height24 / 2,
              height: height24 / 2,
              decoration: BoxDecoration(
                color: groupColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: width24 / 2),
            Text(
              groupName,
              style: textSm.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      if (!isLast)
        Padding(
          padding: EdgeInsets.only(top: height10 * 1.4),
          child: Divider(
            color: neutralGrayScale.shade800,
            thickness: 0.5,
          ),
        )
    ],
  );
}

BottomSheet pinUnderBottomsheet({
  required List<Group> groupList,
}) {
  return BottomSheet(
    enableDrag: false,
    onClosing: () {},
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          topBottomsheet(context, 'Pin Under'),
          SizedBox(
            height: height24,
          ),
          if (groupList.isNotEmpty)
            ...groupList.mapIndexed((i, group) => groupRow(
                isLast: isLast(i, groupList),
                groupColor: convertColorCode(group.colorCode),
                groupName: group.name)),
          if (groupList.isEmpty)
            noGroupsCreatedColumn(
              onPressedCreateGroup: () {},
            )
        ],
      );
    },
  );
}
