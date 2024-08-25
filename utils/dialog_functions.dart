import 'package:get/get.dart';

class DialogFuncs extends GetxController {
  // استفاده از RxBool برای متغیر مربوط به مخفی بودن رمز عبور
  var secureText = true.obs;
  static String buysell = '';
  static bool sellorder = true;

  void toggleSecureText() {
    // تغییر مقدار متغیر به صورت برعکس
    secureText.value = !secureText.value;
  }
}

// class CheckAdminNow extends GetxController {
//   static bool isAdminHere = false;
// }

// class checkdialog extends GetxController {
//   static String idValue = '';
//   void servicedialog() {
//     Get.defaultDialog(title: idValue);
//   }
// }
