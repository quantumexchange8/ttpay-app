import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Widget smallButton({
  required void Function()? onPressed,
  required String text,
  Color bgColor = Colors.transparent,
  bool isGradient = false,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: isGradient
          ? LinearGradient(
              begin: const Alignment(-0.71, -0.71),
              end: const Alignment(0.71, 0.71),
              colors: [
                primaryPurpleScale.shade400,
                primaryPurpleScale.shade600,
                const Color(0xFF210077)
              ],
            )
          : null,
    ),
    child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
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
          shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100))),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textSm.copyWith(
            fontWeight: FontWeight.w600,
          ),
        )),
  );
}
