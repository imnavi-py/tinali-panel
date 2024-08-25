import 'package:hive/hive.dart';

part 'admin_info.g.dart';

@HiveType(typeId: 0)
class AdminInfo {
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String unit;
  @HiveField(5)
  bool isadmin;
  @HiveField(6)
  String username;
  @HiveField(7)
  String password;
  @HiveField(8)
  String number;

  AdminInfo(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.unit,
      required this.isadmin,
      required this.username,
      required this.password,
      required this.number});

  factory AdminInfo.fromJson(Map<String, dynamic> json) {
    return AdminInfo(
      id: json['user_id'],
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      isadmin: json['isadmin'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['lastname'] ?? '',
      unit: json['unit'] ?? '',
      number: json['number'] ?? '',
    );
  }
}
