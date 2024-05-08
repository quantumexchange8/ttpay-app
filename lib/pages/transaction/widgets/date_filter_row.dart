import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Widget dateFilterRow({
  void Function()? onTapDatePicker,
  void Function()? onTapFilter,
  required DateTime startDatePicked,
  required DateTime lastDatePicked,
}) {
  DateFormat formatDatePicked = DateFormat('dd MMM yyyy');

  return Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: onTapDatePicker,
          child: Container(
            height: height10 * 4,
            padding: EdgeInsets.fromLTRB(width08 * 2, height08, 0, height08),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_image/Icon=calendar.png'),
                SizedBox(width: width24 / 2),
                Expanded(
                  child: Text(
                    '${formatDatePicked.format(startDatePicked)} - ${formatDatePicked.format(lastDatePicked)}',
                    style: textMd,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(width: width08),
      GestureDetector(
        onTap: onTapFilter,
        child: Container(
          padding: EdgeInsets.all(height10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/icon_image/Icon=filter.png',
            height: height20,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    ],
  );
}
