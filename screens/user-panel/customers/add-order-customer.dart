import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'dart:convert';

import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/screens/pages/orders.dart';

class OrdersCustomers extends StatefulWidget {
  final Function refresh;
  static var customerName;
  static var companyName;

  static bool showId = false;
  static bool showInfo = false;

  static bool isCustomerVerified = false;
  const OrdersCustomers({Key? key, required this.refresh}) : super(key: key);

  @override
  _OrdersCustomersState createState() => _OrdersCustomersState();
}

class _OrdersCustomersState extends State<OrdersCustomers> {
  List<dynamic> products = [];
  List<dynamic> sizes = [];
  List<dynamic> grades = [];
  dynamic selectedProduct;
  dynamic selectedSize;
  dynamic selectedGrade;
  int selectedQuantity = 1;
  String customerName = '';
  String companyName = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchGrades();
    checkCustomerId(UserInfoControll.userTypeId.value);
  }

  void refresh() {
    setState(() {});
  }

  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://test.ht-hermes.com/factors/test_product_flutter.php'));

      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body)['products'];
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> fetchSizes(String productId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://test.ht-hermes.com/factors/test_product_flutter.php?product_id=$productId'));

      if (response.statusCode == 200) {
        setState(() {
          sizes = jsonDecode(response.body)['sizes'];
        });
      } else {
        throw Exception('Failed to load sizes');
      }
    } catch (e) {
      print('Error fetching sizes: $e');
    }
  }

  Future<void> fetchGrades() async {
    try {
      final response = await http
          .get(Uri.parse('${apiService.apiurl}/grade/read-grade.php'));

      if (response.statusCode == 200) {
        setState(() {
          grades = jsonDecode(response.body)['grades'];
        });
        print(grades);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching grades: $e');
    }
  }

  // update user info
  Future<void> updateUser(String orderID) async {
    final String url = '${apiService.apiurl}/users/update_usr_advanced.php';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "user_id": UserInfoControll.user_id.value,
        "order_id": orderID,
        "status": "ثبت اولیه"
      }),
    );

    if (response.statusCode == 200) {
      print('ok update shod');
      print(response.body);
    } else {
      print('Failed to update user data. Status code: ${response.statusCode}');
      print(response.body);
    }
  }

  void _submitedOrder() {
    MotionToast(
      icon: Icons.check,
      primaryColor: Colors.green.shade900!,
      secondaryColor: Colors.grey,
      title: Text('موفقیت'),
      description: Text('سفارش با موفقیت ثبت شد'),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      height: 100,
      width: 300,
    ).show(context);
  }

  Future<void> addOrder() async {
    if (selectedSize != null && selectedQuantity <= selectedSize['quantity']) {
      try {
        final response = await http.post(
          Uri.parse('https://test.ht-hermes.com/orders/add-order.php'),
          body: jsonEncode({
            'customer_id': UserInfoControll.userTypeId.value.toString(),
            'product': selectedProduct['name'].toString(),
            // 'quantity': selectedQuantity.toString(),
            'size': selectedSize['size'].toString(),
            // 'order_date': DateTime.now().toIso8601String(),
            // 'fee': feeController.text,
            'weight': weightController.text + '' + howmuch.text,
            // 'branch': selectedQuantity.toString(),
            // 'thickness': thicknessController.text,
            // 'width': widthController.text,
            // 'size': sizeController.text,
            'grade': gradeController.text,
            'how_pay': howPayController.text,
            'until_pay': untilPayController.text,
            "economic_code": economyCode.text,
            // "ontax": onTax.text,
            // "profit_month": profitonmonth.text,
            "operator_name": 'WebApp',
            "order_progress": 1

            // "ontax": "15%",
            //     "profit_month": "June",
            //       "operator_name": "Operator Name"
          }),
        );
        print(
          jsonEncode({
            'customer_id': customerIdController.text,
            'product': selectedProduct['name'].toString(),
            // 'quantity': selectedQuantity.toString(),
            'size': selectedSize['size'].toString(),
            // 'order_date': DateTime.now().toIso8601String(),
            'fee': feeController.text,
            'weight': weightController.text,
            'branch': selectedQuantity.toString(),
            // 'thickness': thicknessController.text,
            // 'width': widthController.text,
            // 'size': sizeController.text,
            'grade': gradeController.text,
            'how_pay': howPayController.text,
            'until_pay': untilPayController.text,
            "economic_code": economyCode.text,
            "ontax": onTax.text,
            "profit_month": profitonmonth.text,
            "operator_name": operatorName.text,

            // "ontax": "15%",
            //     "profit_month": "June",
            //       "operator_name": "Operator Name"
          }),
        );
        print(customerIdController.text);
        print(selectedProduct['name']);
        print(selectedQuantity.toString());
        print(selectedSize['size']);
        print(DateTime.now().toIso8601String());
        print(feeController.text);
        print(weightController.text);
        print(gradeController.text);
        print(howPayController.text);
        print(untilPayController.text);
        print(economyCode.text);

        print(onTax.text);
        print(profitonmonth.text);
        print(operatorName.text);

        print(response);
        print(response.body);
        if (response.statusCode == 201) {
          // widget.refresh();
          String orderid =
              jsonDecode(response.body)['order_id'].toString() ?? '';
          UserInfoControll.orderId.value = orderid;

          // Navigator.of(context).pop(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              updateUser(UserInfoControll.orderId.value);
              return HomeMain(
                xxcontroller:
                    SidebarXController(selectedIndex: 0, extended: true),
              );
            },
          ));
          _submitedOrder();
          AddtoLogs('سفارشات',
              'کاربر ${UserInfoControll.username}با آیدی :${UserInfoControll.user_id}سفارش ثبت کرد');
        } else {
          print(response.statusCode);
          _showDialog('مشکلی در ثبت سفارش');
        }
      } catch (e) {
        print('Error adding order: $e');
      }
    } else {
      _showDialog('موجودی کافی نیست');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('پیام', style: TextStyle(fontFamily: 'Irs')),
          content: Text(message, style: const TextStyle(fontFamily: 'Irs')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تایید', style: TextStyle(fontFamily: 'Irs')),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  // final TextEditingController branchController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController howPayController = TextEditingController();
  final TextEditingController untilPayController = TextEditingController();

  final TextEditingController economyCode = TextEditingController();
  final TextEditingController onTax = TextEditingController();

  final TextEditingController profitonmonth = TextEditingController();
  final TextEditingController operatorName = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController howmuch = TextEditingController();

  bool howmuchBool = false;

  // bool isSellOrder = true;
  // bool isCustomerVerified = false;
  // bool showId = true;
  // bool showInfo = false;
  bool loading = true;
  Future<void> checkCustomerId(String customerId) async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['id'].toString() == customerId) {
        _showCustomerDialog(
          data['responsible_name'] + data['economic_code'],
          data['company_name'],
          data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد',
        );

        setState(() {
          OrdersCustomers.isCustomerVerified =
              data['has_open_order'] == 0 ? true : false;
          economyCode.text = data['economic_code'];
          OrdersCustomers.showId = data['has_open_order'] == 0 ? false : true;
          OrdersCustomers.showInfo = data['has_open_order'] == 0 ? true : false;
          OrdersCustomers.customerName = data['responsible_name'];
          OrdersCustomers.companyName = data['company_name'];
        });
      } else {
        _showErrorDialog('مشخصات یافت نشد');
        setState(() {
          OrdersCustomers.isCustomerVerified = false;
        });
      }
    } else {
      _showErrorDialog('مشکلی در دریافت داده');
      setState(() {
        OrdersCustomers.isCustomerVerified = false;
      });
    }
  }

