import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/pages/auth/check_email_page.dart';
import 'package:ttpay/pages/auth/login_widgets/title_column.dart';
import 'package:ttpay/pages/auth/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  String? sendEmailErrorText;

  @override
  Widget build(BuildContext context) {
    void sendEmail() {
      setState(() {
        if (_emailController.text.isEmpty) {
          sendEmailErrorText = 'Email is empty';
        } else if (!RegExp(emailPattern).hasMatch(_emailController.text)) {
          sendEmailErrorText = 'Invalid email address';
        } else {
          sendEmailErrorText = null;
        }
      });
      if (sendEmailErrorText == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CheckEmailPage(emailAddressSent: _emailController.text),
            ));
      }
    }

    return unfocusGestureDetector(
      context,
      child: Scaffold(
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
                    iconAddress: 'assets/login_icon_image/Lock.png',
                    title: 'Forgot password?',
                    description:
                        'No worries, we\'ll send you reset instructions.'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height31),
                  child: customInputTextfield(
                      focusNode: _focusNode,
                      textLabel: 'Email',
                      hintText: 'Enter registered email',
                      controller: _emailController,
                      showErrorWidget: sendEmailErrorText != null,
                      errorText: sendEmailErrorText ?? ''),
                ),
                ctaButton(
                    onPressed: sendEmail, isGradient: true, text: 'Send Email'),
                SizedBox(
                  height: height24 / 2,
                ),
                backToLoginPageButton(context)
              ],
            )),
      ),
    );
  }
}
