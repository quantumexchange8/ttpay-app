import 'package:flutter/material.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/profile/widgets/profile_details_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Container logoutContainer(BuildContext context) => translucentProfileContainer(
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
            AppLocalizations.of(context)!.log_out,
            style: textSm.copyWith(
              color: errorRedScale.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ));
