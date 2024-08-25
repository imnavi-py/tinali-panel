import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:steelpanel/models/currency-model.dart';

Future<void> fetchCurrencyValues() async {
  final response = await http.get(Uri.parse(
      'https://api.navasan.tech/latest/?api_key=freelbZduXHHBbxMEN7EIeCzguOPs1rG'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(CurrencyController.usd.value = data['usd']['value']);
    CurrencyController.usd.value = data['usd']['value'];
    CurrencyController.dirhamDubai.value = data['dirham_dubai']['value'];
    CurrencyController.eur.value = data['eur']['value'];
    // ayar18.value = data['ayar18']['value'];
  } else {
    throw Exception('Failed to load currency data');
  }
}