// dialogs customer

  // Future<void> checkedId() async {
  //   String customerId = UserInfoControll.user_id.value.toString();
  //   final response = await http.get(Uri.parse(
  //       'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     if (data != null && data['id'].toString() == customerId) {
  //       // _showCustomerDialog(data['responsible_name'], data['company_name'],
  //       //     data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد');
  //       setState(() {
  //         OrdersCustomers.isCustomerVerified =
  //             data['has_open_order'] == 0 ? true : false;

  //         OrdersCustomers.showId = data['has_open_order'] == 0 ? false : true;
  //         OrdersCustomers.showInfo = data['has_open_order'] == 0 ? true : false;
  //         OrdersCustomers.customerName = data['responsible_name'];
  //         OrdersCustomers.companyName = data['company_name'];
  //       });
  //     }
  //   }
  // }

  void _showCustomerDialog(
      String customerName, String companyName, String hasOpenOrder) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '! مشخصات یافت شد',
            style: TextStyle(fontFamily: 'Irs'),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text('نام مشتری: $customerName',
                      style: const TextStyle(fontFamily: 'Irs')),
                  Text('نام کمپانی : $companyName',
                      style: const TextStyle(fontFamily: 'Irs')),
                  Text('سفارش باز : $hasOpenOrder')
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                loading = false;

                setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('! خطا '),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }

