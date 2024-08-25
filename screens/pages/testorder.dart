// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:searchbar_animation/searchbar_animation.dart';
// import 'package:steelpanel/screens/homescreen.dart';
// import 'package:steelpanel/utils/dialog_functions.dart';
// import 'package:steelpanel/utils/tilewidget.dart';
// import 'package:steelpanel/widgets/neworder_textfield.dart';

// class Orders extends StatefulWidget {
//   const Orders({super.key});
//   static TextEditingController num_order = TextEditingController();
//   static TextEditingController date_order = TextEditingController();
//   static TextEditingController supplier = TextEditingController();
//   static TextEditingController num_eghtesadi = TextEditingController();
//   static TextEditingController tax_product = TextEditingController();
//   static TextEditingController product = TextEditingController();
//   static TextEditingController grade_product = TextEditingController();
//   static TextEditingController size_product = TextEditingController();
//   static TextEditingController weight_product = TextEditingController();
//   static TextEditingController fee_product = TextEditingController();
//   static TextEditingController howto_pay = TextEditingController();
//   static TextEditingController until_pay = TextEditingController();
//   static TextEditingController precent_pay = TextEditingController();
//   static TextEditingController operator_name = TextEditingController();

//   static final String jsonData = '''
// [{"شماره سفارش خرید":"112","تاریخ سفارش":"1/1/1403","تامین کننده":"هرمس استیل","کد اقتصادی":"eght123456","ارزش افزوده":"9%","محصول":"تسمه_فولاد","گرید":"7176","سایز":"100x8","وزن":"تن10","فی":"140ht","شرایط پرداخت":"نقدی","مدت زمان پرداخت":"6ماه","درصد سود ماهانه":"4درصد","اپراتور":"آقای ایکس","نوع سفارش":"فروش"}]  ''';

//   static List<dynamic> customers = json.decode(jsonData);
//   @override
//   State<Orders> createState() => _OrdersState();
// }

// class _OrdersState extends State<Orders> {
//   int orders = 1;
// //   final String jsonData = '''
// // [{"شماره سفارش خرید":"112","تاریخ سفارش":"1/1/1403","تامین کننده":"هرمس استیل","کد اقتصادی":"eght123456","ارزش افزوده":"9%","محصول":"تسمه_فولاد","گرید":"7176","سایز":"100x8","وزن":"تن10","فی":"140ht","شرایط پرداخت":"نقدی","مدت زمان پرداخت":"6ماه","درصد سود ماهانه":"4درصد","اپراتور":"آقای ایکس"}]  ''';
//   double screenWidth = 0;

//   double screenHeight = 0;

// //baraye yekbar farakhuni shodan
//   @override
//   void didChangeDependencies() {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     super.didChangeDependencies();
//   }

//   final TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 226, 219, 219),
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const HomePage(),
//                   ),
//                   (route) => false);
//             },
//           ),
//         ],
//         backgroundColor: Colors.blueAccent,
//         title: Text(
//           'سفارشات',
//           style: TextStyle(color: Colors.white, fontFamily: 'BYekan'),
//         ),
//         centerTitle: true,
//       ),
//       floatingActionButton: fabWidget(),
//       body: Container(
//         // color: Colors.red,
//         width: double.infinity,
//         height: 500,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             headerWidget(),
//             // felan list is empty?
//             // Container(
//             //   child: Image.asset('assets/images/no_orders.png'),
//             // ),
//             // :
//             Container(
//               width: double.infinity,
//               height: 400,
//               child: ListView.builder(
//                 itemCount: Orders.customers.length,
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> customer = Orders.customers[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25)),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'محصول',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     'تاریخ سفارش',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     'گرید',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     'سایز',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     'وزن',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     'شرایط پرداخت',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Expanded(
//                                     child: Text(
//                                   'مدت زمان پرداخت',
//                                   textAlign: TextAlign.center,
//                                 )),
//                                 Expanded(
//                                     child: Text(
//                                   'نوع سفارش',
//                                   textAlign: TextAlign.center,
//                                 ))
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: Colors.white),
//                             child:
//                                 // ListTile(

