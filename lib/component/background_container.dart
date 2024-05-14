import 'package:flutter/material.dart';
import 'package:ttpay/helper/const.dart';

Container backgroundContainer(
    {EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BoxFit fit = BoxFit.cover,
    BoxBorder? border,
    required Widget child}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
        image: DecorationImage(
            image: const AssetImage('assets/images/Background.png'), fit: fit)),
    child: child,
  );
}
