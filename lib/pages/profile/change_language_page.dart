import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  final storage = const FlutterSecureStorage();
  Locale? currentLocale = Get.locale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
          onTapBack: () async {
            await storage
                .write(key: 'langCode', value: currentLocale?.languageCode)
                .then((nothing) {
              Navigator.pop(context);
            });
          },
          title: AppLocalizations.of(context)!.language),
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
                setState(() {
                  currentLocale = locale;
                });
                Get.updateLocale(locale);
              },
              child: _languageRow(
                  language: e['language_name'],
                  isSelected: locale.languageCode == Get.locale?.languageCode),
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
