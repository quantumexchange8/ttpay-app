import 'dart:convert';

List<User> listUserFromJson(String json) {
  List data = jsonDecode(json);
  return List<User>.from(data.map((e) => User.fromMap(e)));
}

List<User> listUserFromListMap(List<Map<String, dynamic>> userList) {
  return List<User>.from(userList.map((e) => User.fromMap(e)));
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int id;
  String name;
  String managerName;
  String email;
  String? profilePhoto;
  String profileId;
  String? phoneNumber;
  User({
    required this.id,
    required this.name,
    required this.managerName,
    required this.email,
    this.profilePhoto,
    required this.profileId,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'manager_name': managerName,
      'email': email,
      'profile_photo': profilePhoto,
      'profile_id': profileId,
      'phone_number': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    List media = map['media'];

    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      managerName: map['manager_name'] as String,
      email: map['email'] as String,
      profilePhoto: media.isNotEmpty ? media.last['original_url'] : null,
      profileId: map['role_id'] as String,
      phoneNumber: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
