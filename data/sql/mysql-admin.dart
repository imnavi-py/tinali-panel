import 'package:hive/hive.dart';
import 'package:steelpanel/data/admin_info.dart';

class HiveService {
  static const _boxName = 'adminBox';

  static Box<AdminInfo> get userBox => Hive.box<AdminInfo>(_boxName);

  static void initialize() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<AdminInfo>(_boxName);
    }
  }

  static Future<void> saveUser(AdminInfo user) async {
    await userBox.put(user.username, user);
  }

  static Future<AdminInfo?> getUser(String username) async {
    return userBox.get(username);
  }
}
