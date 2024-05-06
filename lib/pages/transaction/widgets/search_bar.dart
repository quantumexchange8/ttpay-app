import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Widget searchBar(
    {required TextEditingController controller,
    void Function(String)? onChanged}) {
  return SearchBar(
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/icon_image/grey_search_icon.png'),
    ),
    backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1)),
    constraints: BoxConstraints(
      minWidth: width100 * 3,
      minHeight: height10 * 4,
    ),
    controller: controller,
    hintText: 'Search',
    hintStyle: MaterialStatePropertyAll(
      textMd.copyWith(color: neutralGrayScale),
    ),
    onChanged: onChanged,
    shape: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.focused) ||
          states.contains(MaterialState.pressed)) {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(50));
      } else {
        return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
                color: primaryPurpleScale.shade700,
                strokeAlign: BorderSide.strokeAlignOutside));
      }
    }),
    surfaceTintColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1)),
    textStyle: MaterialStatePropertyAll(textMd),
    padding: MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height08)),
    trailing: [
      if (controller.text.isNotEmpty)
        GestureDetector(
          onTap: () {
            controller.clear();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icon_image/clear_icon.png'),
          ),
        )
    ],
  );
}
