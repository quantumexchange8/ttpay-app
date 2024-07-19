import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';

Container profileImageContainer(
    {required dynamic accountPhoto, required double size}) {
  DecorationImage? decoImage;
  bool havePhoto = false;
  if (accountPhoto != null) {
    if (accountPhoto is String) {
      if (accountPhoto.isNotEmpty) {
        havePhoto = true;
        decoImage = DecorationImage(
          image: NetworkImage(accountPhoto),
          fit: BoxFit.cover,
        );
      }
    }
    if (accountPhoto is File) {
      havePhoto = true;
      decoImage = DecorationImage(
        image: FileImage(accountPhoto),
        fit: BoxFit.cover,
      );
    }
  }

  return Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(height08 / 2),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05000000074505806),
      image: decoImage,
      shape: BoxShape.circle,
    ),
    child:
        havePhoto ? null : Image.asset('assets/icon_image/no_profile_icon.png'),
  );
}
