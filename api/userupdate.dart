import 'dart:convert';

import 'package:get/get.dart';
import 'package:steelpanel/api/config.dart';
import 'package:http/http.dart' as http;

Future<void> userUpdate(String name, String lastname, int id) async {
  var url = Uri.parse('${apiService.apiurl}/users/update.php?id=$id');
  var fname = name != '' ? name : '';
  var flastname = lastname != '' ? lastname : '';
  var data = jsonEncode({
    "name": fname,
    "lastname": flastname,
  });

  try {
    var response = await http.post(body: data, url);

    if (response.statusCode == 200) {
      print('ok');
      Get.snackbar('title', 'message');
    }
  } catch (e) {
    print(e);
    Get.snackbar('error', 'message');
  }
}

// UpdatePanel(String type, int id, context) async {
//   var url = Uri.parse(apiService.apiurl + '/update-panel.php');
//   print(type);
//   var data = {"user_id": id, "userType": type};

//   var response = await http.post(body: data, url);

//   if (response.statusCode == 200) {
//     print('ok');
//     Get.snackbar('موفقیت', 'کاربری شما تعیین شد');
//   }

//   Get.snackbar('error', 'message');
// }
