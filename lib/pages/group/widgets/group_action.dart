import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Future<T?> showGroupAction<T>({required BuildContext context}) {
  return showMenu(
      context: context,
      position: RelativeRect.fill,
      color: Colors.white.withOpacity(0.05),
      surfaceTintColor: Colors.white.withOpacity(0.05),
      constraints:
          BoxConstraints(minWidth: width100 * 1.2, minHeight: height10 * 4.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          onTap: () {},
          height: height10 * 4.8,
          padding: EdgeInsets.symmetric(
              vertical: height10 * 1.4, horizontal: width24 / 2),
          child: _actionRow(
            actionName: 'Edit',
            iconAddress: 'assets/icon_image/edit_icon.png',
          ),
        ),
        const PopupMenuDivider(
          height: 1,
        ),
        PopupMenuItem(
          onTap: () {
            Navigator.pop(context, true);
          },
          height: height10 * 4.8,
          padding: EdgeInsets.symmetric(
              vertical: height10 * 1.4, horizontal: width24 / 2),
          child: _actionRow(
              actionName: 'Delete',
              iconAddress: 'assets/icon_image/delete_icon.png',
              actionNameStyle: textSm.copyWith(
                color: errorRedScale.shade600,
                fontWeight: FontWeight.w500,
              )),
        )
      ]);
}

Row _actionRow({
  required String actionName,
  required String iconAddress,
  TextStyle? actionNameStyle,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          actionName,
          style: actionNameStyle ??
              textSm.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      Image.asset(
        iconAddress,
        width: 20,
        height: height20,
        fit: BoxFit.fitHeight,
      ),
    ],
  );
}
