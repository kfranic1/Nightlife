import 'package:nightlife/enums/role.dart';

class UserInfo {
  String username;
  Role role;

  UserInfo({
    required this.username,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "role": role.name,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> data) {
    return UserInfo(
      username: data['username'],
      role: Role.values.firstWhere((element) => element.name == data['role']),
    );
  }
}
