// import 'dart:convert';

// import 'package:steelpanel/models/read-order-model.dart';
// import 'package:http/http.dart' as http;

// Future<List<SellOrder>> fetchSellOrders() async {
//   final response = await http
//       .get(Uri.parse('https://test.ht-hermes.com/orders/read-order.php'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(response.body);
//     return data.map((item) => SellOrder.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load sell orders');
//   }
// }
