import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/home/widgets/notification_container.dart';

SliverAppBarBuilder homeSliverAppbar({
  bool unreadNoti = false,
  required double netAmount,
  required double grossAmount,
  required double feeAmount,
}) {
  return SliverAppBarBuilder(
    leadingActions: const [],
    backgroundColorBar: Colors.transparent,
    backgroundColorAll: Colors.transparent,
    initialBarHeight: 0,
    barHeight: height10 * 8,
    initialContentHeight: height100 * 1.1,
    contentBuilder:
        (context, expandRatio, contentHeight, centerPadding, overlapsContent) {
      if (contentHeight > height100) {
        return bigAppBar(
            expandRatio: expandRatio,
            netAmount: netAmount,
            grossAmount: grossAmount,
            feeAmount: feeAmount);
      } else {
        return smallAppBar(
            netAmount: netAmount,
            grossAmount: grossAmount,
            feeAmount: feeAmount);
      }
    },
  );
}

Widget bigAppBar({
  bool unreadNoti = false,
  required double netAmount,
  required double grossAmount,
  required double feeAmount,
  required double expandRatio,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width08 * 2),
    decoration: const ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(-0.68, -0.73),
        end: Alignment(0.68, 0.73),
        colors: [
          Color(0xFF210077),
          Color(0xFF6214FF),
          Color(0xFF9173FF),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, CC Power Group! 👋',
                  style: textSm.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height08,
                ),
                Text(
                  'Net Amount',
                  style: textXS.copyWith(
                    color: neutralGrayScale,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$ ${amountFormatter.format(netAmount)} ',
                        style: textXXL.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'USDT',
                        style: textSm.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: width10 * 4.4,
              height: height10 * 8.8,
              padding: EdgeInsets.all(height08 / 2),
              decoration: ShapeDecoration(
                color: const Color(0x33030712),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  notificationContainer(unreadNoti),
                  SizedBox(height: height08),
                  Container(
                    padding: EdgeInsets.all(height24 / 4),
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Image.asset(
                      "assets/icon_image/merchant_pp.png",
                      fit: BoxFit.fitHeight,
                      height: height24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: height24 / 2,
        ),
        Row(
          children: [
            _dataColumnBig(
                title: 'Gross Amount',
                subtitle: '\$ ${amountFormatter.format(grossAmount)}'),
            SizedBox(
              width: width10 * 2.7,
            ),
            _dataColumnBig(
                title: 'Fee',
                subtitle: '\$ ${amountFormatter.format(feeAmount)}'),
          ],
        ),
        SizedBox(
          height: height10 * 2.8,
        )
      ],
    ),
  );
}

Widget smallAppBar({
  bool unreadNoti = false,
  required double netAmount,
  required double grossAmount,
  required double feeAmount,
}) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height10 * 1.4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05000000074505806),
    ),
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              _dataColumnSmall(
                  title: 'Net Amount',
                  subtitle: '\$ ${amountFormatter.format(netAmount)}'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width08 * 2),
                child: _dataColumnSmall(
                    title: 'Gross Amount',
                    subtitle: '\$ ${amountFormatter.format(grossAmount)}'),
              ),
              _dataColumnSmall(
                  title: 'Fee',
                  subtitle: '\$ ${amountFormatter.format(feeAmount)}'),
            ],
          ),
        ),
        notificationContainer(unreadNoti)
      ],
    ),
  );
}

Column _dataColumnBig({
  required String title,
  required String subtitle,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: textXS.copyWith(
          color: neutralGrayScale,
        ),
      ),
      Text(
        subtitle,
        style: textLg.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Column _dataColumnSmall({
  required String title,
  required String subtitle,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: textXXS.copyWith(
          color: neutralGrayScale,
        ),
      ),
      Text(
        subtitle,
        style: textXS.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
