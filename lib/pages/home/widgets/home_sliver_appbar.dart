import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:ttpay/component/profile_image_container.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/home/widgets/notification_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SliverAppBarBuilder homeSliverAppbar(
    {void Function()? onTapProfile,
    void Function()? onTapNoti,
    bool unreadNoti = false,
    required double netAmount,
    required double grossAmount,
    required double feeAmount,
    required dynamic profilePhoto}) {
  return SliverAppBarBuilder(
    pinned: true,
    leadingActions: const [],
    backgroundColorBar: Colors.transparent,
    backgroundColorAll: Colors.transparent,
    initialBarHeight: height100 * 1.9,
    contentBelowBar: false,
    barHeight: height10 * 7,
    initialContentHeight: 0,
    contentBuilder:
        (context, expandRatio, contentHeight, centerPadding, overlapsContent) {
      if (contentHeight > height100 * 1.45) {
        return bigAppBar(context,
            profilePhoto: profilePhoto,
            onTapProfile: onTapProfile,
            onTapNoti: onTapNoti,
            unreadNoti: unreadNoti,
            expandRatio: expandRatio,
            netAmount: netAmount,
            grossAmount: grossAmount,
            feeAmount: feeAmount);
      } else {
        return smallAppBar(context,
            onTapNoti: onTapNoti,
            unreadNoti: unreadNoti,
            netAmount: netAmount,
            grossAmount: grossAmount,
            feeAmount: feeAmount);
      }
    },
  );
}

Widget bigAppBar(
  BuildContext context, {
  void Function()? onTapNoti,
  void Function()? onTapProfile,
  bool unreadNoti = false,
  required double netAmount,
  required double grossAmount,
  required double feeAmount,
  required double expandRatio,
  required dynamic profilePhoto,
}) {
  return Obx(() {
    final user = userController.user.value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width08 * 2),
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.68, 0.73),
          end: Alignment(1.2, -0.73),
          stops: [0.1, 0.9, 1],
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
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.hello}, ${user?.name ?? ''}! 👋',
                      style: textSm.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: height08,
                    ),
                    Text(
                      AppLocalizations.of(context)!.net_amount,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: onTapNoti,
                          child: notificationContainer(unreadNoti)),
                      SizedBox(height: height08),
                      InkWell(
                        onTap: onTapProfile,
                        child: Container(
                          padding: EdgeInsets.all(height24 / 4),
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: profileImageContainer(
                              accountPhoto: profilePhoto, size: height24),
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
                    title: AppLocalizations.of(context)!.gross_amount,
                    subtitle: '\$ ${amountFormatter.format(grossAmount)}'),
                SizedBox(
                  width: width10 * 2.7,
                ),
                _dataColumnBig(
                    title: AppLocalizations.of(context)!.fee,
                    subtitle: '\$ ${amountFormatter.format(feeAmount)}'),
              ],
            ),
            SizedBox(
              height: height24,
            )
          ],
        ),
      ),
    );
  });
}

Widget smallAppBar(
  BuildContext context, {
  void Function()? onTapNoti,
  bool unreadNoti = false,
  required double netAmount,
  required double grossAmount,
  required double feeAmount,
}) {
  return ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            width08 * 2, height10 * 5, width08 * 2, height10 * 1.4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  _dataColumnSmall(
                      title: AppLocalizations.of(context)!.net_amount,
                      subtitle: '\$ ${amountFormatter.format(netAmount)}'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width08 * 2),
                    child: _dataColumnSmall(
                        title: AppLocalizations.of(context)!.gross_amount,
                        subtitle: '\$ ${amountFormatter.format(grossAmount)}'),
                  ),
                  _dataColumnSmall(
                      title: AppLocalizations.of(context)!.fee,
                      subtitle: '\$ ${amountFormatter.format(feeAmount)}'),
                ],
              ),
            ),
            InkWell(onTap: onTapNoti, child: notificationContainer(unreadNoti))
          ],
        ),
      ),
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
