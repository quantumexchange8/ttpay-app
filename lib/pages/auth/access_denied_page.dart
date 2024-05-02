import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/auth/widgets.dart';

class AccessDeniedPage extends StatelessWidget {
  const AccessDeniedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(horizontal: width08 * 2),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              languageIconButton(context),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height20 * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/access-denied.png',
                      width: width100 * 3.2,
                      fit: BoxFit.fitWidth,
                    ),
                    Text(
                      'Access Denied',
                      textAlign: TextAlign.center,
                      style: textMd.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height08),
                    Text(
                      'Uh-oh! It seems there\'s an issue with accessing the mobile app. Please make sure your bill is settled or contact your software provider to regain access. Let\'s get that sorted out together! 🛠️',
                      textAlign: TextAlign.center,
                      style: textSm.copyWith(
                        color: neutralGrayScale,
                      ),
                    )
                  ],
                ),
              ),
              backToLoginPageButton(context)
            ],
          )),
    );
  }
}
