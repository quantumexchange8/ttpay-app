import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/transaction/widgets/date_picker.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';

Row statusRow(String status,
    {bool isCheck = false, required void Function(bool?)? onChanged}) {
  return Row(
    children: [
      Transform.scale(
        scale: 1.5,
        child: SizedBox(
          width: height24,
          height: height24,
          child: Checkbox(
            value: isCheck,
            checkColor: Colors.white,
            fillColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return primaryPurpleScale.shade700;
              } else {
                return Colors.white.withOpacity(0.1);
              }
            }),
            side: BorderSide.none,
            shape: CircleBorder(),
            //  focusColor: ,
            //  hoverColor: ,
            onChanged: onChanged,
          ),
        ),
      ),
      SizedBox(width: width24 / 2),
      Text(
        status,
        style: textMd,
      ),
    ],
  );
}

Column amountRangeSlider(
    {required double startAmount,
    required double endAmount,
    required double maxAmount,
    required double minAmount,
    dynamic Function(int handlerIndex, dynamic lowerValue, dynamic upperValue)?
        onDragging}) {
  FlutterSliderHandler handler = FlutterSliderHandler(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: primaryPurpleScale.shade700)),
      child: Container(
        height: height08,
        width: height08,
        decoration: BoxDecoration(
          color: primaryPurpleScale.shade700,
          shape: BoxShape.circle,
        ),
      ));

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Amount Range',
        style: textSm.copyWith(
          color: neutralGrayScale.shade300,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        '\$ ${amountFormatterWithoutDecimal.format(startAmount)} - \$ ${amountFormatterWithoutDecimal.format(endAmount)}',
        style: textMd,
      ),
      FlutterSlider(
        tooltip: FlutterSliderTooltip(disabled: true),
        maximumDistance: double.infinity,
        handler: handler,
        handlerHeight: height24,
        handlerWidth: height24,
        rightHandler: handler,
        trackBar: FlutterSliderTrackBar(
          activeTrackBarHeight: height08 / 2,
          inactiveTrackBarHeight: height08 / 2,
          inactiveTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.05),
          ),
          activeTrackBar: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: primaryPurpleScale.shade700),
        ),
        values: [startAmount, endAmount],
        rangeSlider: true,
        max: maxAmount,
        min: minAmount,
        onDragging: onDragging,
      )
    ],
  );
}

class FilterBottomsheet extends StatefulWidget {
  final double maxAmount;
  final double minAmount;
  final double startAmount;
  final double endAmount;
  final List<String> selectedStatus;
  const FilterBottomsheet(
      {super.key,
      required this.maxAmount,
      required this.minAmount,
      required this.selectedStatus,
      required this.startAmount,
      required this.endAmount});

  @override
  State<FilterBottomsheet> createState() => _FilterBottomsheetState();
}

const statusList = [
  'Success',
  'Rejected',
  'Pending',
  'Freezing',
];

class _FilterBottomsheetState extends State<FilterBottomsheet> {
  late List<String> selectedStatus = widget.selectedStatus;
  late double startAmount = widget.startAmount;
  late double endAmount = widget.endAmount;

  @override
  Widget build(BuildContext context) {
    double maxAmount = widget.maxAmount;
    double minAmount = widget.minAmount;

    void onTapStatus(String status) {
      setState(() {
        if (selectedStatus.contains(status)) {
          selectedStatus.remove(status);
        } else {
          selectedStatus.add(status);
        }
      });
    }

    return backgroundContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      padding:
          EdgeInsets.symmetric(vertical: height24, horizontal: width08 * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBottomsheet(context, 'Filters'),
          SizedBox(
            height: height24,
          ),
          Text(
            'Status',
            style: textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: height20,
          ),
          ...statusList.mapIndexed((i, e) => Padding(
                padding: EdgeInsets.only(
                    bottom: isLast(i, statusList) ? 0 : height08 * 2),
                child: GestureDetector(
                    onTap: () {
                      onTapStatus(e.toLowerCase());
                    },
                    child: statusRow(
                      e,
                      isCheck: selectedStatus.contains(e.toLowerCase()),
                      onChanged: (value) {
                        onTapStatus(e.toLowerCase());
                      },
                    )),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height20),
            child: Divider(
              height: 1,
              color: neutralGrayScale.shade800,
              thickness: 0.5,
            ),
          ),
          amountRangeSlider(
            startAmount: startAmount,
            endAmount: endAmount,
            maxAmount: maxAmount,
            minAmount: minAmount,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                startAmount = lowerValue;
                endAmount = upperValue;
              });
            },
          ),
          SizedBox(
            height: height10 * 4.8,
          ),
          bottomSheetBelowButtonRow(
            onPressedReset: () {
              setState(() {
                selectedStatus.clear();
              });
            },
            onPressedApply: () {
              Navigator.pop(context, [selectedStatus, startAmount, endAmount]);
            },
            resetString: 'Clear',
          )
        ],
      ),
    );
  }
}
