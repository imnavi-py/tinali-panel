import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/api/req/delete-customer.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/pages/home.dart';

Future<void> transferCustomers_wa(List<int> ids, int userid, context) async {
  final String url =
      '${apiService.apiurl}/customers/confirmed/make-confirmed.php';

  try {
    var response = await http.post(
      Uri.parse(url),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode({'ids': ids}),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
      Get.defaultDialog(
          title: 'موفقیت',
          middleText: 'به بخش تایید شده منتقل شد',
          middleTextStyle: const TextStyle(fontFamily: 'Irs', fontSize: 16),
          titleStyle: const TextStyle(fontFamily: 'Irs', fontSize: 20));
      deleteCustomers(ids);
      AddtoLogs('مشتریان', 'مشتری / مشتریان تایید شدند $ids');
      /////////////////////////

      final String url = '${apiService.apiurl}/users/update_usr_advanced.php';
      var responses = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          "user_id": userid,
          "userType": "confirmed_customers",
          "verified": "1"
        }),
      );
      print(ids[0]);

      if (responses.statusCode == 200) {
        print('ok update shod');
        print(response.body);

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomeMain(
              xxcontroller:
                  SidebarXController(selectedIndex: 0, extended: true),
            );
          },
        ));
        // مخفی کردن بارگذاری اندیکاتور
        Get.back();
        // sentmessage();
        // Get.defaultDialog(
        //   title: 'اطلاعات شما با موفقیت ثبت شد',
        //   middleText: 'در حال رسیدگی به تایید اطلاعات شما',
        //   titleStyle: const TextStyle(
        //     fontFamily: 'Irs',
        //     fontSize: 15,
        //     color: Colors.white,
        //   ),
        // );
      } else {
        print(
            'Failed to update user data. Status code: ${response.statusCode}');
        print(response.body);
      }

      ///////////////////////////////////////////
      Get.back();
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: 'نا موفق',
        messageText: Text('مشکلی پیش آمده است'),
        duration: Duration(seconds: 2), // مدت زمان نمایش اسنک بار
      ));
    }
  } catch (e) {
    print(e);
  }
}
