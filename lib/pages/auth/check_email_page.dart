import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/auth/login_widgets/title_column.dart';
import 'package:ttpay/pages/auth/widgets.dart';

class CheckEmailPage extends StatelessWidget {
  final String emailAddressSent;
  const CheckEmailPage({super.key, required this.emailAddressSent});

  @override
  Widget build(BuildContext context) {
    void openEmailApp() async {
      try {
        await OpenMailApp.openMailApp().then((result) {
          if (!result.didOpen && !result.canOpen) {
            showToastNotification(context,
                type: 'error', title: 'No mail apps installed');

            // iOS: if multiple mail apps found, show dialog to select.
            // There is no native intent/default app system in iOS so
            // you have to do it yourself.
          } else if (!result.didOpen && result.canOpen) {
            showDialog(
              context: context,
              builder: (_) {
                return MailAppPickerDialog(
                  mailApps: result.options,
                );
              },
            );
          }
        });
      } on Exception catch (e) {
        // ignore: use_build_context_synchronously
        showToastNotification(context,
            persist: true,
            type: 'error',
            title: 'Error',
            description: e.toString());
      }

      // If no mail apps found, show error
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(horizontal: width08 * 2),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: languageIconButton(context),
                ),
              ),
              titleColumn(
                  iconAddress: 'assets/login_icon_image/Messages.png',
                  title: 'Check your email',
                  description:
                      'We\'ve sent a password reset link to $emailAddressSent'),
              SizedBox(
                height: height31,
              ),
              ctaButton(
                  onPressed: openEmailApp,
                  isGradient: true,
                  text: 'Open email app'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Didn’t receive the email?',
                      textAlign: TextAlign.center,
                      style: textSm.copyWith(color: neutralGrayScale),
                    ),
                    SizedBox(height: height08 / 2),
                    GestureDetector(
                      onTap: () {
                        showToastNotification(context,
                            type: 'success', title: "Email Sent Successfully!");
                      },
                      child: Text(
                        'Click to resend',
                        textAlign: TextAlign.center,
                        style: textSm.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primaryPurpleScale.shade700),
                      ),
                    ),
                  ],
                ),
              ),
              backToLoginPageButton(context)
            ],
          )),
    );
  }
}
