import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/component/input_textfield.dart';
import 'package:ttpay/component/unfocus_gesturedetector.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/group.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';

class NewGroupBottomsheet extends StatefulWidget {
  const NewGroupBottomsheet({super.key});

  @override
  State<NewGroupBottomsheet> createState() => _NewGroupBottomsheetState();
}

const List<Color> colorList = [
  Color(0xFF3BA755),
  Color(0xFF06A59A),
  Color(0xFF107CAD),
  Color(0xFF1B96FF),
  Color(0xFF5867E8),
  Color(0xFF9050E9),
  Color(0xFFCB65FF),
  Color(0xFFFF538A),
  Color(0xFFFF5D2D),
  Color(0xFF939393),
];

class _NewGroupBottomsheetState extends State<NewGroupBottomsheet> {
  final FocusNode _groupNameFocusNode = FocusNode();
  final TextEditingController _groupNameController = TextEditingController();
  Color? selectedColor;
  String? groupNameErrorText;
  bool showRedBorderColor = false;

  @override
  Widget build(BuildContext context) {
    String? groupNameValidator(String? name) {
      if (name == null || name.isEmpty) {
        return 'Group Name is empty';
      } else {
        return null;
      }
    }

    return unfocusGestureDetector(
      context,
      child: backgroundContainer(
        padding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height24),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            topBottomsheet(context, 'New Group'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height24),
              child: customInputTextfield(
                focusNode: _groupNameFocusNode,
                textLabel: 'Group Name',
                controller: _groupNameController,
                showErrorWidget: groupNameErrorText != null,
                errorText: groupNameErrorText ?? '',
              ),
            ),
            selectGroupColorColumn(
                onTapColor: (color) {
                  setState(() {
                    selectedColor = color;
                    showRedBorderColor = false;
                  });
                },
                showRedColorBorder: showRedBorderColor,
                colorList: colorList,
                selectedColor: selectedColor),
            SizedBox(height: height24),
            ctaButton(
                onPressed: () {
                  if (_groupNameController.text.isNotEmpty) {
                    if (selectedColor != null) {
                      Navigator.pop(
                          context,
                          Group(
                              id: Random().nextInt(100000),
                              name: _groupNameController.text,
                              colorCode: colorToHex(selectedColor!),
                              totalDepositNumber: 0,
                              totalGrossDepositAmount: 0,
                              totalNetDepositAmount: 0,
                              totalWithdrawalNumber: 0,
                              totalGrossWithdrawalAmount: 0,
                              totalNetWithdrawalAmount: 0,
                              transactionList: []));
                    } else {
                      setState(() {
                        groupNameErrorText =
                            groupNameValidator(_groupNameController.text);
                        showRedBorderColor = true;
                      });
                    }
                  } else {
                    setState(() {
                      groupNameErrorText =
                          groupNameValidator(_groupNameController.text);
                    });
                  }
                },
                bgColor: primaryPurpleScale.shade700,
                text: 'Add')
          ],
        ),
      ),
    );
  }
}

Container groupColorContainer(
    {required Color color,
    required bool isPicked,
    required bool showRedColorBorder}) {
  return Container(
    width: height20 * 2,
    height: height20 * 2,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isPicked
            ? Border.all(color: primaryPurpleScale.shade700, width: 3)
            : showRedColorBorder
                ? Border.all(color: errorRedScale.shade600, width: 3)
                : null),
  );
}

Column selectGroupColorColumn(
    {required void Function(Color color) onTapColor,
    required List<Color> colorList,
    required Color? selectedColor,
    required bool showRedColorBorder}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Select Group Colour',
        style: textSm.copyWith(
          color: neutralGrayScale.shade300,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height: height24 / 4,
      ),
      GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: width08 * 2,
            mainAxisSpacing: height24 / 2),
        children: colorList
            .map((e) => GestureDetector(
                onTap: () {
                  onTapColor(e);
                },
                child: groupColorContainer(
                    showRedColorBorder: showRedColorBorder,
                    color: e,
                    isPicked: e == selectedColor)))
            .toList(),
      )
    ],
  );
}
