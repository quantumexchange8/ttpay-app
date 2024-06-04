import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget searchBar(
  BuildContext context, {
  required TextEditingController controller,
  void Function(String)? onChanged,
  void Function()? onTapClear,
}) {
  return SearchBar(
    textInputAction: TextInputAction.search,
    onSubmitted: onChanged,
    leading: Padding(
      padding: EdgeInsets.symmetric(
        vertical: height10,
      ),
      child: Image.asset('assets/icon_image/grey_search_icon.png'),
    ),
    backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1)),
    constraints: BoxConstraints(
      minWidth: width100 * 3,
      maxHeight: height10 * 4,
    ),
    controller: controller,
    hintText: AppLocalizations.of(context)!.search,
    hintStyle: MaterialStatePropertyAll(
      textMd.copyWith(
        color: neutralGrayScale,
      ),
    ),
    onChanged: onChanged,
    shape: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.focused) ||
          states.contains(MaterialState.pressed)) {
        return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
                color: primaryPurpleScale.shade700,
                strokeAlign: BorderSide.strokeAlignOutside));
      } else {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(50));
      }
    }),
    surfaceTintColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1)),
    textStyle: MaterialStatePropertyAll(textMd),
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
      horizontal: width08 * 2,
    )),
    trailing: [
      if (controller.text.isNotEmpty)
        GestureDetector(
          onTap: onTapClear,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height10),
            child: Image.asset('assets/icon_image/clear_icon.png'),
          ),
        )
    ],
  );
}
