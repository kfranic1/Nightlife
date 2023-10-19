import 'package:nightlife/enums/role.dart';

class AdminData {
  late Role role;
  late String clubName;
  late String clubId;

  AdminData({required this.role, required this.clubId, required this.clubName});

  Map<String, dynamic> toMap() {
    return {
      "role": role.name,
      "clubId": clubId,
      "clubName": clubName,
    };
  }

  factory AdminData.fromMap(Map<dynamic, dynamic> data) {
    return AdminData(
      role: Role.values.firstWhere((element) => element.name == data['role']),
      clubId: data['clubId'],
      clubName: data['clubName'],
    );
  }
}
