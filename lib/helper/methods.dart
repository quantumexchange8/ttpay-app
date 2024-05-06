import 'package:flutter/material.dart';

bool isLast(int currentIndex, List setOfList) {
  return currentIndex == (setOfList.length - 1);
}

Color convertColorCode(String colorCode) {
  String formattedCode = colorCode.replaceAll("#", "");

  return Color(int.parse('0xFF$formattedCode'));
}
