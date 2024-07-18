import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Column titleColumn(
    {required String iconAddress,
    required String title,
    required String description}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width100 * 1.4,
        height: height10 * 3.6,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: const Alignment(0.71, -0.71),
          //   end: const Alignment(-0.71, 0.71),
          //   colors: [
          //     Colors.white.withOpacity(0.1),
          //     Colors.white.withOpacity(0.4)
          //   ],
          // ),
          image: DecorationImage(
              image: AssetImage(iconAddress), fit: BoxFit.cover),
          // borderRadius: BorderRadius.circular(12),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color(0x4C000000),
          //     blurRadius: 0.75,
          //     offset: Offset(0.38, 0.56),
          //     spreadRadius: 0.56,
          //   )
          // ],
        ),
      ),
      SizedBox(height: height24),
      Text(
        title,
        textAlign: TextAlign.center,
        style: textLg.copyWith(fontWeight: FontWeight.w600),
      ),
      SizedBox(height: height08),
      Text(
        description,
        textAlign: TextAlign.center,
        style: textSm.copyWith(
          color: neutralGrayScale,
        ),
      ),
    ],
  );
}