//                                 //   // tileColor: Colors.white,
//                                 //   title: Text(customer['name']),
//                                 //   subtitle: Text(customer['eghtesadicode']),
//                                 //   // Add other fields here if needed
//                                 // ),
//                                 Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Get.defaultDialog(
//                                       backgroundColor: Colors.white,
//                                       title: 'سفارش شماره1',
//                                       titleStyle:
//                                           TextStyle(fontFamily: 'BYekan'),
//                                       middleText:
//                                           'چه فرایندی روی این سفارش انجام شود؟',
//                                       middleTextStyle:
//                                           TextStyle(fontFamily: 'BYekan'),
//                                       cancel: OutlinedButton(
//                                           style: ButtonStyle(
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll<
//                                                           Color>(
//                                                       Colors.blueAccent)),
//                                           onPressed: () {},
//                                           child: Text(
//                                             'در انتظار تامین',
//                                             style: TextStyle(
//                                                 fontFamily: 'BYekan',
//                                                 color: Colors.white),
//                                           )),
//                                       confirm: OutlinedButton(
//                                           style: ButtonStyle(
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll<
//                                                       Color>(Colors.green)),
//                                           onPressed: () {},
//                                           child: Text('ثبت فاکتور',
//                                               style: TextStyle(
//                                                   fontFamily: 'BYekan',
//                                                   color: Colors.white))));
//                                 },
//                                 onLongPress: () {
//                                   Get.defaultDialog(
//                                       backgroundColor: Colors.white,
//                                       title: 'حذف',
//                                       titleStyle:
//                                           TextStyle(fontFamily: 'BYekan'),
//                                       middleText: 'سفارش پاک شود ؟',
//                                       middleTextStyle:
//                                           TextStyle(fontFamily: 'BYekan'),
//                                       cancel: OutlinedButton(
//                                           style: ButtonStyle(
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll<
//                                                           Color>(
//                                                       Colors.blueAccent)),
//                                           onPressed: () {
//                                             Get.back();
//                                           },
//                                           child: Text(
//                                             'لغو',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'BYekan'),
//                                           )),
//                                       confirm: OutlinedButton(
//                                           style: ButtonStyle(
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll<
//                                                       Color>(Colors.red)),
//                                           onPressed: () {},
//                                           child: Text(
//                                             'پاک شود',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'BYekan'),
//                                           )));
//                                 },
//                                 child: Card(
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           customer['محصول'],
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           customer['تاریخ سفارش'],
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           customer['گرید'],
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           customer['سایز'],
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           customer['وزن'],
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           customer['شرایط پرداخت'],
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       Expanded(
//                                           child: Text(
//                                         customer['مدت زمان پرداخت'],
//                                         textAlign: TextAlign.center,
//                                       )),
//                                       Expanded(
//                                           child: Text(
//                                         customer['نوع سفارش'],
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             // color:
//                                             //     customer['نوع سفارش'] == 'خرید'
//                                             //         ? Colors.red
//                                             //         : Colors.green,
//                                             fontFamily: 'BYekan'),
//                                       ))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget fabWidget() {
//     return FloatingActionButton(
//       // backgroundColor: kPurpleColor,
//       // backgroundColor: Colors.red,
//       backgroundColor: Colors.blue.shade900,
//       splashColor: Colors.amber,
//       focusColor: Colors.amber,
//       hoverColor: Colors.red,
//       foregroundColor: Colors.white,

//       elevation: 0,
//       onPressed: () {
//         Get.defaultDialog(
//             backgroundColor: Colors.white,
//             title: 'ثبت سفارش',
//             titleStyle: TextStyle(fontFamily: 'BYekan'),
//             content: NewOrderTxtfld(),
//             confirm: ElevatedButton(
//               onPressed: () {
//                 DialogFuncs.sellorder = true;
//                 DialogFuncs.buysell = 'فروش';
//                 final Map<String, dynamic> newdata = {
//                   "شماره سفارش خرید": "${Orders.num_order.text}",
//                   "تاریخ سفارش": "${Orders.date_order.text}",
//                   "تامین کننده": "${Orders.supplier.text}",
//                   "کد اقتصادی": "${Orders.num_eghtesadi.text}",
//                   "ارزش افزوده": "${Orders.tax_product.text}",
//                   "محصول": "${Orders.product.text}",
//                   "گرید": "${Orders.grade_product.text}",
//                   "سایز": "${Orders.size_product.text}",
//                   "وزن": "${Orders.weight_product.text}",
//                   "فی": "${Orders.fee_product.text}",
//                   "شرایط پرداخت": "${Orders.howto_pay.text}",
//                   "درصد سود ماهیانه": "${Orders.precent_pay.text}",
//                   "مدت زمان پرداخت": "${Orders.until_pay.text}",
//                   "اپراتور": "${Orders.operator_name.text}",
//                   "نوع سفارش": "${DialogFuncs.buysell}",
//                 };

//                 Orders.customers.add(newdata);
//                 orders + 1;

//                 // Update the state to trigger UI rebuild
//                 setState(() {});
//                 Orders.num_order.clear();
//                 Orders.date_order.clear();
//                 Orders.supplier.clear();
//                 Orders.num_eghtesadi.clear();
//                 Orders.tax_product.clear();
//                 Orders.product.clear();
//                 Orders.grade_product.clear();
//                 Orders.size_product.clear();
//                 Orders.weight_product.clear();
//                 Orders.fee_product.clear();
//                 Orders.howto_pay.clear();
//                 Orders.precent_pay.clear();
//                 Orders.until_pay.clear();
//                 Orders.operator_name.clear();
//                 Get.back();
//               },
//               child: Text(
//                 'ثبت سفارش فروش',
//                 style: TextStyle(fontFamily: 'BYekan', color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStatePropertyAll<Color>(Colors.green)),
//             ),
//             cancel: ElevatedButton(
//               onPressed: () {
//                 DialogFuncs.buysell = 'خرید';
//                 DialogFuncs.sellorder = false;
//                 final Map<String, dynamic> newdata = {
//                   "شماره سفارش خرید": "${Orders.num_order.text}",
//                   "تاریخ سفارش": "${Orders.date_order.text}",
//                   "تامین کننده": "${Orders.supplier.text}",
//                   "کد اقتصادی": "${Orders.num_eghtesadi.text}",
//                   "ارزش افزوده": "${Orders.tax_product.text}",
//                   "محصول": "${Orders.product.text}",
//                   "گرید": "${Orders.grade_product.text}",
//                   "سایز": "${Orders.size_product.text}",
//                   "وزن": "${Orders.weight_product.text}",
//                   "فی": "${Orders.fee_product.text}",
//                   "شرایط پرداخت": "${Orders.howto_pay.text}",
//                   "درصد سود ماهیانه": "${Orders.precent_pay.text}",
//                   "مدت زمان پرداخت": "${Orders.until_pay.text}",
//                   "اپراتور": "${Orders.operator_name.text}",
//                   "نوع سفارش": "${DialogFuncs.buysell}",
//                 };
//                 orders + 1;
//                 Orders.customers.add(newdata);
//                 setState(() {});
//                 Orders.num_order.clear();
//                 Orders.date_order.clear();
//                 Orders.supplier.clear();
//                 Orders.num_eghtesadi.clear();
//                 Orders.tax_product.clear();
//                 Orders.product.clear();
//                 Orders.grade_product.clear();
//                 Orders.size_product.clear();
//                 Orders.weight_product.clear();
//                 Orders.fee_product.clear();
//                 Orders.howto_pay.clear();
//                 Orders.precent_pay.clear();
//                 Orders.until_pay.clear();
//                 Orders.operator_name.clear();

//                 Get.back();
//               },
//               child: Text(
//                 'ثبت سفارش خرید',
//                 style: TextStyle(fontFamily: 'BYekan', color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
//             ));

//         // createNewUser.date = 'تاریخ';
//         // createNewUser.descriptionController.text = '';
//         // createNewUser.priceController.text = '';
//         // createNewUser.groupId = 0;
//         // createNewUser.isEditing = false;
//         // createNewUser.emailController.text = '';
//         // createNewUser.numberController.text = '';
//         // createNewUser.serviceController.text = '';
//         // createNewUser.showfield = false;
//         // setState(() {
//         //   createNewUser.createdid = Random().nextInt(99999999);
//         // });
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => const createNewUser(),
//         //   ),
//         // ).then((value) {
//         //   MyApp.getData();
//         //   setState(() {});
//         // });
//       },
//       child: const Icon(Icons.add),
//     );
//   }

//   //! Header Widget
//   Widget headerWidget() {
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 12.0),
//                   child: SearchBarAnimation(
//                     isOriginalAnimation: false,
//                     textEditingController: searchController,
//                     buttonWidget: Icon(
//                       Icons.search,
//                       color: Colors.blue.shade300,
//                     ),
//                     secondaryButtonWidget: const Icon(Icons.close),
//                     trailingWidget: const Icon(Icons.search_rounded),
//                     // hintText:
//                     //     userlvl.FaEn == 1 ? '...جستجو کنید ' : 'Search ...',
//                     // buttonElevation: 0,
//                     // onCollapseComplete: () {
//                     //   MyApp.getData();
//                     //   searchController.text = '';
//                     //   setState(() {});
//                     // },
//                     buttonShadowColour: Colors.black26,
//                     buttonBorderColour: Colors.black26,
//                     onFieldSubmitted: (String text) {
//                       // List<Money> result2 = hiveBox.values.toList();
//                       // int desiredId = int.tryParse(text) ?? -1;
//                       // List<Money> result = hiveBox.values
//                       //     .where((value) =>
//                       //         value.title.contains(text) ||
//                       //         value.id == desiredId)
//                       //     .toList();
//                       // HomeScreen.moneys.clear();
//                       // setState(() {
//                       //   for (var value in result) {
//                       //     HomeScreen.moneys.add(value);
//                       //   }
//                       // });
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const HomePage(),
//                             ),
//                             (route) => false);
//                       },
//                       icon: Icon(Icons.home)),
//                   IconButton(
//                       onPressed: () {
//                         // print(
//                         //     'ineeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${userlvl.chcknumlvl}');
//                         // MyApp.getLvL();
//                         // if (HomeScreen.lvlc.isNotEmpty) {
//                         //   print('lvalue khali nist');

