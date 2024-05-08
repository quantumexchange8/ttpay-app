import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';

Row _overviewRow({
  required String key,
  required String value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        key,
        style: textXS.copyWith(
          color: neutralGrayScale,
        ),
      ),
      Text(
        value,
        textAlign: TextAlign.right,
        style: textSm,
      ),
    ],
  );
}

Container overviewContainer({
  required Map<String, dynamic> overviewData,
}) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width24 / 2, vertical: height08 * 2),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: textMd.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: height08),
        ...overviewData.entries.mapIndexed((i, e) => Padding(
              padding: EdgeInsets.only(
                  bottom: isLast(i, overviewData.entries.toList())
                      ? 0
                      : height08 / 2),
              child: _overviewRow(key: e.key, value: e.value),
            )),
      ],
    ),
  );
}
