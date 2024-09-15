import 'package:http/http.dart' as http;
import 'package:steelpanel/api/config.dart';
import 'dart:convert';

import '../../models/confirmed-customers-model-create.dart';

Future<void> confirmCustomer(Customer customer) async {
  final String url =
      '${apiService.apiurl}/customers/confirmed/confirmed-customers.php';
  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );

    if (response.statusCode == 201) {
      print('Customer confirmed successfully');
    } else {
      print('Failed to confirm customer. Status code: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error confirming customer: $e');
  }
}
