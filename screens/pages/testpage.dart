// import 'dart:convert';
// import 'package:csv/csv.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:steelpanel/api/req/confirmed-customers-create.dart';
// import 'package:steelpanel/api/req/delete-confirmed-customers.dart';
// import 'package:steelpanel/api/req/make-confirmed.dart';
// import 'package:steelpanel/models/confirmed-customers-model-create.dart';
// import 'package:steelpanel/models/read-buy-order-model.dart';
// import 'package:steelpanel/models/read-order-model.dart';
// import 'package:steelpanel/screens/homescreen.dart';
// import 'package:steelpanel/screens/pages/customers_controller.dart';
// import 'package:steelpanel/api/req/delete-customer.dart';
// import 'package:steelpanel/screens/pages/orders.dart';
// import 'package:steelpanel/widgets/bottombutton.dart';
// import 'package:steelpanel/widgets/newuser_textfield.dart';
// import 'package:universal_html/html.dart' as html;
// import 'package:persian_tools/persian_tools.dart';
// import 'package:toggle_switch/toggle_switch.dart';

// final CustomersController controller = Get.put(CustomersController());
// final String url = 'https://test.ht-hermes.com/supplier/read-buy-order.php';
// final String confirmedUrl = 'https://test.ht-hermes.com/orders/read-order.php';

// Future<List<BuyOrder>> fetchBuyOrders() async {
//   var response = await http.post(Uri.parse(url));
//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(response.body);
//     return data.map((item) => BuyOrder.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load buy orders');
//   }
// }

// Future<List<SellOrder>> fetchSellOrders() async {
//   var response = await http.get(Uri.parse(confirmedUrl));
//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(response.body);
//     return data.map((item) => SellOrder.fromJson(item)).toList();
//   } else {
//     throw Exception('Failed to load sell orders');
//   }
// }

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   static TextEditingController incname = TextEditingController();
//   static TextEditingController manager_name = TextEditingController();
//   static TextEditingController eghtsadi_code = TextEditingController();
//   static TextEditingController shenase_code = TextEditingController();
//   static TextEditingController tellnumber = TextEditingController();
//   static TextEditingController postal_code = TextEditingController();
//   static TextEditingController addrress = TextEditingController();
//   static TextEditingController sabt_code = TextEditingController();
//   static TextEditingController operator_name = TextEditingController();

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage>
//     with SingleTickerProviderStateMixin {
//   double screenWidth = 0;
//   double screenHeight = 0;

//   late TabController _tabController;
//   List<int> cusid = [];