//                         //   // for (var lvalue in lvlBox.values) {
//                         //   //   final textboxview = lvalue;
//                         //   //   print('in textboxview ast : ${textboxview.lvl}');
//                         //   //   CfOff.lvlTxtfield.text =
//                         //   //       textboxview.lvl.toString();
//                         //   // }
//                         //   HomeScreen.lvlc.isNotEmpty
//                         //       ? CfOff.lvlTxtfield.text =
//                         //           HomeScreen.lvlc[0].lvl.toString()
//                         //       : CfOff.lvlTxtfield.text = '';

//                         //   setState(() {});
//                         // }
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => CfOff(),
//                         //   ),
//                         // );
//                       },
//                       icon: const Icon(
//                         Icons.settings,
//                         color: Color(0xFF0D47A1),
//                       )),
//                   Container(
//                     width: 40,
//                     height: 25,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: Colors.blue.shade900,
//                         // const Color.fromRGBO(100, 181, 246, 1),
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Text(
//                       textAlign: TextAlign.center,
//                       orders.toString(),
//                       // usercount.box_lengh.toString(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(right: 12.0),
//                     child: Text(
//                       ' تعداد سفارشات',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontFamily: 'BYekan'),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

// // [{"شماره سفارش خرید":"112","تاریخ سفارش":"1/1/1403","تامین کننده":"هرمس استیل","کد اقتصادی":"eght123456","ارزش افزوده":"9%","محصول":"تسمه_فولاد","گرید":"7176","سایز":"100x8","وزن":"تن10","فی":"140ht","شرایط پرداخت":"نقدی","مدت زمان پرداخت":"6ماه","درصد سود ماهانه":"4درصد","اپراتور":"آقای ایکس"}]
// }
