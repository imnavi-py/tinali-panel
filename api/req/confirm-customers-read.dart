import 'dart:convert';

import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/models/confirm-customers-model.dart';
import 'package:http/http.dart' as http;

Future<List<ConfirmedCustomer>> fetchConfirmedCustomers() async {
  final response = await http.get(Uri.parse(
      '${apiService.apiurl}/customers/confirmed/confirmed-customers-read.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => ConfirmedCustomer.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load confirmed customers');
  }
}
