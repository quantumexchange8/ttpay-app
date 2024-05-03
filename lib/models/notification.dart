import 'dart:convert';

List<NotificationClass> listNotificationClassFromListMap(
    List<Map<String, dynamic>> notificationClassList) {
  return List<NotificationClass>.from(
      notificationClassList.map((e) => NotificationClass.fromMap(e)));
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationClass {
  int id;
  DateTime createdAt;
  String title;
  String body;
  String type;
  bool unread;
  NotificationClass({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.type,
    required this.unread,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt,
      'title': title,
      'body': body,
      'type': type,
      'unread': unread,
    };
  }

  factory NotificationClass.fromMap(Map<String, dynamic> map) {
    return NotificationClass(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      title: map['title'] as String,
      body: map['body'] as String,
      type: map['type'] as String,
      unread: bool.parse(map['unread']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationClass.fromJson(String source) =>
      NotificationClass.fromMap(json.decode(source));
}
