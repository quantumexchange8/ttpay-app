import 'package:flutter/material.dart';
import 'package:ttpay/helper/const.dart';

Container backgroundContainer(
    {EdgeInsetsGeometry? padding, required Widget child}) {
  return Container(
    padding: padding,
    decoration: const BoxDecoration(
        color: backgroundColor,
        image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.cover)),
    child: child,
  );
}
