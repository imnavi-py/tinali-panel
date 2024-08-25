import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/data/admin_info.dart';
import 'package:steelpanel/main.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/utils/state_date.dart';
import 'package:steelpanel/api/config.dart';

Future<void> loginUserInfo(String username) async {
  var url = Uri.parse('${apiService.apiurl}/checkuserdata.php');

  var data = jsonEncode({"username": username});
  var response = await http.post(url, body: data);
  // Get.snackbar(
  //   'title',
  //   '${response.statusCode}',
  // );
  print(response.statusCode);
  if (response.statusCode == 200) {
    Get.off(HomePage(
      controller: SidebarXController(selectedIndex: 0, extended: true),
    ));
    // print('Response body: ${response.body}');
    // دریافت مقدار اطلاعات کاربر
    // مثال:
    String jsonString = response.body;
    Map<String, dynamic> data = json.decode(jsonString);
    // String usernamedata = data['username'];

    //  Get.snackbar(
    //   usernamedata,
    //   response.body,
    // );
    // Box<AdminInfo> hiveBox = Hive.box<AdminInfo>('adminBox');
    // AdminInfo dataToHive = AdminInfo(
    //     id: data['user_id'],
    //     name: data['name'] ?? '',
    //     lastName: data['lastname'] ?? '',
    //     unit: data['unit'] ?? '',
    //     isadmin: data['isadmin'] ?? 0,
    //     username: data['username'],
    //     password: data['password'],
    //     number: data['number'] ?? '');
    // await hiveBox.add(dataToHive);
    // MyApp.fetchDb();
    print(usersMng.logininfo[0].username);

    const SnackBar(content: Text('data'));

    Get.snackbar(
      'خوش آمدید',
      HomePage.logininfo.isEmpty ? HomePage.logininfo[0].username : 'empty',
    );
  } else {
    Get.snackbar(
      'خطا',
      'مشکلی به وجود آمده است',
    );
  }

  // else {
  //   print('Request failed with status: ${response.statusCode}');
  //   Get.snackbar('title', 'message',
  //       titleText: Text(response.statusCode.toString()));
  // }

  // Get.snackbar(
  //   'title',
  //   '${response.statusCode}',
  // );
}

Future<void> LogintoPanel(String username, String password) async {
  print(username);
  var url = Uri.parse('${apiService.apiurl}/user_auth.php');
  var data = jsonEncode({"username": username, "password": password});
  var response = await http.post(url, body: data);

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    // دریافت مقدار اطلاعات کاربر
    // مثال: String name = jsonDecode(response.body)['name'];
    // Get.snackbar('title', 'yesss');

    await loginUserInfo(username);
  } else {
    print('Request failed with status: ${response.statusCode}');
    Get.snackbar('title', '${response.statusCode}');
  }
}

Future<void> login() async {
  var url = Uri.parse('${apiService.apiurl}/user_auth.php');
  var data = jsonEncode({"username": "admin", "password": "admin"});
  var response = await http.post(
    url,
    body: data,
  );

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    // دریافت مقدار اطلاعات کاربر
    // مثال: String name = jsonDecode(response.body)['name'];
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
