// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/models/notification.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();
  RxList<NotificationClass> notificationList =
      List<NotificationClass>.empty(growable: true).obs;

  // Future<String?> getAllNotifications() async {
  //   try {
  //     final String response =
  //         await rootBundle.loadString('assets/dummy_data/notifications.json');

  //     notificationList.value = listNotificationFromJson(response);
  //     return null;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  void readNotification(NotificationClass newNoti) {
    newNoti.unread = false;
    for (var i = 0; i < notificationList.length; i++) {
      if (notificationList[i].id == newNoti.id) {
        notificationList[i] = newNoti;
      }
    }
  }
}
