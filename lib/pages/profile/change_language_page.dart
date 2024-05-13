import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          onTapBack: () {
            Navigator.pop(context);
          },
          title: 'Language'),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          child: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height20),
          children: languageList.map((e) {
            Locale locale = e['locale'];
            return InkWell(
              onTap: () {
                Get.updateLocale(locale);
              },
              child: _languageRow(
                  language: e['language_name'],
                  isSelected: locale.countryCode == Get.locale?.countryCode),
            );
          }).toList(),
        ),
      )),
    );
  }
}

Widget _languageRow({required String language, required bool isSelected}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: height24 / 2),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.50, color: neutralGrayScale.shade800),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: textSm.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        if (isSelected)
          Icon(
            Icons.check,
            color: primaryPurpleScale.shade600,
            size: height24,
          ),
      ],
    ),
  );
}
