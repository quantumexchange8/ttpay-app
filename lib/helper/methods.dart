import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttpay/component/top_snackbar.dart';

bool isLast(int currentIndex, List setOfList) {
  return currentIndex == (setOfList.length - 1);
}

Color convertColorCode(String colorCode) {
  String formattedCode = colorCode.replaceAll("#", "");

  return Color(int.parse('0xFF$formattedCode'));
}

String colorToHex(Color color) {
  return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
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

int determineTotalDaysOfMonth(int month) {
  if (isThirtyDaysMonth(month)) {
    return 30;
  } else {
    return 31;
  }
}

int determinelastMonthLastDay() {
  return determineTotalDaysOfMonth(determinelastMonth());
}

Future<T?> customShowModalBottomSheet<T>(
    {required BuildContext context,
    required Widget Function(BuildContext context) builder}) async {
  return await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24))),
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.black,
    builder: builder,
  );
}

Future<void> copyToClipboard(BuildContext context, String text) async {
  try {
    await Clipboard.setData(ClipboardData(text: text)).then((value) {
      showToastNotification(context, title: 'Text Copied To Clipboard');
    });
  } on Exception catch (e) {
    // ignore: use_build_context_synchronously
    showToastNotification(context,
        type: 'error', title: 'Error', description: e.toString());
  }
}

void showErrorNotification(BuildContext context, {required String errorText}) {
  if (errorText.length > 20) {
    showToastNotification(context,
        title: 'Error', description: errorText, type: 'error');
  } else {
    showToastNotification(context, title: errorText, type: 'error');
  }
}
