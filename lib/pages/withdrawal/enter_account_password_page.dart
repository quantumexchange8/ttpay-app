import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/withdrawal/withdrawal_request_sent_successful_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterAccountPasswordPage extends StatefulWidget {
  const EnterAccountPasswordPage({super.key});

  @override
  State<EnterAccountPasswordPage> createState() =>
      _EnterAccountPasswordPageState();
}

class _EnterAccountPasswordPageState extends State<EnterAccountPasswordPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    void onPressedComfirm() {
      if (_passwordController.text.isEmpty) {
        showToastNotification(context,
            type: 'error',
            title: AppLocalizations.of(context)!.incorrect_password);
        return;
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WithdrawalRequestSentSuccessfulPage(),
          ));
    }

    return unfocusGestureDetector(
      context,
      child: Scaffold(
        body: backgroundContainer(
            padding: EdgeInsets.symmetric(horizontal: width08 * 2),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height08 / 2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: height10 * 2.8,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height31),
                  Text(
                    AppLocalizations.of(context)!.enter_account_password,
                    textAlign: TextAlign.center,
                    style: textLg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height08),
                  Text(
                    AppLocalizations.of(context)!
                        .enter_account_password_description,
                    textAlign: TextAlign.center,
                    style: textSm.copyWith(
                      color: neutralGrayScale.shade300,
                    ),
                  ),
                  SizedBox(height: height20),
                  customTextfield(
                      controller: _passwordController,
                      obscureText: true,
                      autofocus: true,
                      showErrorWidget: errorText != null,
                      focusNode: _focusNode,
                      errorText: errorText ?? ''),
                  SizedBox(height: height31),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: width100,
                      child: ctaButton(
                          onPressed: onPressedComfirm,
                          bgColor: primaryPurpleScale.shade700,
                          padding: EdgeInsets.symmetric(
                              horizontal: width20, vertical: height24 / 2),
                          text: AppLocalizations.of(context)!.comfirm),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
