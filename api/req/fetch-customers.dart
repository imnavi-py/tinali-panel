import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:steelpanel/screens/pages/customers.dart';
import 'package:steelpanel/screens/pages/customers_controller.dart';

final CustomersController controller = Get.put(CustomersController());
const String url = 'http://test.ht-hermes.com/customers/readcustomer.php';
Future<void> fetchCustomerss() async {
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> newCustomers = jsonDecode(response.body);
      controller
          .updateCustomers(newCustomers); // اضافه کردن داده‌های جدید به کنترلر
      print(newCustomers);
      controller.updateCustomers(newCustomers);
    } else {
      print('Failed to load customers. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading customers: $e');
  }
}
