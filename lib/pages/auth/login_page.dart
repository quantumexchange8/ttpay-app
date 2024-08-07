// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/helper/validator.dart';
import 'package:ttpay/pages/app_layout.dart';
import 'package:ttpay/pages/auth/forgot_password_page.dart';
import 'package:ttpay/pages/auth/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  final Widget? topRightWidget;
  final void Function(bool loginSuccess)? onLogin;
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

    Future<void> Function() login = widget.onLogin != null
        ? () async {
            final loginSuccess = await authController.login(context,
                setCurrentToken: false,
                userId: idNumberController.text,
                password: passwordController.text);
            widget.onLogin!(loginSuccess);
          }
        : () async {
            idValidationErrorText = idValidator(idNumberController.text);
            passwordValidationErrorText =
                passwordValidator(passwordController.text);

            if (idValidationErrorText == null &&
                passwordValidationErrorText == null) {
              await authController
                  .login(context,
                      userId: idNumberController.text,
                      password: passwordController.text)
                  .then((success) async {
                if (success) {
                  final getTransactionErrorText = await transactionController
                      .getAllTransaction(tokenController.currentToken);
                  if (getTransactionErrorText != null) {
                    print('transaction error');
                    showErrorNotification(
                      context,
                      errorText: getTransactionErrorText,
                    );
                    return;
                  }
                  // final getGroupsErrorText =
                  //     await groupController.getAllGroup();
                  // if (getGroupsErrorText != null) {
                  //   showErrorNotification(context,
                  //       errorText: getGroupsErrorText);
                  //   return;
                  // }
                  final getUserErrorText = await userController.getCurrentUser(
                      token: tokenController.currentToken);
                  if (getUserErrorText != null) {
                    print('user error');
                    showErrorNotification(context, errorText: getUserErrorText);
                    return;
                  }
                  final getAccountListErrorText =
                      await userController.getAllAccounts();
                  if (getAccountListErrorText != null) {
                    print('account list error');
                    showErrorNotification(context,
                        errorText: getAccountListErrorText);

                    return;
                  }
                  // final getNotificationsErrorText =
                  //     await notificationController.getAllNotifications();
                  // if (getNotificationsErrorText != null) {
                  //   showErrorNotification(context,
                  //       errorText: getNotificationsErrorText);
                  //   return;
                  // }
                  final getMerchantWallet = await userController
                      .getMerchantWallet(token: tokenController.currentToken);
                  if (getMerchantWallet != null) {
                    print('merchant error');
                    showErrorNotification(context,
                        errorText: getMerchantWallet);

                    return;
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppLayout(),
                      ));
                }
              });
            } else {
              setState(() {});
            }
          };

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
              _titleColumn(
                  iconAddress: 'assets/login_icon_image/ttpay-logo.png',
                  title: AppLocalizations.of(context)!.merchant_portal,
                  description: AppLocalizations.of(context)!.welcome_back),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height31),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customInputTextfield(
                          showErrorWidget: idValidationErrorText != null,
                          focusNode: idNumberFocusNode,
                          textLabel: AppLocalizations.of(context)!.id_number,
                          controller: idNumberController,
                          onFieldSubmitted: (idNumber) {
                            setState(() {
                              idValidationErrorText = idValidator(idNumber);
                            });
                            if (idValidationErrorText == null) {
                              passwordFocusNode.requestFocus();
                            }
                          },
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
                          textLabel: AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          onFieldSubmitted: (password) async {
                            await login();
                          },
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
                  onPressed: login,
                  padding: EdgeInsets.symmetric(
                    horizontal: width20,
                    vertical: height08 * 2,
                  ),
                  haveShadow: true,
                  isGradient: true,
                  text: AppLocalizations.of(context)!.log_in),
              SizedBox(
                height: height24 / 2,
              ),
              ctaButton(
                  onPressed: forgotPassword,
                  text: AppLocalizations.of(context)!.forgot_password,
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

Column _titleColumn(
    {required String iconAddress,
    required String title,
    required String description}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width100 * 1.4,
        height: height10 * 3.6,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(iconAddress), fit: BoxFit.cover),
        ),
      ),
      SizedBox(height: height24),
      Text(
        title,
        textAlign: TextAlign.center,
        style: textLg.copyWith(fontWeight: FontWeight.w600),
      ),
      SizedBox(height: height08),
      Text(
        description,
        textAlign: TextAlign.center,
        style: textSm.copyWith(
          color: neutralGrayScale,
        ),
      ),
    ],
  );
}
