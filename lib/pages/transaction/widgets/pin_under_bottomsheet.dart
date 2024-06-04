import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Column noGroupsCreatedColumn(
  BuildContext context, {
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
        AppLocalizations.of(context)!.no_groups,
        textAlign: TextAlign.center,
        style: textMd.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: height08),
      Text(
        AppLocalizations.of(context)!.no_groups_description,
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
          text: AppLocalizations.of(context)!.create_group)
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

class PinUnderBottomsheet extends StatelessWidget {
  final List<Group> groupList;
  final void Function()? onPressedCreateGroup;
  final void Function(Group group) onTapGroup;
  const PinUnderBottomsheet(
      {super.key,
      required this.groupList,
      this.onPressedCreateGroup,
      required this.onTapGroup});

  @override
  Widget build(BuildContext context) {
    return backgroundContainer(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              topBottomsheet(context, AppLocalizations.of(context)!.pin_under),
              SizedBox(
                height: height24,
              ),
              if (groupList.isNotEmpty)
                ...groupList.mapIndexed((i, group) => InkWell(
                      onTap: () {
                        onTapGroup(group);
                      },
                      child: groupRow(
                          isLast: isLast(i, groupList),
                          groupColor: convertColorCode(group.colorCode),
                          groupName: group.name),
                    )),
              if (groupList.isEmpty)
                noGroupsCreatedColumn(
                  context,
                  onPressedCreateGroup: onPressedCreateGroup,
                )
            ],
          ),
        ),
      ),
    );
  }
}
