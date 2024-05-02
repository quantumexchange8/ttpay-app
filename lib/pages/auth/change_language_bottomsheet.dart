import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';

BottomSheet changeLanguageBottomsheet({
  required List<Map<String, dynamic>> languageList,
}) {
  return BottomSheet(
    onClosing: () {},
    enableDrag: false,
    backgroundColor: neutralGrayScale.shade900,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: textMd.copyWith(fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.close,
                  size: height20,
                  color: neutralGrayScale.shade400,
                ),
              ],
            ),
            SizedBox(
              height: height24,
            ),
            ...languageList.mapIndexed((i, e) {
              Locale locale = e['locale'];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Get.updateLocale(locale);
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: _languageRow(
                        languageName: e['language_name'],
                        isSelected:
                            Get.locale?.countryCode == locale.countryCode),
                  ),
                  if (!isLast(i, languageList))
                    Divider(color: neutralGrayScale.shade900),
                ],
              );
            })
          ],
        ),
      );
    },
  );
}

Widget _languageRow({
  required String languageName,
  required bool isSelected,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: height24 / 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          languageName,
          style: textSm.copyWith(fontWeight: FontWeight.w500),
        ),
        if (isSelected)
          Icon(
            Icons.check,
            size: 24,
            color: primaryPurpleScale.shade600,
          ),
      ],
    ),
  );
}
