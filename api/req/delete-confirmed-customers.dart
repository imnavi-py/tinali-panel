import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:steelpanel/api/config.dart';

Future<void> deleteConfirmCustomers(List<int> ids) async {
  final url = Uri.parse(
      '${apiService.apiurl}/customers/confirmed/delete-concustomer.php'); // URL سرور شما

  try {
    // ارسال درخواست POST به سرور
    var response = await http.post(
      url,
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode(<String, dynamic>{'ids': ids}),
    );

    if (response.statusCode == 200) {
      // با موفقیت اجرا شد، می‌توانید پاسخ را نمایش دهید
      print('Response: ${response.body}');
    } else {
      // اگر هر گونه خطا رخ داد
      print('Failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error deleting customers: $e');
  }
}
