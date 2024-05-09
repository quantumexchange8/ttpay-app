import 'package:flutter/material.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

AppBar twoSimpleAppbar({
  required String title,
  required void Function()? onPressedButton,
  required String buttonText,
  Widget? leftButtonIcon,
}) {
  return AppBar(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: textLg.copyWith(fontWeight: FontWeight.w700),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: width08 * 2),
        child: ctaButton(
            onPressed: onPressedButton,
            padding:
                EdgeInsets.symmetric(vertical: height08, horizontal: width10),
            bgColor: Colors.white.withOpacity(0.1),
            leftIcon: leftButtonIcon,
            textStyle: textXS.copyWith(fontWeight: FontWeight.w700),
            text: buttonText),
      )
    ],
  );
}
