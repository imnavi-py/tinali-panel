// import 'dart:convert';

// import 'package:http/http.dart' as http;

// Future<void> checkCustomerId(String customerId) async {
//   final response = await http.get(Uri.parse(
//       'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     if (data != null && data['id'].toString() == customerId) { retur
//       _showCustomerDialog(data['responsible_name'], data['company_name']);
//       setState(() {
//         isCustomerVerified = true;
//         showId = false;
//         showInfo = true;
//       });
//     } else {
//       _showErrorDialog('مشخصات یافت نشد');
//       setState(() {
//         isCustomerVerified = false;
//       });
//     }
//   } else {
//     _showErrorDialog('مشکلی در دریافت داده');
//     setState(() {
//       isCustomerVerified = false;
//     });
//   }
// }
