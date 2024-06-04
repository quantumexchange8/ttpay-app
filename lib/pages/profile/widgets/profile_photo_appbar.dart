import 'package:flutter/material.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar profilePhotoAppbar(BuildContext context) => AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.close,
          size: height20,
          color: Colors.white,
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.profile_photo,
        style: textLg.copyWith(fontWeight: FontWeight.w700),
      ),
      centerTitle: false,
    );
