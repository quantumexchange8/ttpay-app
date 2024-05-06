import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/notification.dart';

Container notificationRow({
  required NotificationClass notification,
}) {
  String iconAddress;
  if (notification.type.contains('deposit')) {
    iconAddress = 'assets/icon_image/icon-deposit.png';
  } else if (notification.type.contains('request')) {
    iconAddress = 'assets/icon_image/icon-request.png';
  } else {
    iconAddress = 'assets/icon_image/icon-withdrawal.png';
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: width08 * 2),
    decoration: BoxDecoration(
      color: notification.unread
          ? Colors.white.withOpacity(0.1)
          : Colors.transparent,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height08),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.50, color: neutralGrayScale.shade800),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                iconAddress,
                height: height10 * 3.6,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: width24 / 2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: textSm.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd').format(notification.createdAt),
                          textAlign: TextAlign.right,
                          style: textXXS,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      notification.body,
                      style: textXS.copyWith(
                        color: neutralGrayScale,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
