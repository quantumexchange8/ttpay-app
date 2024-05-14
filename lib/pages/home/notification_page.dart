import 'package:flutter/material.dart';
import 'package:ttpay/component/background_container.dart';
import 'package:ttpay/component/simple_appbar.dart';
import 'package:ttpay/helper/dummyData/notifications_history.dart';
import 'package:ttpay/models/notification.dart';
import 'package:ttpay/pages/home/notification_detail_page.dart';
import 'package:ttpay/pages/home/notification_widgets/no_notification_column.dart';
import 'package:ttpay/pages/home/notification_widgets/notification_row.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsList =
        listNotificationClassFromListMap(dummyNotifications);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: simpleAppBar(
          onTapBack: () {
            Navigator.pop(context);
          },
          title: 'Notifications'),
      body: backgroundContainer(
        child: notificationsList.isNotEmpty
            ? ListView.builder(
                itemCount: notificationsList.length,
                itemBuilder: (context, index) {
                  final notification = notificationsList[index];

                  return InkWell(
                      onTap: () {
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
            : noNotificationColumn,
      ),
    );
  }
}
