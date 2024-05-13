import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/profile/widgets/profile_details_container.dart';

Container logoutContainer = translucentProfileContainer(
    child: Row(
  children: [
    Icon(
      Icons.logout,
      size: height20,
      color: errorRedScale.shade600,
    ),
    SizedBox(width: width08),
    Expanded(
      child: Text(
        'Log Out',
        style: textSm.copyWith(
          color: errorRedScale.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ],
));
