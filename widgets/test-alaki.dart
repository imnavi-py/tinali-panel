// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:steelpanel/api/config.dart';
// import 'package:steelpanel/models/read-buy-order-model.dart';
// import 'package:steelpanel/models/read-order-model.dart';
// import 'package:steelpanel/screens/pages/orders.dart';

// class AddOrderPage extends StatefulWidget {
//   final Function refresh;

//   const AddOrderPage({super.key, required this.refresh});
//   @override
//   _AddOrderPageState createState() => _AddOrderPageState();
// }

// class _AddOrderPageState extends State<AddOrderPage> {
//   final TextEditingController customerIdController = TextEditingController();
//   final TextEditingController productController = TextEditingController();
//   final TextEditingController feeController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();
//   final TextEditingController branchController = TextEditingController();
//   final TextEditingController thicknessController = TextEditingController();
//   final TextEditingController widthController = TextEditingController();
//   final TextEditingController sizeController = TextEditingController();
//   final TextEditingController gradeController = TextEditingController();
//   final TextEditingController howPayController = TextEditingController();
//   final TextEditingController untilPayController = TextEditingController();

//   final TextEditingController economyCode = TextEditingController();
//   final TextEditingController onTax = TextEditingController();

//   final TextEditingController profitonmonth = TextEditingController();
//   final TextEditingController operatorName = TextEditingController();

//   bool isSellOrder = true;
//   bool isCustomerVerified = false;
//   bool showId = true;
//   bool showInfo = false;
//   Future<void> checkCustomerId(String customerId) async {
//     final response = await http.get(Uri.parse(
//         'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data != null && data['id'].toString() == customerId) {
//         _showCustomerDialog(data['responsible_name'], data['company_name'],
//             data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد');
//         setState(() {
//           isCustomerVerified = data['has_open_order'] == 0 ? true : false;

//           showId = data['has_open_order'] == 0 ? false : true;
//           showInfo = data['has_open_order'] == 0 ? true : false;
//         });
//       } else {
//         _showErrorDialog('مشخصات یافت نشد');
//         setState(() {
//           isCustomerVerified = false;
//         });
//       }
//     } else {
//       _showErrorDialog('مشکلی در دریافت داده');
//       setState(() {
//         isCustomerVerified = false;
//       });
//     }
//   }

