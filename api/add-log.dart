import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:steelpanel/api/config.dart';

Future AddtoLogs(String unit, String process) async {
  final response = await http.post(
    Uri.parse('${apiService.apiurl}/logs/logs.php'),
    body: jsonEncode({'unit': unit, 'process': process}),
  );

  if (response.statusCode == 200) {
  } else {
    print('Error');
  }
}
