import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';

Switch toggle({
  required bool value,
  required void Function(bool)? onChanged,
}) =>
    Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: const MaterialStatePropertyAll(Colors.white),
      trackColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryPurpleScale.shade700;
        } else {
          return Colors.white.withOpacity(0.1);
        }
      }),
      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
    );