//   void _showCustomerDialog(
//       String customerName, String companyName, String hasOpenOrder) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(
//             '! مشخصات یافت شد',
//             style: TextStyle(fontFamily: 'Irs'),
//           ),
//           content: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Container(
//               height: 100,
//               child: Column(
//                 children: [
//                   Text('نام مشتری: $customerName',
//                       style: TextStyle(fontFamily: 'Irs')),
//                   Text('نام کمپانی : $companyName',
//                       style: TextStyle(fontFamily: 'Irs')),
//                   Text('سفارش باز : $hasOpenOrder')
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('تایید'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('! خطا '),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('تایید'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> addOrder() async {
//     final response = await http.post(
//       Uri.parse(apiService.apiurl + '/orders/add-order.php'),
//       body: jsonEncode({
//         'customer_id': customerIdController.text,
//         // 'economic_code' : ,
//         'product': productController.text,
//         'fee': feeController.text,
//         'weight': weightController.text,
//         'branch': branchController.text,
//         'thickness': thicknessController.text,
//         'width': widthController.text,
//         'size': sizeController.text,
//         'grade': gradeController.text,
//         'how_pay': howPayController.text,
//         'until_pay': untilPayController.text,
//         "economic_code": economyCode.text,
//         "ontax": onTax.text,
//         "profit_month": profitonmonth.text,
//         "operator_name": operatorName.text,

//         // "ontax": "15%",
//         //     "profit_month": "June",
//         //       "operator_name": "Operator Name"
//         'order_date': DateTime.now().toIso8601String(),
//       }),
//     );
//     print(response.body);
//     if (response.statusCode == 201) {
//       // Order added successfully
//       widget.refresh;
//       Navigator.of(context).pop(true); // Return to previous page with success
//     } else
//       (e) {
//         // Error adding order
//         _showErrorDialog('Error adding order $e');
//       };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 226, 219, 219),
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'ثبت سفارش',
//           style: TextStyle(
//             fontFamily: 'Irs',
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: ListView(
//             children: [
//               Visibility(
//                 visible: showId,
//                 child: buildTextFieldWithIcon(
//                     controller: customerIdController,
//                     labelText: 'آیدی مشتری / فروشنده',
//                     icon: Icons.check,
//                     onPressed: () {
//                       checkCustomerId(customerIdController.text);
//                     }),
//               ),
//               Visibility(visible: showInfo, child: Text('data')),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                     controller: productController,
//                     labelText: 'نام محصول',
//                     enabled: isCustomerVerified),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                     controller: feeController,
//                     labelText: 'فی',
//                     enabled: isCustomerVerified),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                     controller: weightController,
//                     labelText: 'وزن',
//                     enabled: isCustomerVerified),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                     controller: branchController,
//                     labelText: 'تعداد شاخه/بندیل',
//                     enabled: isCustomerVerified),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                     controller: thicknessController,
//                     labelText: 'ضخامت',
//                     enabled: isCustomerVerified),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                     controller: widthController,
//                     labelText: 'طول',
//                     enabled: isCustomerVerified),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                     controller: sizeController,
//                     labelText: 'سایز / ویژگی',
//                     enabled: isCustomerVerified),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                     controller: gradeController,
//                     labelText: 'گرید',
//                     enabled: isCustomerVerified),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                     controller: howPayController,
//                     labelText: 'نحوه پرداخت',
//                     enabled: isCustomerVerified),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                     controller: untilPayController,
//                     labelText: 'بازه پرداخت',
//                     enabled: isCustomerVerified),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                     controller: economyCode,
//                     labelText: 'کد اقتصادی',
//                     enabled: isCustomerVerified),
//               ]),
//               SizedBox(height: 16.0),
//               // buildRow([
//               //   buildTextField(
//               //       controller: howPayController,
//               //       labelText: 'نحوه پرداخت',
//               //       enabled: isCustomerVerified),
//               //   SizedBox(width: 16.0),
//               //   buildTextField(
//               //       controller: untilPayController,
//               //       labelText: 'بازه پرداخت',
//               //       enabled: isCustomerVerified),
//               //   SizedBox(width: 16.0),
//               //   buildTextField(
//               //       controller: economyCode,
//               //       labelText: 'کد اقتصادی',
//               //       enabled: isCustomerVerified),
//               // ]),
//               buildRow(
//                 [
//                   buildTextField(
//                       controller: onTax,
//                       labelText: 'ارزش افزوده',
//                       enabled: isCustomerVerified),
//                   SizedBox(width: 16.0),
//                   buildTextField(
//                       controller: profitonmonth,
//                       labelText: ' سودماهانه',
//                       enabled: isCustomerVerified),
//                   SizedBox(width: 16.0),
//                   buildTextField(
//                       controller: operatorName,
//                       labelText: 'نام اپراتور',
//                       enabled: isCustomerVerified),
//                 ],
//               ),
//               // SizedBox(height: 16.0),
//               // SwitchListTile(
//               //   title: Text('سفارش فروش؟', style: TextStyle(fontFamily: 'Irs')),
//               //   value: isSellOrder,
//               //   onChanged: isCustomerVerified
//               //       ? (bool value) {
//               //           setState(() {
//               //             isSellOrder = value;
//               //           });
//               //         }
//               //       : null,
//               // ),

//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: isCustomerVerified ? addOrder : null,
//                 child: Text('اضافه کردن سفارش',
//                     style: TextStyle(fontFamily: 'Irs')),
//                 style: ElevatedButton.styleFrom(
//                   shadowColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//       {required TextEditingController controller,
//       required String labelText,
//       bool enabled = true}) {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide.none,
//             ),
//             labelText: labelText,
//             labelStyle: TextStyle(fontFamily: 'Irs', color: Colors.black54),
//           ),
//           enabled: enabled,
//         ),
//       ),
//     );
//   }

//   Widget buildTextFieldWithIcon(
//       {required TextEditingController controller,
//       required String labelText,
//       required IconData icon,
//       required VoidCallback onPressed}) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           labelText: labelText,
//           labelStyle: TextStyle(fontFamily: 'Irs', color: Colors.black54),
//           suffixIcon: IconButton(
//             icon: Icon(icon),
//             onPressed: onPressed,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildRow(List<Widget> children) {
//     return Row(
//       children: children,
//     );
//   }
// }

// Future<List<BuyOrder>> fetchBuyOrders() async {
//   final response = await http
//       .get(Uri.parse('https://test.ht-hermes.com/supplier/read-buy-order.php'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(response.body);
//     return data.map((item) => BuyOrder.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load buy orders');
//   }
// }

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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AddOrderPage extends StatefulWidget {
//   final Function refresh;

//   const AddOrderPage({Key? key, required this.refresh}) : super(key: key);

//   @override
//   _AddOrderPageState createState() => _AddOrderPageState();
// }

// class _AddOrderPageState extends State<AddOrderPage> {
//   final TextEditingController customerIdController = TextEditingController();
//   final TextEditingController feeController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();
//   final TextEditingController thicknessController = TextEditingController();
//   final TextEditingController widthController = TextEditingController();
//   final TextEditingController gradeController = TextEditingController();
//   final TextEditingController howPayController = TextEditingController();
//   final TextEditingController untilPayController = TextEditingController();
//   final TextEditingController economyCode = TextEditingController();
//   final TextEditingController onTax = TextEditingController();
//   final TextEditingController profitonmonth = TextEditingController();
//   final TextEditingController operatorName = TextEditingController();

//   bool isSellOrder = true;
//   bool isCustomerVerified = false;
//   bool showId = true;
//   bool showInfo = false;

//   List<dynamic> products = [];
//   List<dynamic> sizes = [];
//   dynamic selectedProduct;
//   dynamic selectedSize;
//   int selectedQuantity = 1;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse(
//         'https://test.ht-hermes.com/factors/test_product_flutter.php'));
//     print(response.body);
//     if (response.statusCode == 200) {
//       try {
//         final jsonResponse = jsonDecode(response.body);
//         setState(() {
//           products = jsonResponse['products'];
//         });
//       } catch (e) {
//         _showErrorDialog('مشکلی در تجزیه داده محصولات');
//         print('Error parsing products JSON: $e');
//       }
//     } else {
//       _showErrorDialog('مشکلی در دریافت داده محصولات');
//     }
//   }

//   Future<void> fetchSizes(String productId) async {
//     print(productId);
//     final response = await http.get(Uri.parse(
//         'https://test.ht-hermes.com/factors/test_product_flutter.php?product_id=$productId'));
//     if (response.statusCode == 200) {
//       try {
//         final jsonResponse = jsonDecode(response.body);
//         setState(() {
//           sizes = jsonResponse['sizes'];

//           print(sizes);
//           dynamic pert;
//           selectedSize = pert;
//         });
//       } catch (e) {
//         _showErrorDialog('مشکلی در تجزیه داده سایزها');
//         print('Error parsing sizes JSON: $e');
//       }
//     } else {
//       _showErrorDialog('مشکلی در دریافت داده سایزها');
//     }
//   }

//   Future<void> checkCustomerId(String customerId) async {
//     final response = await http.get(Uri.parse(
//         'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data != null && data['id'].toString() == customerId) {
//         _showCustomerDialog(data['responsible_name'], data['company_name'],
//             data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد');
//         setState(() {
//           isCustomerVerified = data['has_open_order'] == 0 ? true : false;
//           showId = data['has_open_order'] == 0 ? false : true;
//           showInfo = data['has_open_order'] == 0 ? true : false;
//         });
//       } else {
//         _showErrorDialog('مشخصات یافت نشد');
//         setState(() {
//           isCustomerVerified = false;
//         });
//       }
//     } else {
//       _showErrorDialog('مشکلی در دریافت داده');
//       setState(() {
//         isCustomerVerified = false;
//       });
//     }
//   }

//   void _showCustomerDialog(
//       String customerName, String companyName, String hasOpenOrder) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('! مشخصات یافت شد', style: TextStyle(fontFamily: 'Irs')),
//           content: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Container(
//               height: 100,
//               child: Column(
//                 children: [
//                   Text('نام مشتری: $customerName',
//                       style: TextStyle(fontFamily: 'Irs')),
//                   Text('نام کمپانی : $companyName',
//                       style: TextStyle(fontFamily: 'Irs')),
//                   Text('سفارش باز : $hasOpenOrder')
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('تایید'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('! خطا '),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('تایید'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> addOrder() async {
//     final response = await http.post(
//       Uri.parse('https://test.ht-hermes.com/orders/add-order.php'),
//       body: jsonEncode({
//         'customer_id': customerIdController.text,
//         'product': selectedProduct['name'],
//         'fee': feeController.text,
//         'weight': weightController.text,
//         'branch': selectedQuantity.toString(),
//         'thickness': thicknessController.text,
//         'width': widthController.text,
//         'size': selectedSize['size'],
//         'grade': gradeController.text,
//         'how_pay': howPayController.text,
//         'until_pay': untilPayController.text,
//         "economic_code": economyCode.text,
//         "ontax": onTax.text,
//         "profit_month": profitonmonth.text,
//         "operator_name": operatorName.text,
//         'order_date': DateTime.now().toIso8601String(),
//       }),
//     );

//     if (response.statusCode == 201) {
//       widget.refresh();
//       Navigator.of(context).pop(true);
//     } else {
//       _showErrorDialog('مشکلی در ثبت سفارش');
//     }
//   }

//   void checkQuantityAndAddOrder() {
//     if (selectedSize != null && selectedQuantity <= selectedSize['quantity']) {
//       addOrder();
//     } else {
//       _showErrorDialog('موجودی کافی نیست');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 226, 219, 219),
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('ثبت سفارش',
//             style: TextStyle(fontFamily: 'Irs', color: Colors.white)),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: ListView(
//             children: [
//               Visibility(
//                 visible: showId,
//                 child: buildTextFieldWithIcon(
//                   controller: customerIdController,
//                   labelText: 'آیدی مشتری / فروشنده',
//                   icon: Icons.check,
//                   onPressed: () {
//                     checkCustomerId(customerIdController.text);
//                   },
//                 ),
//               ),
//               Visibility(visible: showInfo, child: Text('data')),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildDropdown(
//                   value: selectedProduct,
//                   items: products,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedProduct = value;
//                       fetchSizes(value['id'].toString());
//                     });
//                   },
//                   hint: 'نام محصول',
//                 ),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                   controller: feeController,
//                   labelText: 'فی',
//                   enabled: isCustomerVerified,
//                 ),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                   controller: weightController,
//                   labelText: 'وزن',
//                   enabled: isCustomerVerified,
//                 ),
//                 SizedBox(width: 16.0),
//                 buildDropdown(
//                   value: selectedSize,
//                   items: sizes,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedSize = value;
//                     });
//                   },
//                   hint: 'سایز / ویژگی',
//                 ),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                   controller: thicknessController,
//                   labelText: 'ضخامت',
//                   enabled: isCustomerVerified,
//                 ),
//                 SizedBox(width: 16.0),
//                 buildQuantityDropdown(),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                   controller: widthController,
//                   labelText: 'عرض',
//                   enabled: isCustomerVerified,
//                 ),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                   controller: gradeController,
//                   labelText: 'نوع',
//                   enabled: isCustomerVerified,
//                 ),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                   controller: howPayController,
//                   labelText: 'چطور پرداخت کنیم',
//                   enabled: isCustomerVerified,
//                 ),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                   controller: untilPayController,
//                   labelText: 'تا چه مدت پرداخت کنیم',
//                   enabled: isCustomerVerified,
//                 ),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                   controller: economyCode,
//                   labelText: 'کد اقتصادی',
//                   enabled: isCustomerVerified,
//                 ),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                   controller: onTax,
//                   labelText: 'در مالیات',
//                   enabled: isCustomerVerified,
//                 ),
//               ]),
//               SizedBox(height: 16.0),
//               buildRow([
//                 buildTextField(
//                   controller: profitonmonth,
//                   labelText: 'میزان سود در ماه',
//                   enabled: isCustomerVerified,
//                 ),
//                 SizedBox(width: 16.0),
//                 buildTextField(
//                   controller: operatorName,
//                   labelText: 'نام اپراتور',
//                   enabled: isCustomerVerified,
//                 ),
//               ]),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: isCustomerVerified ? checkQuantityAndAddOrder : null,
//                 child: Text('ثبت سفارش',
//                     style: TextStyle(fontFamily: 'Irs', color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildRow(List<Widget> children) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: children,
//     );
//   }

//   Widget buildTextField({
//     required TextEditingController controller,
//     required String labelText,
//     bool enabled = true,
//   }) {
//     return Expanded(
//       child: TextField(
//         controller: controller,
//         enabled: enabled,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget buildTextFieldWithIcon({
//     required TextEditingController controller,
//     required String labelText,
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return Expanded(
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: labelText,
//           suffixIcon: IconButton(
//             icon: Icon(icon),
//             onPressed: onPressed,
//           ),
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget buildDropdown({
//     required dynamic value,
//     required List<dynamic> items,
//     required Function(dynamic) onChanged,
//     required String hint,
//   }) {
//     return Expanded(
//       child: DropdownButtonFormField<dynamic>(
//         value: value,
//         items: items.map<DropdownMenuItem<dynamic>>((dynamic item) {
//           return DropdownMenuItem<dynamic>(
//             value: item,
//             child: Text(item['name']),
//           );
//         }).toList(),
//         onChanged: (dynamic value) {
//           onChanged(value);
//         },
//         decoration: InputDecoration(
//           labelText: hint,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget buildQuantityDropdown() {
//     List<int> quantities = List.generate(10, (index) => index + 1);

//     return Expanded(
//       child: DropdownButtonFormField<int>(
//         value: selectedQuantity,
//         items: quantities.map<DropdownMenuItem<int>>((int quantity) {
//           return DropdownMenuItem<int>(
//             value: quantity,
//             child: Text('$quantity'),
//           );
//         }).toList(),
//         onChanged: (int? value) {
//           setState(() {
//             selectedQuantity = value!;
//           });
//         },
//         decoration: InputDecoration(
//           labelText: 'تعداد',
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  List<dynamic> products = [];
  List<dynamic> sizes = [];
  dynamic selectedProduct;
  dynamic selectedSize;
  int quantity = 1; // Default quantity is 1

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/factors/test_product_flutter.php'));

    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body)['products'];
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchSizes(String productId) async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/factors/test_product_flutter.php?product_id=$productId'));

    if (response.statusCode == 200) {
      setState(() {
        sizes = jsonDecode(response.body)['sizes'];
      });
    } else {
      throw Exception('Failed to load sizes');
    }
  }

  void checkInventoryAndPlaceOrder() {
    if (selectedSize != null) {
      int availableQuantity = sizes
          .firstWhere((size) => size['id'] == selectedSize['id'])['quantity'];

      if (quantity <= availableQuantity) {
        // Place order logic here
        print('Selected Product: ${selectedProduct['name']}');
        print('Selected Size: ${selectedSize['size']}');
        print('Selected Quantity: $quantity');
      } else {
        // Show dialog for insufficient inventory
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Insufficient Inventory'),
              content: const Text('We do not have enough quantity in stock.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Show dialog to select size
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Size'),
            content: const Text('Please select a size.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Form'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<dynamic>(
              hint: const Text('Select a product'),
              value: selectedProduct,
              onChanged: (dynamic value) {
                setState(() {
                  String? pert;
                  selectedSize = pert;
                  selectedProduct = value;
                  fetchSizes(value['id'].toString());
                });
              },
              items: products.map<DropdownMenuItem<dynamic>>((dynamic product) {
                return DropdownMenuItem<dynamic>(
                  value: product,
                  child: Text(product['name']),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<dynamic>(
              hint: const Text('Select a size'),
              value: selectedSize,
              onChanged: (dynamic value) {
                setState(() {
                  selectedSize = value;
                });
              },
              items: sizes.map<DropdownMenuItem<dynamic>>((dynamic size) {
                return DropdownMenuItem<dynamic>(
                  value: size,
                  child: Text(size['size']),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Quantity: '),
                const SizedBox(width: 10),
                Flexible(
                  child: TextFormField(
                    initialValue: '1',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        quantity = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                checkInventoryAndPlaceOrder();
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
