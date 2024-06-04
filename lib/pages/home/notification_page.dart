import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/pages/home/notification_detail_page.dart';
import 'package:ttpay/pages/home/notification_widgets/no_notification_column.dart';
import 'package:ttpay/pages/home/notification_widgets/notification_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: simpleAppBar(
          onTapBack: () {
            Navigator.pop(context);
          },
          title: AppLocalizations.of(context)!.notifications),
      body: backgroundContainer(
        child: Obx(() {
          final notificationsList = notificationController.notificationList;

          return notificationsList.isNotEmpty
              ? ListView.builder(
                  itemCount: notificationsList.length,
                  itemBuilder: (context, index) {
                    final notification = notificationsList[index];

                    return InkWell(
                        onTap: () {
                          notificationController.readNotification(notification);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationDetailPage(
                                    notification: notification),
                              ));
                        },
                        child: notificationRow(notification: notification));
                  },
                )
              : noNotificationColumn(context);
        }),
      ),
    );
  }
}
