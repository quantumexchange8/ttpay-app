import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';

Slidable pinnableList({void Function()? onPressedPin, required Widget child}) =>
    Slidable(
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          GestureDetector(
            onTap: onPressedPin,
            child: Container(
              width: width10 * 8,
              padding: EdgeInsets.symmetric(
                vertical: height08,
                horizontal: width10 * 2.8,
              ),
              decoration: BoxDecoration(color: neutralGrayScale.shade600),
              child: Column(
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
            ),
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: child,
    );
