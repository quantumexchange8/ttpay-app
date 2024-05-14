import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/button_cta.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/methods.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/transaction/widgets/pin_under_bottomsheet.dart';

List<Map<String, dynamic>> dateList = [
  {
    'date_name': 'Today',
    'first_date':
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    'last_date': DateTime.now(),
  },
  {
    'date_name': 'Yesterday',
    'first_date': DateTime(
        DateTime.now().subtract(const Duration(days: 1)).year,
        DateTime.now().subtract(const Duration(days: 1)).month,
        DateTime.now().subtract(const Duration(days: 1)).day),
    'last_date': DateTime.now(),
  },
  {
    'date_name': 'Last 7 days',
    'first_date': DateTime(
        DateTime.now().subtract(const Duration(days: 7)).year,
        DateTime.now().subtract(const Duration(days: 7)).month,
        DateTime.now().subtract(const Duration(days: 7)).day),
    'last_date': DateTime.now(),
  },
  {
    'date_name': 'Last 30 days',
    'first_date': DateTime(
        DateTime.now().subtract(const Duration(days: 30)).year,
        DateTime.now().subtract(const Duration(days: 30)).month,
        DateTime.now().subtract(const Duration(days: 30)).day),
    'last_date': DateTime.now(),
  },
  {
    'date_name': 'This Month',
    'first_date': DateTime(DateTime.now().year, DateTime.now().month, 1),
    'last_date': DateTime.now(),
  },
  {
    'date_name': 'Last Month',
    'first_date': DateTime(determinelastMonthYear(), determinelastMonth(), 1),
    'last_date': DateTime(determinelastMonthYear(), determinelastMonth(),
        determinelastMonthLastDay()),
  },
];

Container dateContainer(String dateName, {bool isPicked = false}) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width24 / 2, vertical: height24 / 4),
    decoration: ShapeDecoration(
      color: isPicked ? Colors.white.withOpacity(0.1) : Colors.transparent,
      shape: RoundedRectangleBorder(
        side: isPicked
            ? BorderSide.none
            : BorderSide(width: 1, color: neutralGrayScale.shade800),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    child: Text(
      dateName,
      textAlign: TextAlign.center,
      style: textXS,
    ),
  );
}

Column pickedDateColumn({
  required String title,
  required DateTime pickedDate,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: textSm.copyWith(
          color: neutralGrayScale.shade300,
          fontWeight: FontWeight.w500,
        ),
      ),
      Container(
        padding:
            EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height08),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          DateFormat('dd MMM yyyy').format(pickedDate),
          style: textMd,
        ),
      ),
    ],
  );
}

class DatePickerBottomsheet extends StatefulWidget {
  final DateTime firstDatePicked;
  final DateTime lastDatePicked;

  const DatePickerBottomsheet(
      {super.key, required this.firstDatePicked, required this.lastDatePicked});

  @override
  State<DatePickerBottomsheet> createState() => _DatePickerBottomsheetState();
}

class _DatePickerBottomsheetState extends State<DatePickerBottomsheet> {
  late DateTime firstDatePicked = widget.firstDatePicked;
  late DateTime lastDatePicked = widget.lastDatePicked;
  List<DateTime?> pickedDateList = [];

