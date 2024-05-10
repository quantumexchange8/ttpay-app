import 'package:flutter/material.dart';
import 'package:ttpay/component/profile_image_container.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Row profilePhotoRow({
  required String? profilePhotoAddress,
  required String profileName,
  required String profileId,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      profileImageContainer(
          accountPhoto: profilePhotoAddress, size: height10 * 4.8),
      SizedBox(width: width24 / 2),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profileName,
            style: textLg.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'ID: $profileId',
            style: textSm,
          ),
        ],
      ),
    ],
  );
}
