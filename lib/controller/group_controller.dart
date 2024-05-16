import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/models/group.dart';

class GroupController extends GetxController {
  static GroupController instance = Get.find();
  RxList<Group> groupList = List<Group>.empty(growable: true).obs;

  Future<String?> getAllGroup() async {
    try {
      final String response =
          await rootBundle.loadString('assets/dummy_data/groups.json');

      groupList.value = listGroupFromJson(response);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void addGroup(Group newGroup) {
    groupList.add(newGroup);

    return;
  }
}
