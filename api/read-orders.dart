import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/models/read-buy-order-model.dart';
import 'package:steelpanel/models/read-order-model.dart';

// class ApiService {
//   String apiUrl = apiService.apiurl + '/orders/read-order.php';

//   Future<List<Order>> fetchOrders() async {
//     print(apiUrl);
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((order) => Order.fromJson(order)).toList();
//     } else {
//       throw Exception('Failed to load orders');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<SellOrder>> fetchOrders() async {
  final response =
      await http.get(Uri.parse('${apiService.apiurl}/orders/read-order.php'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<SellOrder> orders =
        body.map((dynamic item) => SellOrder.fromJson(item)).toList();
    return orders;
  } else {
    throw Exception('Failed to load orders');
  }
}

Future<List<BuyOrder>> fetchOrdersBuy() async {
  final response =
      await http.get(Uri.parse('${apiService.apiurl}/orders/read-order.php'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<BuyOrder> orders =
        body.map((dynamic item) => BuyOrder.fromJson(item)).toList();
    return orders;
  } else {
    throw Exception('Failed to load orders');
  }
}
