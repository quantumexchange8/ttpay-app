import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

class EnterAccountPasswordPage extends StatefulWidget {
  const EnterAccountPasswordPage({super.key});

  @override
  State<EnterAccountPasswordPage> createState() =>
      _EnterAccountPasswordPageState();
}

class _EnterAccountPasswordPageState extends State<EnterAccountPasswordPage> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    void onPressedComfirm() {}

    return Scaffold(
      body: backgroundContainer(
          padding: EdgeInsets.symmetric(horizontal: width08 * 2),
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
                'Enter Account Password',
                textAlign: TextAlign.center,
                style: textLg.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height08),
              Text(
                'Please enter password associated with this account to authorise this transaction.',
                textAlign: TextAlign.center,
                style: textSm.copyWith(
                  color: neutralGrayScale.shade300,
                ),
              ),
              SizedBox(height: height20),
              customTextfield(
                  showErrorWidget: errorText != null,
                  focusNode: _focusNode,
                  errorText: errorText ?? ''),
              SizedBox(height: height31),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: width10 * 9.5,
                  child: ctaButton(
                      onPressed: onPressedComfirm,
                      bgColor: primaryPurpleScale.shade700,
                      padding: EdgeInsets.symmetric(
                          horizontal: width20, vertical: height24 / 2),
                      text: 'Comfirm'),
                ),
              ),
            ],
          )),
    );
  }
}
