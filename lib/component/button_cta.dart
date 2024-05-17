import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Widget ctaButton({
  required void Function()? onPressed,
  required String text,
  TextStyle? textStyle,
  Color bgColor = Colors.transparent,
  bool isGradient = false,
  Widget? leftIcon,
  EdgeInsetsGeometry? padding,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      gradient: isGradient
          ? LinearGradient(
              begin: const Alignment(2, -1),
              end: const Alignment(-2, 1),
              colors: [
                primaryPurpleScale.shade400,
                primaryPurpleScale.shade600,
                const Color(0xFF210077),
              ],
            )
          : null,
    ),
    child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(padding ??
              EdgeInsets.symmetric(
                  horizontal: width20, vertical: height24 / 2)),
          alignment: Alignment.center,
          backgroundColor: MaterialStateColor.resolveWith((states) => bgColor),
          overlayColor: MaterialStateColor.resolveWith(
              (states) => primaryPurpleScale.shade300.withOpacity(0.5)),
          minimumSize: MaterialStateProperty.all(const Size(10, 2)),
          maximumSize:
              const MaterialStatePropertyAll(Size(double.infinity, 60)),
          foregroundColor: MaterialStateColor.resolveWith((states) => bgColor),
          surfaceTintColor: MaterialStateColor.resolveWith((states) => bgColor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) leftIcon,
            Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle ??
                  textSm.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        )),
  );
}
