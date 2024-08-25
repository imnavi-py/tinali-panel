import 'package:get/get.dart';
import 'package:steelpanel/data/admin_info.dart';

class usersMng extends GetxController {
  static bool isFrist = false;
  static List<AdminInfo> logininfo = [];
  void increment() {
    update();

    // print('is that $numday');
  }
}
