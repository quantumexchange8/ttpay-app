import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

final InputBorder normalBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100),
);

const BorderSide focusedBorder = BorderSide(
  width: 1,
  strokeAlign: BorderSide.strokeAlignOutside,
  color: Color(0xFF5100FF),
);

TextFormField customTextfield(
    {bool autofocus = false,
    required bool showErrorWidget,
    TextEditingController? controller,
    required FocusNode focusNode,
    String? helperText,
    required String errorText,
    Widget? suffixIcon,
    bool obscureText = false,
    void Function(String)? onChanged,
    String? hintText}) {
  return TextFormField(
    autofocus: autofocus,
    focusNode: focusNode,
    onChanged: onChanged,
    autocorrect: false,
    cursorColor: primaryPurpleScale.shade700,
    cursorHeight: height20,
    cursorWidth: 1.5,
    controller: controller,
    style: textMd,
    obscureText: obscureText,
    decoration: InputDecoration(
        border: normalBorder,
        errorBorder: normalBorder.copyWith(
            borderSide: focusedBorder.copyWith(color: errorRedScale.shade600)),
        enabledBorder: normalBorder,
        focusedBorder: normalBorder.copyWith(borderSide: focusedBorder),
        disabledBorder: normalBorder,
        focusedErrorBorder: normalBorder.copyWith(
            borderSide: focusedBorder.copyWith(color: errorRedScale.shade700)),
        fillColor: Colors.white.withOpacity(focusNode.hasFocus ? 0.05 : 0.1),
        filled: true,
        constraints: const BoxConstraints(),
        contentPadding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height08),
        hintText: hintText,
        hintStyle: textMd.copyWith(
          color: neutralGrayScale,
        ),
        helperMaxLines: 3,
        helperStyle: textXS.copyWith(color: neutralGrayScale),
        helperText: helperText,
        error: showErrorWidget ? _errorWidget(errorText) : null,
        suffixIcon: suffixIcon),
  );
}

Widget _errorWidget(String errorText) => Row(
      children: [
        Icon(
          Icons.error_outline,
          color: errorRedScale.shade600,
          size: height08 * 2,
        ),
        SizedBox(
          width: width08 / 2,
        ),
        Expanded(
          child: Text(
            errorText,
            style: textXS.copyWith(color: errorRedScale.shade600),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );

Column customInputTextfield({
  bool isRequired = false,
  TextEditingController? controller,
  required FocusNode focusNode,
  String? helperText,
  String errorText = '',
  required String textLabel,
  Widget? suffixIcon,
  required bool showErrorWidget,
  void Function(String)? onChangedTextfield,
  bool obscureText = false,
  String? hintText,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$textLabel ',
              style: textSm.copyWith(
                  color: neutralGrayScale.shade300,
                  fontWeight: FontWeight.w500),
            ),
            if (isRequired)
              TextSpan(
                text: '*',
                style: textSm.copyWith(
                  color: errorRedScale.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
      SizedBox(
        height: height24 / 4,
      ),
      customTextfield(
          focusNode: focusNode,
          controller: controller,
          errorText: errorText,
          helperText: helperText,
          suffixIcon: suffixIcon,
          showErrorWidget: showErrorWidget,
          onChanged: onChangedTextfield,
          obscureText: obscureText,
          hintText: hintText),
    ],
  );
}
