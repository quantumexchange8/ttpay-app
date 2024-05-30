import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';

Container translucentProfileContainer({Widget? child}) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width24 / 2, vertical: height08 * 2),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: child,
  );
}

Container profileDetailsContainer(Map<String, dynamic> details) {
  return translucentProfileContainer(
    child: Column(
      children: details.entries
          .mapIndexed((i, e) => Padding(
                padding: EdgeInsets.only(
                    bottom: isLast(i, details.entries.toList()) ? 0 : height08),
                child: _detailsRow(key: e.key, value: e.value),
              ))
          .toList(),
    ),
  );
}

Row _detailsRow({
  required String key,
  required String value,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          key,
          style: textXS.copyWith(
            color: neutralGrayScale,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          value,
          style: textSm,
        ),
      ),
    ],
  );
}
