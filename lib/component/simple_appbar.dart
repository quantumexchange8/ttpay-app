import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

AppBar simpleAppBar({void Function()? onTapBack, String? title}) => AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: InkWell(
        onTap: onTapBack,
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: height24,
        ),
      ),
      centerTitle: false,
      title: title == null
          ? null
          : Text(
              title,
              style: textLg.copyWith(fontWeight: FontWeight.w700),
            ),
    );
