import 'package:flutter/material.dart';

Container backgroundContainer(
    {EdgeInsetsGeometry? padding, required Widget child}) {
  return Container(
    padding: padding,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.cover)),
    child: child,
  );
}