  @override
  Widget build(BuildContext context) {
    return backgroundContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      padding:
          EdgeInsets.symmetric(vertical: height24, horizontal: width08 * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          topBottomsheet(context, 'Select Date'),
          SizedBox(
            height: height24,
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: height30,
              crossAxisSpacing: width08,
              mainAxisSpacing: height08,
            ),
            children: dateList
                .map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          firstDatePicked = e['first_date'];
                          lastDatePicked = e['last_date'];
                          pickedDateList = [firstDatePicked, lastDatePicked];
                        });
                      },
                      child: dateContainer(e['date_name'],
                          isPicked: (firstDatePicked == e['first_date'] &&
                              lastDatePicked == e['last_date'])),
                    ))
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height20),
            child: Row(
              children: [
                Expanded(
                  child: pickedDateColumn(
                      title: 'Start Date', pickedDate: firstDatePicked),
                ),
                SizedBox(
                  width: width24 / 2,
                ),
                Expanded(
                  child: pickedDateColumn(
                      title: 'End Date', pickedDate: lastDatePicked),
                ),
              ],
            ),
          ),
          CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              weekdayLabelTextStyle: textMd.copyWith(color: neutralGrayScale),
              controlsTextStyle: textMd.copyWith(fontWeight: FontWeight.w600),
              nextMonthIcon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: height20,
              ),
              lastMonthIcon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: height20,
              ),
              // dayTextStyle: ,
              // selectedDayTextStyle:,
              // todayTextStyle:,
              yearTextStyle: textMd.copyWith(fontWeight: FontWeight.w600),
              selectedYearTextStyle:
                  textMd.copyWith(fontWeight: FontWeight.w600),
              monthTextStyle: textMd.copyWith(fontWeight: FontWeight.w600),
              // selectedRangeDayTextStyle:,
              calendarType: CalendarDatePicker2Type.range,
              // selectedDayHighlightColor: Colors.white.withOpacity(0.1),
              selectedRangeHighlightColor: Colors.transparent,
              yearBuilder: (
                  {decoration,
                  isCurrentYear,
                  isDisabled,
                  isSelected,
                  textStyle,
                  required year}) {
                return Container(
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: width20, vertical: height08 / 2),
                  decoration: BoxDecoration(
                    color: isSelected != null && isSelected
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      year.toString(),
                      textAlign: TextAlign.center,
                      style: textSm.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
              disableMonthPicker: true,
              dayBuilder: (
                  {required date,
                  decoration,
                  isDisabled,
                  isSelected,
                  isToday,
                  textStyle}) {
                bool isInRange = date.isAfter(firstDatePicked) &&
                    date.isBefore(lastDatePicked);
                bool isSelect = isSelected != null && isSelected;
                Color bgColor = Colors.transparent;
                if (isInRange) {
                  bgColor = const Color(0xFF210077);
                }
                if (isSelect) {
                  bgColor = primaryPurpleScale.shade700;
                }

                return Container(
                  width: height31,
                  height: height31,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: textSm.copyWith(
                          color: isInRange || isSelect
                              ? Colors.white
                              : neutralGrayScale),
                    ),
                  ),
                );
              },
            ),
            value: pickedDateList,
            onValueChanged: (dates) {
              setState(() {
                pickedDateList = dates;
                if (!dates.contains(null)) {
                  firstDatePicked = dates.first!;
                  lastDatePicked = dates.last!;
                }
              });
            },
          ),
          SizedBox(
            height: height24,
          ),
          bottomSheetBelowButtonRow(
            onPressedReset: () {
              setState(() {
                firstDatePicked =
                    DateTime(DateTime.now().year, DateTime.now().month, 1);
                lastDatePicked = DateTime.now();
                pickedDateList = [firstDatePicked, lastDatePicked];
              });
            },
            onPressedApply: () {
              Navigator.pop(context, [firstDatePicked, lastDatePicked]);
            },
          )
        ],
      ),
    );
  }
}

Row bottomSheetBelowButtonRow({
  required void Function()? onPressedReset,
  required void Function()? onPressedApply,
  String? resetString,
}) {
  return Row(
    children: [
      Expanded(
        child: ctaButton(
            onPressed: onPressedReset,
            bgColor: Colors.white.withOpacity(0.05),
            text: resetString ?? 'Reset'),
      ),
      SizedBox(
        width: width24 / 2,
      ),
      Expanded(
        child: ctaButton(
            onPressed: onPressedApply,
            bgColor: primaryPurpleScale.shade700,
            text: 'Apply'),
      )
    ],
  );
}
