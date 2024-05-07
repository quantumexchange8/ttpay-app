import 'package:flutter/material.dart';

bool isLast(int currentIndex, List setOfList) {
  return currentIndex == (setOfList.length - 1);
}

Color convertColorCode(String colorCode) {
  String formattedCode = colorCode.replaceAll("#", "");

  return Color(int.parse('0xFF$formattedCode'));
}

int determinelastMonthYear() {
  if (DateTime.now().month == 1) {
    return DateTime.now().year - 1;
  } else {
    return DateTime.now().year;
  }
}

int determinelastMonth() {
  if (DateTime.now().month == 1) {
    return 12;
  } else {
    return DateTime.now().month - 1;
  }
}

bool isThirtyDaysMonth(int month) {
  // Check if the month is April, June, September, or November
  if (month == DateTime.april ||
      month == DateTime.june ||
      month == DateTime.september ||
      month == DateTime.november) {
    return true; // 30 days month
  } else {
    return false; // 31 days month
  }
}

int determinelastMonthLastDay() {
  if (isThirtyDaysMonth(determinelastMonth())) {
    return 30;
  } else {
    return 31;
  }
}
