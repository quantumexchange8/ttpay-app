import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/const.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/models/notification.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationClass notification;
  const NotificationDetailPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      extendBodyBehindAppBar: true,
      body: backgroundContainer(
          child: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: width08 * 2, vertical: height08),
          children: [
            Text(
              rowDateFormat.format(notification.createdAt),
              style: textXS.copyWith(
                color: neutralGrayScale.shade300,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height20),
              child: Text(
                notification.title,
                style: textLg.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              notification.body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textSm.copyWith(
                color: neutralGrayScale.shade300,
              ),
            )
          ],
        ),
      )),
    );
  }
}
