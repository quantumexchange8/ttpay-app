import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/models/notification.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();
  RxList<NotificationClass> notificationList =
      List<NotificationClass>.empty(growable: true).obs;

  Future<String?> getAllNotifications() async {
    try {
      final String response =
          await rootBundle.loadString('assets/dummy_data/groups.json');

      notificationList.value = listNotificationFromJson(response);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
