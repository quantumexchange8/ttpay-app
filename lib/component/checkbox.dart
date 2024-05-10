import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';

Checkbox customCheckbox({
  required bool isCheck,
  bool isDisable = false,
  required void Function(bool?)? onChanged,
}) {
  return Checkbox(
    value: isCheck,
    checkColor: isDisable ? neutralGrayScale.shade300 : Colors.white,
    fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.disabled) &&
          states.contains(MaterialState.selected)) {
        return primaryPurpleScale.shade900;
      } else if (states.contains(MaterialState.selected)) {
        return primaryPurpleScale.shade700;
      } else {
        return Colors.white.withOpacity(0.1);
      }
    }),
    side: BorderSide.none,
    shape: const CircleBorder(),
    //  focusColor: ,
    //  hoverColor: ,
    onChanged: isDisable ? null : onChanged,
  );
}
