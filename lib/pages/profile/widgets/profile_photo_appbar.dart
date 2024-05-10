import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

AppBar profilePhotoAppbar = AppBar(
  leading: Icon(
    Icons.close,
    size: height20,
    color: Colors.white,
  ),
  title: Text(
    'Profile Photo',
    style: textLg.copyWith(fontWeight: FontWeight.w700),
  ),
  centerTitle: false,
);
