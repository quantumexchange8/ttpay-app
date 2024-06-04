import 'package:flutter/material.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/pages/auth/change_language_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget languageIconButton(BuildContext context) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        enableDrag: true,
        builder: (context) => changeLanguageBottomsheet(
          languageList: languageList,
        ),
      );
    },
    borderRadius: BorderRadius.circular(20),
    splashColor: primaryPurpleScale.shade200,
    child: Image.asset(
      'assets/login_icon_image/globe.png',
      fit: BoxFit.fitHeight,
      height: height24,
    ),
  );
}

Widget backToLoginPageButton(BuildContext context) {
  return ctaButton(
      onPressed: () {
        Navigator.pop(context);
      },
      leftIcon: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: height20,
      ),
      text: AppLocalizations.of(context)!.back_to_log_in);
}
