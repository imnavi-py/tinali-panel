import 'dart:convert';

import 'package:get/get.dart';
import 'package:steelpanel/api/config.dart';
import 'package:http/http.dart' as http;
import 'package:steelpanel/control/user-info.dart';

Future<void> tokenCheck() async {
  var url = Uri.parse('${apiService.apiurl}/ctoken.php/');
  var data = jsonEncode({"token": UserInfoControll.token.value});
  var response = await http.post(url, body: data);
  print(data);
  if (response.statusCode == 200) {
    var showToken = jsonDecode(response.body)['userType'];
    print('Response body: $showToken');
    print(UserInfoControll.userType);
    print(UserInfoControll.user_id);

    // html.document.cookie = 'textfield_value=$_token; path=/';
    // return showToken;
  } else {
    print('Request failed with status: ${response.statusCode}');
    Get.snackbar('پیام سیستم', 'لطفا وارد شوید');
  }
}
