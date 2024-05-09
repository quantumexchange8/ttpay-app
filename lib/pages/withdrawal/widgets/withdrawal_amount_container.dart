import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Container withdrawalAmountContainer(
    {required TextEditingController controller,
    num? maxValue,
    void Function(String amount)? onChangedAmount}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: height08 * 2),
    decoration: ShapeDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Enter Withdrawal Amount ',
                style: textSm.copyWith(
                  color: neutralGrayScale.shade300,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '*',
                style: textSm.copyWith(
                  color: errorRedScale.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: height24 / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right:
                                (width10 * 1.8) * (controller.text.length + 1)),
                        child: Text(
                          '\$',
                          textAlign: TextAlign.end,
                          style: textMd.copyWith(
                            color: neutralGrayScale.shade300,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      style: textXXL.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      controller: controller,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        CurrencyTextInputFormatter.currency(
                          symbol: '',
                          maxValue: maxValue,
                        )
                      ],
                      onChanged: onChangedAmount,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          constraints: const BoxConstraints(),
                          contentPadding: EdgeInsets.only(top: height08 / 4)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'Min withdrawal amount: \$ 100 USDT',
          textAlign: TextAlign.center,
          style: textXS.copyWith(
            color: neutralGrayScale,
          ),
        ),
      ],
    ),
  );
}