// تعریف لیست‌های مربوط به گزینه‌ها برای فیلدهای مختلف
  List<String> paymentConditions = ['نقدی', 'اقساطی'];
  List<String> weights = ['کیلویی', 'شاخه', 'بندیل'];
  List<String> paymentDurations = ['دوازده ماهه', 'شش ماهه'];

  String? selectedPaymentCondition;
  String? selectedWeight;
  String? selectedPaymentDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ثبت سفارش',
            style: TextStyle(fontFamily: 'Irs', color: Colors.white)),
        backgroundColor: const Color(0xFF2E2E48),
      ),
      body: loading == true
          ? Center(
              child: SizedBox(
                // height: 100,
                child: CircularProgressIndicator(),
              ),
            )
          : Center(
              // Center widget added here
              child: Container(
                alignment: Alignment.center,
                width: screenWidth * 0.7,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // alignment: WrapAlignment.center,
                      children: [
                        //////////////////////////////// Verify Customer ////////////////////////////////
                        // Visibility(
                        //   visible: OrdersCustomers.showId,
                        //   child: TextField(
                        //     decoration: InputDecoration(
                        //       labelText: 'آیدی مشتری / فروشنده',
                        //       suffixIcon: IconButton(
                        //           onPressed: () {
                        //             checkCustomerId(customerIdController.text);
                        //           },
                        //           icon: const Icon(Icons.check)),
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           vertical: 10.0, horizontal: 12.0),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide:
                        //             const BorderSide(color: Colors.grey, width: 1.0),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide:
                        //             const BorderSide(color: Colors.grey, width: 1.0),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide:
                        //             const BorderSide(color: Colors.blue, width: 2.0),
                        //       ),
                        //     ),
                        //     controller: customerIdController,
                        //   ),
                        // ),
                        // Visibility(
                        //     visible: OrdersCustomers.showInfo,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: [
                        //         Container(
                        //             alignment: Alignment.center,
                        //             height: screenHeight * 0.04,
                        //             width: screenWidth * 0.3,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(color: Colors.white),
                        //                 borderRadius:
                        //                     BorderRadius.circular(10)),
                        //             child: Text(OrdersCustomers.customerName)),
                        //         Container(
                        //             alignment: Alignment.center,
                        //             height: screenHeight * 0.04,
                        //             width: screenWidth * 0.3,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(color: Colors.white),
                        //                 borderRadius:
                        //                     BorderRadius.circular(10)),
                        //             child: Text(OrdersCustomers.companyName)),
                        //       ],
                        //     )),
                        // const SizedBox(height: 16.0),
                        //////////////////////////////// Select Product ////////////////////////////////
                        Expanded(
                          child: TextField(
                            enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              labelText: 'انتخاب محصول',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<dynamic>(
                                    dropdownColor: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    value: selectedProduct,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        selectedSize =
                                            null; // Reset selected size
                                        selectedProduct = value;
                                        fetchSizes(value['id'].toString());
                                        print(value);
                                        print(
                                            selectedProduct['name'].toString());
                                      });
                                    },
                                    items: products
                                        .map<DropdownMenuItem<dynamic>>(
                                            (dynamic product) {
                                      return DropdownMenuItem<dynamic>(
                                        value: product,
                                        child: Text(product['name']),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            controller: productController,
                          ),
                        ),
                        /////////////////////////////////// Select Size / Species /////////////////////////////////////
                        Expanded(
                          child: TextField(
                            enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              labelText: 'سایز / ویژگی',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<dynamic>(
                                    dropdownColor: Colors.white,
                                    hint: const Text('انتخاب سایز'),
                                    value: selectedSize,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        selectedSize = value;
                                      });
                                    },
                                    items: sizes.map<DropdownMenuItem<dynamic>>(
                                        (dynamic size) {
                                      return DropdownMenuItem<dynamic>(
                                        value: size,
                                        child: Text(size['size']),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            controller: sizeController,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              labelText: 'گرید',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<dynamic>(
                                    dropdownColor: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    value: selectedGrade,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        selectedGrade = value;
                                        gradeController.text =
                                            selectedGrade!['name'].toString();
                                      });
                                    },
                                    items: grades
                                        .map<DropdownMenuItem<dynamic>>(
                                            (dynamic grades) {
                                      return DropdownMenuItem<dynamic>(
                                        value: grades,
                                        child: Text(grades['name']),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            controller: gradeController,
                          ),
                        ),
                        ///////////////////////////////////////////////////
                        Expanded(
                          child: TextField(
                            enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              labelText: 'شرایط پرداخت',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    value: selectedPaymentCondition,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedPaymentCondition = value;
                                        howPayController.text =
                                            selectedPaymentCondition!;
                                      });
                                    },
                                    items: paymentConditions
                                        .map<DropdownMenuItem<String>>(
                                            (String condition) {
                                      return DropdownMenuItem<String>(
                                        value: condition,
                                        child: Text(condition),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            controller: howPayController,
                          ),
                        ),

                        // فیلد "وزن"
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  enabled: OrdersCustomers.isCustomerVerified,
                                  decoration: InputDecoration(
                                    labelText: 'وزن',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 2.0),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor: Colors.white,
                                          icon: const Icon(Icons
                                              .keyboard_arrow_down_rounded),
                                          value: selectedWeight,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedWeight = value;
                                              weightController.text =
                                                  selectedWeight!;
                                              howmuchBool = true;
                                            });
                                          },
                                          items: weights
                                              .map<DropdownMenuItem<String>>(
                                                  (String weight) {
                                            return DropdownMenuItem<String>(
                                              value: weight,
                                              child: Text(weight),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  controller: weightController,
                                ),
                              ),
                              Visibility(
                                  visible: howmuchBool,
                                  child: Expanded(
                                    child: TextField(
                                      enabled:
                                          OrdersCustomers.isCustomerVerified,
                                      decoration: InputDecoration(
                                        labelText: weightController.text ==
                                                'کیلویی'
                                            ? 'مقدار وزن'
                                            : weightController.text == 'بندیل'
                                                ? 'تعداد بندیل'
                                                : weightController.text ==
                                                        'شاخه'
                                                    ? 'تعداد شاخه'
                                                    : 'مقدار',
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 12.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2.0),
                                        ),
                                      ),
                                      controller: howmuch,
                                    ),
                                  ))
                            ],
                          ),
                        ),

                        // فیلد "مدت زمان پرداخت"
                        Expanded(
                          child: TextField(
                            enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              labelText: 'مدت زمان پرداخت',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded),
                                    value: selectedPaymentDuration,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedPaymentDuration = value;
                                        untilPayController.text =
                                            selectedPaymentDuration!;
                                      });
                                    },
                                    items: paymentDurations
                                        .map<DropdownMenuItem<String>>(
                                            (String duration) {
                                      return DropdownMenuItem<String>(
                                        value: duration,
                                        child: Text(duration),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            controller: untilPayController,
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: TextField(
                            controller: branchController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'تعداد',
                              hintText: '1',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              selectedQuantity = int.tryParse(value) ?? 1;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return HomeMain(
                                          xxcontroller: SidebarXController(
                                              selectedIndex: 0,
                                              extended: true));
                                    },
                                  ));
                                },
                                child: const Text('بازگشت')),
                            ElevatedButton(
                              onPressed: addOrder,
                              child: const Text('ثبت سفارش',
                                  style: TextStyle(
                                      fontFamily: 'Irs', color: Colors.blue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
