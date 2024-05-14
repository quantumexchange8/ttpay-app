import 'package:flutter/material.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Row twoSimpleAppbar({
  required String title,
  required void Function()? onPressedButton,
  required String buttonText,
  Widget? leftButtonIcon,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: textLg.copyWith(fontWeight: FontWeight.w700),
      ),
      ctaButton(
          onPressed: onPressedButton,
          padding:
              EdgeInsets.symmetric(vertical: height08, horizontal: width10),
          bgColor: Colors.white.withOpacity(0.1),
          leftIcon: leftButtonIcon,
          textStyle: textXS.copyWith(fontWeight: FontWeight.w700),
          text: buttonText)
    ],
  );
}
