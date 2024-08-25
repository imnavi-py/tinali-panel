// import 'package:flutter/material.dart';
// import 'package:steelpanel/screens/pages/customers.dart';
// import 'package:steelpanel/screens/pages/customers_controller.dart';
// import 'package:steelpanel/screens/pages/orders.dart';
// import 'package:steelpanel/widgets/bottombutton.dart';
// import 'package:steelpanel/widgets/mytextfield.dart';

// class NewOrderTxtfld extends StatefulWidget {
//   const NewOrderTxtfld({super.key});

//   @override
//   State<NewOrderTxtfld> createState() => _NewOrderTxtfldState();
// }

// class _NewOrderTxtfldState extends State<NewOrderTxtfld> {
//   double screenWidth = 0;

//   double screenHeight = 0;

// //baraye yekbar farakhuni shodan
//   @override
//   void didChangeDependencies() {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       height: screenHeight * .7,
//       width: screenWidth * .6,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         print(value);
//                         CustomersController.formData['CompanyName'] = value;
//                       },
//                       controller: Orders.num_order,
//                       hintText: 'شماره سفارش خرید',
//                       type: TextInputType.name,
//                       errorText: 'شماره سفارش را وارد کنید',
//                       prefixicon: Icon(Icons.numbers)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         print(value);
//                         CustomersController.formData['name'] = value;
//                       },
//                       controller: Orders.date_order,
//                       hintText: 'تاریخ سفارش',
//                       type: TextInputType.name,
//                       errorText: 'تاریخ سفارش را وارد کنید',
//                       prefixicon: Icon(Icons.date_range)),
//                 ),
//               )),
//             ],
//           ),

//           //
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shenase'] = value;
//                       },
//                       controller: Orders.supplier,
//                       hintText: 'تامین کننده',
//                       type: TextInputType.name,
//                       errorText: 'تامین کننده را انتخاب کنید',
//                       prefixicon: Icon(Icons.support_outlined)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['eghtesadicode'] = value;
//                       },
//                       controller: Orders.num_eghtesadi,
//                       hintText: 'کد اقتصادی',
//                       type: TextInputType.name,
//                       errorText: 'کد اقتصادی را وارد کنید',
//                       prefixicon: Icon(Icons.money)),
//                 ),
//               )),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['postalcode'] = value;
//                       },
//                       controller: Orders.tax_product,
//                       hintText: 'ارزش افزوده',
//                       type: TextInputType.name,
//                       errorText: 'ارزش افزوده را مشخص کنید',
//                       prefixicon: Icon(Icons.local_post_office_outlined)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['tellnumber'] = value;
//                       },
//                       controller: Orders.product,
//                       hintText: 'محصول',
//                       type: TextInputType.name,
//                       errorText: 'نوع محصول را انتخاب کنید',
//                       prefixicon:
//                           Icon(Icons.production_quantity_limits_rounded)),
//                 ),
//               )),
//             ],
//           ),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['address'] = value;
//                       },
//                       controller: Orders.grade_product,
//                       hintText: 'گرید',
//                       type: TextInputType.name,
//                       errorText: 'گرید را انتخاب کنید',
//                       prefixicon: Icon(Icons.format_align_center_rounded)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['operatorname'] = value;
//                       },
//                       controller: Orders.size_product,
//                       hintText: 'سایز',
//                       type: TextInputType.name,
//                       errorText: 'سایز محصول را انتخاب کنید',
//                       prefixicon: Icon(Icons.height)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shomaresabt'] = value;
//                       },
//                       controller: Orders.weight_product,
//                       hintText: 'وزن',
//                       type: TextInputType.name,
//                       errorText: 'وزن محصول را انتخاب کنید',
//                       prefixicon: Icon(Icons.line_weight)),
//                 ),
//               )),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shomaresabt'] = value;
//                       },
//                       controller: Orders.fee_product,
//                       hintText: 'فی',
//                       type: TextInputType.name,
//                       errorText: 'مقدار فی محصول را انتخاب کنید',
//                       prefixicon: Icon(Icons.price_check_sharp)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shomaresabt'] = value;
//                       },
//                       controller: Orders.howto_pay,
//                       hintText: 'شرایط پرداخت',
//                       type: TextInputType.name,
//                       errorText: ' شرایط پرداخت را انتخاب کنید',
//                       prefixicon: Icon(Icons.payment)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shomaresabt'] = value;
//                       },
//                       controller: Orders.precent_pay,
//                       hintText: 'درصد سود ماهیانه',
//                       type: TextInputType.name,
//                       errorText: 'درصد سود ماهیانه محصول را انتخاب کنید',
//                       prefixicon: Icon(Icons.percent)),
//                 ),
//               )),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shomaresabt'] = value;
//                       },
//                       controller: Orders.until_pay,
//                       hintText: 'مدت زمان پرداخت',
//                       type: TextInputType.name,
//                       errorText: 'مدت زمان پرداخت محصول را انتخاب کنید',
//                       prefixicon: Icon(Icons.timelapse_sharp)),
//                 ),
//               )),
//               Expanded(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,
//                   child: myTextField(
//                       onchanged: (value) {
//                         CustomersController.formData['shomaresabt'] = value;
//                       },
//                       controller: Orders.operator_name,
//                       hintText: 'نام اپراتور',
//                       type: TextInputType.name,
//                       errorText: 'نام اپراتور را انتخاب کنید',
//                       prefixicon: Icon(Icons.person)),
//                 ),
//               )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
