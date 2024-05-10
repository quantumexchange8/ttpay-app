import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';

Container profileImageContainer(
    {required String? accountPhoto, required double size}) {
  bool havePhoto = accountPhoto != null && accountPhoto.isNotEmpty;
  return Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(height08 / 2),
    decoration: BoxDecoration(
      image: havePhoto
          ? DecorationImage(
              image: NetworkImage(accountPhoto),
              fit: BoxFit.contain,
            )
          : null,
      shape: BoxShape.circle,
    ),
    child:
        havePhoto ? null : Image.asset('assets/icon_image/no_profile_icon.png'),
  );
}
