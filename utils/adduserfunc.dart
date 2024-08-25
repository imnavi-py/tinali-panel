import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/screens/homescreen.dart';

import '../data/admin_info.dart';

Future<void> createUser(String username, String password, bool isAdmin,
    String userType, BuildContext context) async {
  // آدرس فایل PHP
  var url = Uri.parse('${apiService.apiurl}/new.php');

  // داده‌های JSON برای ارسال
  var data = jsonEncode({
    "username": username, "password": password, "isadmin": isAdmin,
    "userType": userType, // اضافه کردن فیلد userType
  });

  try {
    // ارسال درخواست POST با فرمت JSON
    var response = await http.post(
      url,
      headers: {
        'Content-Type':
            'application/json', // تنظیم هدر Content-Type به فرمت JSON
      },
      body: data, // ارسال داده‌های JSON به فایل PHP
    );

    // چک کردن کد وضعیت درخواست
    if (response.statusCode == 201) {
      print('User created successfully');
      // Extract user_id from response
      Map<String, dynamic> responseData = json.decode(response.body);
      int userId = responseData['user_id'];
      print('User ID: $userId');

      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              controller: SidebarXController(selectedIndex: 0, extended: true),
            ),
          ),
          (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID: $userId'),
        ),
      );

      // String jsonString = response.body;
      // Map<String, dynamic> data = json.decode(jsonString);
      Box<AdminInfo> hiveBox = Hive.box<AdminInfo>('adminBox');
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
    } else {
      print('Failed to create user');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ارور'),
        ),
      );
    }
  } catch (e) {
    print('Error: $e');
  }
}
