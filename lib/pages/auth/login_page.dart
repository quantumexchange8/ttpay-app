import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/helper/validator.dart';
import 'package:ttpay/pages/app_layout.dart';
import 'package:ttpay/pages/auth/forgot_password_page.dart';
import 'package:ttpay/pages/auth/login_widgets/title_column.dart';
import 'package:ttpay/pages/auth/widgets.dart';

class LoginPage extends StatefulWidget {
  final Widget? topRightWidget;
  final void Function()? onLogin;
  const LoginPage({super.key, this.topRightWidget, this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idNumberController = TextEditingController();
  final FocusNode idNumberFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  String? idValidationErrorText;
  String? passwordValidationErrorText;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    void forgotPassword() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPasswordPage(),
          ));
    }

    void login() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AppLayout(),
          ));
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
                  child: widget.topRightWidget ?? languageIconButton(context),
                ),
              ),
              titleColumn(
                  iconAddress: 'assets/login_icon_image/ttpay-logo.png',
                  title: 'Merchant Portal',
                  description: 'Welcome back! Please enter your details.'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height31),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customInputTextfield(
                          showErrorWidget: idValidationErrorText != null,
                          focusNode: idNumberFocusNode,
                          textLabel: 'ID Number',
                          controller: idNumberController,
                          onChangedTextfield: (idNumber) {
                            setState(() {
                              idValidationErrorText = idValidator(idNumber);
                            });
                          },
                          errorText: idValidationErrorText ?? ''),
                      SizedBox(
                        height: height24 / 2,
                      ),
                      customInputTextfield(
                          showErrorWidget: passwordValidationErrorText != null,
                          focusNode: passwordFocusNode,
                          textLabel: 'Password',
                          controller: passwordController,
                          onChangedTextfield: (password) {
                            setState(() {
                              passwordValidationErrorText =
                                  passwordValidator(password);
                            });
                          },
                          errorText: passwordValidationErrorText ?? '',
                          suffixIcon: eyeObscureIcon(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              obscureText: _obscureText),
                          obscureText: _obscureText),
                    ],
                  ),
                ),
              ),
              ctaButton(
                  onPressed: widget.onLogin ?? login,
                  padding: EdgeInsets.symmetric(
                    horizontal: width20,
                    vertical: height08 * 2,
                  ),
                  haveShadow: true,
                  isGradient: true,
                  text: 'Log In'),
              SizedBox(
                height: height24 / 2,
              ),
              ctaButton(
                  onPressed: forgotPassword,
                  text: 'Forgot password',
                  textStyle: textSm.copyWith(
                      fontWeight: FontWeight.w600,
                      color: primaryPurpleScale.shade700))
            ],
          ),
        ),
      ),
    );
  }
}

Widget eyeObscureIcon({void Function()? onTap, required bool obscureText}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, height24 / 2, width20, height24 / 2),
    child: InkWell(
      onTap: onTap,
      child: obscureText
          ? Image.asset(
              'assets/login_icon_image/eye_closed.png',
              height: height08 * 2,
            )
          : Icon(Icons.visibility,
              color: neutralGrayScale.shade400, size: height20),
    ),
  );
}
