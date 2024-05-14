import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/validator.dart';
import 'package:ttpay/pages/auth/login_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode comfirmPasswordFocusNode = FocusNode();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();

  String? oldPasswordErrorText;
  String? newPasswordErrorText;
  String? comfirmPasswordErrorText;

  bool oldPasswordObscureText = true;
  bool newPasswordObscureText = true;
  bool comfirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    void onFieldSubmittedOldPassword(String value) {
      FocusScope.of(context).requestFocus(newPasswordFocusNode);
    }

    void onFieldSubmittedNewPassword(String value) {
      FocusScope.of(context).requestFocus(comfirmPasswordFocusNode);
    }

    void onPressedComfirm() {
      setState(() {
        oldPasswordErrorText = comfirmPasswordValidator(
            comfirmPassword: oldPasswordController.text,
            newPasword: 'old password');
        newPasswordErrorText = newPasswordValidator(newPasswordController.text);
        comfirmPasswordErrorText = comfirmPasswordValidator(
            comfirmPassword: comfirmPasswordController.text,
            newPasword: newPasswordController.text);
      });
      if (newPasswordErrorText == null &&
          comfirmPasswordErrorText == null &&
          oldPasswordErrorText == null) {
        Navigator.pop(context);
      }
    }

    void onFieldSubmittedComfirmPassword(String value) {
      onPressedComfirm();
    }

    return unfocusGestureDetector(
      context,
      child: Scaffold(
        appBar: simpleAppBar(
            onTapBack: () {
              Navigator.pop(context);
            },
            title: 'Change Password'),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: backgroundContainer(
            child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: width08 * 2, vertical: height20),
                  children: [
                    SizedBox(
                      height: height24 / 2,
                    ),
                    customInputTextfield(
                        onFieldSubmitted: onFieldSubmittedOldPassword,
                        textLabel: 'Old Password',
                        hintText: 'Old Password',
                        focusNode: oldPasswordFocusNode,
                        controller: oldPasswordController,
                        showErrorWidget: oldPasswordErrorText != null,
                        errorText: oldPasswordErrorText ?? '',
                        suffixIcon: eyeObscureIcon(
                            onTap: () {
                              setState(() {
                                oldPasswordObscureText =
                                    !oldPasswordObscureText;
                              });
                            },
                            obscureText: oldPasswordObscureText),
                        obscureText: oldPasswordObscureText),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height31),
                      child: Divider(
                        height: 1,
                        color: neutralGrayScale.shade800,
                      ),
                    ),
                    customInputTextfield(
                        onFieldSubmitted: onFieldSubmittedNewPassword,
                        textLabel: 'New Password',
                        hintText: 'New Password',
                        focusNode: newPasswordFocusNode,
                        controller: newPasswordController,
                        showErrorWidget: newPasswordErrorText != null,
                        errorText: newPasswordErrorText ?? '',
                        suffixIcon: eyeObscureIcon(
                            onTap: () {
                              setState(() {
                                newPasswordObscureText =
                                    !newPasswordObscureText;
                              });
                            },
                            obscureText: newPasswordObscureText),
                        obscureText: newPasswordObscureText,
                        helperText:
                            'Must be at least 8 characters containing one uppercase letter, one lowercase letter, one number, and one special character.'),
                    SizedBox(
                      height: height20,
                    ),
                    customInputTextfield(
                      onFieldSubmitted: onFieldSubmittedComfirmPassword,
                      textLabel: 'Comfirm Password',
                      hintText: 'Comfirm New Password',
                      focusNode: comfirmPasswordFocusNode,
                      controller: comfirmPasswordController,
                      showErrorWidget: comfirmPasswordErrorText != null,
                      errorText: comfirmPasswordErrorText ?? '',
                      suffixIcon: eyeObscureIcon(
                          onTap: () {
                            setState(() {
                              comfirmPasswordObscureText =
                                  !comfirmPasswordObscureText;
                            });
                          },
                          obscureText: comfirmPasswordObscureText),
                      obscureText: comfirmPasswordObscureText,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width08 * 2, vertical: height08),
                  child: ctaButton(
                      onPressed: onPressedComfirm,
                      text: 'Comfirm',
                      isGradient: true),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