//   @override
//   void didChangeDependencies() {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 2);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   final CustomersController controller = Get.put(CustomersController());
//   final RxSet<Map<String, String>> selectedCustomers =
//       <Map<String, String>>{}.obs;
//   List<int> ids = [];
//   bool premiumCustomer = true;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           backgroundColor: const Color.fromARGB(255, 226, 219, 219),
//           appBar: AppBar(
//             leading: IconButton(
//               iconSize: 25,
//               color: Colors.white,
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const HomePage(),
//                   ),
//                   (route) => false,
//                 );
//               },
//               icon: const Icon(Icons.home),
//             ),
//             title: const Text(
//               'مدیریت مشتریان',
//               style: TextStyle(fontFamily: 'Byekan', color: Colors.white),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.blueAccent,
//             bottom: TabBar(
//               controller: _tabController,
//               labelStyle: const TextStyle(
//                 fontFamily: 'Byekan',
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               tabs: const [
//                 Tab(text: 'در انتظار'),
//                 Tab(text: 'تأیید شده'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             controller: _tabController,
//             children: [
//               FutureBuilder<void>(
//                 future: fetchSellOrders(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return const Center(child: Text('خطا در بارگذاری داده‌ها'));
//                   } else {
//                     return buildPendingTab();
//                   }
//                 },
//               ),
//               FutureBuilder<void>(
//                 future: fetchBuyOrders().then((value) => ids.clear()),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return const Center(child: Text('خطا در بارگذاری داده‌ها'));
//                   } else {
//                     ids.clear();
//                     return buildConfirmedTab();
//                   }
//                 },
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               _tabController.animateTo((_tabController.index + 1) % 2);
//             },
//             child: const Icon(Icons.swap_horiz),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPendingTab() {
//     return Column(
//       children: [
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: IconButton(
//                 onPressed: () {
//                   Get.defaultDialog(
//                     barrierDismissible: true,
//                     backgroundColor: Colors.white,
//                     title: 'ثبت مشتری جدید',
//                     titleStyle: const TextStyle(fontFamily: 'BYekan'),
//                     content: const Center(child: MyTextFieldnu()),
//                     onCancel: () {},
//                     textCancel: 'انصراف',
//                     onConfirm: () async {
//                       Map<String, String> formDatasend = {};
//                       await _submitForm(formDatasend);

//                       Navigator.of(context).pop();
//                       setState(() {});
//                     },
//                     textConfirm: 'ثبت',
//                     buttonColor: Colors.blueAccent,
//                     cancelTextColor: Colors.blueAccent,
//                     confirmTextColor: Colors.white,
//                   );
//                 },
//                 icon: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           const BoxShadow(
//                               color: Colors.black, offset: Offset.infinite),
//                         ],
//                         borderRadius: BorderRadius.circular(8)),
//                     child: const Icon(Icons.add, size: 30)),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: GetBuilder<CustomersController>(
//             builder: (controller) {
//               return controller.jsonData.isNotEmpty
//                   ? Obx(
//                       () => Wrap(
//                         verticalDirection: VerticalDirection.down,
//                         children: [
//                           Container(
//                             width: screenWidth,
//                             height: 20,
//                             color: Colors.grey,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 3,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(right: 25.0),
//                                     child: Container(
//                                         alignment: Alignment.center,
//                                         child: const Text('نام مسئول')),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 15,
//                                 ),
//                                 Expanded(
//                                     flex: 3,
//                                     child: Container(
//                                         color: Colors.red,
//                                         alignment: Alignment.center,
//                                         child: const Text('نام شرکت'))),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                         alignment: Alignment.center,
//                                         color: Colors.amber,
//                                         child: const Text('شماره اقتصادی'))),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                         color: Colors.purple,
//                                         alignment: Alignment.center,
//                                         child: const Text('شماره ملی'))),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                         alignment: Alignment.center,
//                                         color: Colors.green,
//                                         child: const Text('شماره تلفن')))
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Container(
//                               width: screenWidth,
//                               height: screenHeight,
//                               child: ListView.builder(
//                                 padding: const EdgeInsets.all(5),
//                                 itemCount: controller.jsonData.length,
//                                 itemBuilder: (context, index) {
//                                   final customerData = Map<String, String>.from(
//                                       controller.jsonData[index]);

//                                   return GestureDetector(
//                                     onTap: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text('جزئیات مشتری'),
//                                             content: SingleChildScrollView(
//                                               child: ListBody(
//                                                 children: customerData.entries
//                                                     .map((entry) => Text(
//                                                         '${entry.key}: ${entry.value}'))
//                                                     .toList(),
//                                               ),
//                                             ),
//                                             actions: <Widget>[
//                                               TextButton(
//                                                 child: const Text('بستن'),
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 5.0),
//                                       child: Container(
//                                         width: screenWidth,
//                                         height: 70,
//                                         color: Colors.white,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Expanded(
//                                               flex: 3,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 25.0),
//                                                 child: Row(
//                                                   // mainAxisAlignment:
//                                                   //     MainAxisAlignment.spaceAround,
//                                                   children: [
//                                                     Container(
//                                                       // color: Colors.red,
//                                                       child: Obx(
//                                                         () => Checkbox(
//                                                           value: selectedCustomers
//                                                               .contains(
//                                                                   customerData),
//                                                           onChanged:
//                                                               (bool? value) {
//                                                             if (value == true) {
//                                                               selectedCustomers.add(
//                                                                   customerData);
//                                                               if (customerData
//                                                                   .containsKey(
//                                                                       'id')) {
//                                                                 int? id = int.tryParse(
//                                                                     customerData[
//                                                                             'id'] ??
//                                                                         '');
//                                                                 if (id !=
//                                                                         null &&
//                                                                     !ids.contains(
//                                                                         id)) {
//                                                                   ids.add(id);
//                                                                 }
//                                                               }
//                                                               print(
//                                                                   selectedCustomers);
//                                                               print(ids);
//                                                             } else {
//                                                               selectedCustomers
//                                                                   .remove(
//                                                                       customerData);
//                                                               if (customerData
//                                                                   .containsKey(
//                                                                       'id')) {
//                                                                 int? id = int.tryParse(
//                                                                     customerData[
//                                                                             'id'] ??
//                                                                         '');
//                                                                 if (id !=
//                                                                     null) {
//                                                                   ids.remove(
//                                                                       id);
//                                                                 }
//                                                               }
//                                                               print(
//                                                                   selectedCustomers);
//                                                               print(ids);
//                                                             }
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       child: Container(
//                                                         // color: Colors.orange,
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Text(
//                                                           customerData[
//                                                               'responsible_name']!,
//                                                           style: const TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 3,
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                     'از  ${customerData['company_name']}'),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 child: Text(convertEnToFa(
//                                                     '${customerData['economic_code']}')),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 child: Text(convertEnToFa(
//                                                     '${customerData['national_id']}')),
//                                               ),
//                                             ),
//                                             Expanded(
//                                                 flex: 2,
//                                                 child: Container(
//                                                   alignment: Alignment.center,
//                                                   child: Text(convertEnToFa(
//                                                       '${customerData['phone_number']}')),
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : Container(
//                       width: screenWidth * .7,
//                       height: screenHeight * .8,
//                       child: Image.asset('assets/images/noresult.png'),
//                     );
//             },
//           ),
//         ),
//         if (controller.jsonData.isNotEmpty)
//           Center(
//             child: Container(
//               color: Colors.blueAccent,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   bottombutton(
//                     onpress: () {
//                       cusid.clear();
//                       cusid.addAll(ids);
//                       print('this is cusid $cusid');
//                       Get.defaultDialog(
//                           backgroundColor:
//                               const Color.fromARGB(255, 226, 219, 219),
//                           title: 'تایید شود ؟',
//                           titleStyle: const TextStyle(
//                               fontFamily: 'Irs',
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600),
//                           content: Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Container(
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           child: const Text(
//                                             'کاربر ویژه',
//                                             style: TextStyle(
//                                               fontFamily: 'Irs',
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                         ),
//                                         Directionality(
//                                           textDirection: TextDirection.ltr,
//                                           child: Container(
//                                             // width: 150,
//                                             height: 30,
//                                             child: ToggleSwitch(
//                                               activeBgColor: [Colors.white],
//                                               initialLabelIndex: 0,
//                                               totalSwitches: 2,
//                                               customTextStyles: [
//                                                 const TextStyle(
//                                                     color: Colors.black)
//                                               ],
//                                               labels: [
//                                                 'خیر',
//                                                 'بله',
//                                               ],
//                                               onToggle: (index) {
//                                                 print('switched to: $index');
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 25,
//                                   ),
//                                   Container(
//                                     width: 180,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           child: OutlinedButton(
//                                               style: const ButtonStyle(
//                                                   backgroundColor:
//                                                       MaterialStatePropertyAll<
//                                                           Color>(Colors.white)),
//                                               onPressed: () {
//                                                 print('this is $cusid');
//                                                 transferCustomers(cusid);
//                                                 Navigator.of(context).pop();
//                                                 setState(() {});
//                                               },
//                                               child: const Text(
//                                                 'تایید',
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontFamily: 'Irs',
//                                                   fontSize: 15,
//                                                 ),
//                                               )),
//                                         ),
//                                         Expanded(
//                                           child: OutlinedButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text(
//                                                 'لغو',
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontFamily: 'Irs',
//                                                   fontSize: 15,
//                                                 ),
//                                               )),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ));
//                       setState(() {
//                         // final toRemove = <Map<String, String>>[];
//                         // for (var customer in selectedCustomers) {
//                         //   controller.updateCustomerList(customer);
//                         //   toRemove.add(customer);
//                         // }
//                         // controller.jsonData.removeWhere(
//                         //   (customer) => toRemove.contains(customer),
//                         // );
//                         // selectedCustomers.clear();
//                       });
//                     },
//                     txt: const Text(
//                       'ثبت مشتری',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                   bottombutton(
//                     onpress: () {
//                       print(selectedCustomers);
//                       deleteCustomers(ids);
//                       selectedCustomers.clear();
//                       setState(() {});
//                     },
//                     txt: const Text('پاک کردن'),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         else
//           const Text('رکوردی یافت نشد'),
//       ],
//     );
//   }

//   Widget buildConfirmedTab() {
//     return

//         // GetBuilder<CustomersController>(
//         //   builder: (controller) {
//         //     return controller.confirmedCustomers.isNotEmpty
//         // ?

//         Obx(() {
//       if (controller.confirmedCustomers.isEmpty) {
//         return const Center(child: Text('هیچ مشتری تأیید شده‌ای وجود ندارد.'));
//       } else {
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 40,
//                 color: Colors.blue,
//                 child: Row(
//                   children: [
//                     Expanded(
//                         flex: 3,
//                         child: Container(
//                             alignment: Alignment.center,
//                             child: const Text('نام مشتری'))),
//                     Expanded(
//                         flex: 12,
//                         child: Container(
//                             alignment: Alignment.center,
//                             child: const Text('شناسه'))),
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child: const Text('عملیات'))),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: controller.confirmedCustomers.length,
//                 itemBuilder: (context, index) {
//                   final customerData = controller.confirmedCustomers[index];
//                   return Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: ListTile(
//                         tileColor: Colors.white,
//                         title: Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             customerData['economic_code']!,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         leading: Container(
//                           width: screenWidth * 0.1,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: IconButton(
//                                     onPressed: () {},
//                                     icon: const Icon(Icons.edit)),
//                               ),
//                               Expanded(
//                                 child: IconButton(
//                                     onPressed: () {
//                                       print('object');
//                                       print('in index : $index');
//                                       print(customerData['id']);
//                                       List<int> idc = [];
//                                       idc.add(customerData['id']);
//                                       deleteConfirmCustomers(idc);
//                                       setState(() {});
//                                     },
//                                     icon: const Icon(Icons.delete_forever)),
//                               ),
//                               Expanded(
//                                 child: IconButton(
//                                   onPressed: () {
//                                     _exportToExcel(customerData);
//                                   },
//                                   icon: const Icon(Icons.output),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         subtitle: Container(
//                           alignment: Alignment.center,
//                           child: Text(customerData['national_id']!),
//                         ),
//                         trailing: Container(
//                           // color: Colors.red,
//                           alignment: Alignment.centerRight,
//                           width: screenWidth * 0.2,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Expanded(
//                                   child: Container(
//                                       // color: Colors.red,
//                                       child: Text(
//                                           '${customerData['company_name']!}  '))),
//                               Expanded(
//                                   child: Container(
//                                       // color: Colors.blue,
//                                       child: Text(
//                                           ' از ${customerData['responsible_name']!}'))),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   child: CircleAvatar(
//                                     child:
//                                         Text(customerData['company_name']![0]),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }
//     });
//     // : Container(
//     //     width: screenWidth * .7,
//     //     height: screenHeight * .8,
//     //     child: Image.asset('assets/images/noresult.png'),
//     //   );
//     //   },
//     // );
//   }

//   Future<void> _submitForm(Map<String, String> formDatasend) async {
//     final String url =
//         'http://test.ht-hermes.com/customers/create-newcustomer.php';
//     try {
//       var response = await http.post(
//         Uri.parse(url),
//         body: jsonEncode(formDatasend),
//       );

//       if (response.statusCode == 201) {
//         print('Form submitted successfully');
//         print(jsonDecode(response.body));
//       } else {
//         print('Failed to submit form. Status code: ${response.statusCode}');
//         print(response.body);
//       }
//     } catch (e) {
//       print('Error submitting form: $e');
//     }
//   }

//   // void _submitForm(Map<String, String> formDatasend) async {
//   //   final String url =
//   //       'http://test.ht-hermes.com/customers/create-newcustomer.php';
//   //   try {
//   //     var response = await http.post(
//   //       Uri.parse(url),
//   //       body: jsonEncode(formDatasend),
//   //     );

//   //     if (response.statusCode == 201) {
//   //       print('Form submitted successfully');
//   //       print(jsonDecode(response.body));
//   //     } else {
//   //       print('Failed to submit form. Status code: ${response.statusCode}');
//   //       print(response.body);
//   //     }
//   //   } catch (e) {
//   //     print('Error submitting form: $e');
//   //   }
//   // }

//   void _exportToExcel(Map<String, dynamic> customerData) {
//     final List<List<dynamic>> csvData = [];

//     csvData.add(['پارامتر', 'مقدار']);

//     customerData.forEach((key, value) {
//       csvData.add([key, value.toString()]); // Convert value to string
//     });

//     String csvString = const ListToCsvConverter().convert(csvData);

//     final blob = html.Blob([csvString]);

//     final anchor =
//         html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
//           ..setAttribute('download', 'customer_data.csv');

//     anchor.click();
//   }
// }
