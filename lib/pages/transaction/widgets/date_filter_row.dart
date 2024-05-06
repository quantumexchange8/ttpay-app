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
      GestureDetector(
        onTap: onTapDatePicker,
        child: Expanded(
          child: Container(
            height: height10 * 4,
            padding: EdgeInsets.symmetric(
                horizontal: width08 * 2, vertical: height08),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_image/Icon=calender.png'),
                SizedBox(width: width24 / 2),
                Text(
                  '${formatDatePicked.format(startDatePicked)} - ${formatDatePicked.format(lastDatePicked)}',
                  style: textMd,
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
