import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:slideable/slideable.dart';

Slideable pinnableList(
        {required void Function() onPressedPin, required Widget child}) =>
    Slideable(
      items: [
        ActionItems(
          backgroudColor: neutralGrayScale.shade600,
          onPress: onPressedPin,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon_image/Icon=pin.png',
                height: height24,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: height08 / 2),
              Text('Pin', textAlign: TextAlign.center, style: textXS),
            ],
          ),
        )
      ],

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: child,
    );
