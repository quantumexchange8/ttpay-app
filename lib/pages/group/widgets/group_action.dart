import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

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

PopupMenuButton<bool?> moreButton({
  void Function()? onTapEdit,
  void Function()? onTapDelete,
}) {
  return PopupMenuButton<bool?>(
    color: Colors.white.withOpacity(0.05),
    surfaceTintColor: Colors.white.withOpacity(0.05),
    constraints:
        BoxConstraints(minWidth: width100 * 1.2, minHeight: height10 * 4.8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          onTap: onTapEdit,
          height: height10 * 4.8,
          padding: EdgeInsets.symmetric(
              vertical: height10 * 1.4, horizontal: width24 / 2),
          child: _actionRow(
            actionName: 'Edit',
            iconAddress: 'assets/icon_image/edit_icon.png',
          ),
        ),
        PopupMenuItem(
          height: 1,
          child: Divider(
            height: 1,
            color: neutralGrayScale.shade800,
            thickness: 0.5,
          ),
        ),
        PopupMenuItem(
          onTap: onTapDelete,
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
      ];
    },
    child: Image.asset(
      'assets/icon_image/more_icon.png',
      height: height24,
      fit: BoxFit.fitHeight,
    ),
  );
}
