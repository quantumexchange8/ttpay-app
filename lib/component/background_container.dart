import 'package:flutter/material.dart';
import 'package:ttpay/helper/const.dart';

Container backgroundContainer(
    {EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    required Widget child}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        image: const DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.cover)),
    child: child,
  );
}
