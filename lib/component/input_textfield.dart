import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

final BorderRadius _borderRadius = BorderRadius.circular(100);

const BorderSide focusedBorder = BorderSide(
  width: 1,
  strokeAlign: BorderSide.strokeAlignOutside,
  color: Color(0xFF5100FF),
);

TextFormField customTextfield({
  TextEditingController? controller,
  required FocusNode focusNode,
  String? helperText,
  required String errorText,
}) {
  return TextFormField(
    focusNode: focusNode,
    autocorrect: false,
    cursorColor: primaryPurpleScale.shade700,
    cursorHeight: height20,
    cursorWidth: 1.5,
    controller: controller,
    style: textMd,
    decoration: InputDecoration(
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: focusedBorder.copyWith(color: errorRedScale.shade600)),
        enabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: _borderRadius, borderSide: focusedBorder),
        disabledBorder: InputBorder.none,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: focusedBorder.copyWith(color: errorRedScale.shade700)),
        fillColor: Colors.white.withOpacity(focusNode.hasFocus ? 0.05 : 0.1),
        filled: true,
        constraints: const BoxConstraints(),
        contentPadding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height08),
        hintStyle: textMd.copyWith(
          color: neutralGrayScale,
        ),
        helperMaxLines: 1,
        helperStyle: textXS.copyWith(color: neutralGrayScale),
        helperText: helperText,
        error: _errorWidget(errorText)),
  );
}

Widget _errorWidget(String errorText) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          color: errorRedScale.shade600,
          size: height08 * 2,
        ),
        SizedBox(
          width: width08 / 2,
        ),
        Text(
          errorText,
          style: textXS.copyWith(color: errorRedScale.shade600),
        )
      ],
    );

Column customInputTextfield({
  TextEditingController? controller,
  required FocusNode focusNode,
  String? helperText,
  String errorText = '',
  required String textLabel,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textLabel,
        style: textSm.copyWith(
            color: neutralGrayScale.shade300, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: height24 / 4,
      ),
      customTextfield(
        focusNode: focusNode,
        controller: controller,
        errorText: errorText,
        helperText: helperText,
      ),
    ],
  );
}
