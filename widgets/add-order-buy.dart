import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/screens/pages/orders.dart';

class AddBuyOrderPage extends StatefulWidget {
  final Function refresh;

  const AddBuyOrderPage({Key? key, required this.refresh}) : super(key: key);

  @override
  _AddBuyOrderPageState createState() => _AddBuyOrderPageState();
}

class _AddBuyOrderPageState extends State<AddBuyOrderPage> {
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
  }

  void refresh() {
    setState(() {});
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

  Future<void> addOrder() async {
    if (selectedSize != null && selectedQuantity <= selectedSize['quantity']) {
      try {
        final response = await http.post(
          Uri.parse('https://test.ht-hermes.com/orders/add-buy-order.php'),
          body: jsonEncode({
            'supplier_id': customerIdController.text,
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
        print(
          jsonEncode({
            'supplier_id': customerIdController.text,
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
          widget.refresh();

          Navigator.of(context).pop(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return OrdersPage(refresh: refresh);
            },
          ));
          _showDialog('سفارش با موفقیت ثبت شد');
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

  bool isSellOrder = true;
  bool isCustomerVerified = false;
  bool showId = true;
  bool showInfo = false;
  Future<void> checkSupplierId(String supplierId) async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/supplier/read-suppliers.php?id=$supplierId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['id'].toString() == supplierId) {
        _showCustomerDialog(data['responsible_name'], data['company_name'],
            data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد');
        setState(() {
          isCustomerVerified = data['has_open_order'] == 0 ? true : false;

          showId = data['has_open_order'] == 0 ? false : true;
          showInfo = data['has_open_order'] == 0 ? true : false;
          customerName = data['responsible_name'];
          companyName = data['company_name'];
        });
      } else {
        _showErrorDialog('مشخصات یافت نشد');
        setState(() {
          isCustomerVerified = false;
        });
      }
    } else {
      _showErrorDialog('مشکلی در دریافت داده');
      setState(() {
        isCustomerVerified = false;
      });
    }
  }

// dialogs customer

  void _showCustomerDialog(
      String customerName, String companyName, String hasOpenOrder) {
    showDialog(
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
                  Text('نام تامین کننده: $customerName',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ثبت سفارش',
            style: TextStyle(fontFamily: 'Irs', color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //////////////////////////////// Verify Customer ////////////////////////////////

              Visibility(
                visible: showId,
                child: TextField(
                  decoration: InputDecoration(
                    // hintText: productController.text.isEmpty
                    //     ? ''
                    //     : productController.text,
                    labelText: 'آیدی مشتری / فروشنده',
                    suffixIcon: IconButton(
                        onPressed: () {
                          checkSupplierId(customerIdController.text);
                        },
                        icon: const Icon(Icons.check)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  // readOnly: true,
                  controller: customerIdController,
                ),
              ),
              Visibility(
                  visible: showInfo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(customerName),
                      Text(companyName),
                    ],
                  )),
              const SizedBox(height: 16.0),

              //////////////////////////////// Select Product ////////////////////////////////
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: isCustomerVerified,
                      decoration: InputDecoration(
                        // hintText: productController.text.isEmpty
                        //     ? ''
                        //     : productController.text,
                        labelText: 'انتخاب محصول',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<dynamic>(
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              value: selectedProduct,
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedSize = null; // Reset selected size
                                  selectedProduct = value;
                                  fetchSizes(value['id'].toString());
                                  print(value);
                                  print(selectedProduct['name'].toString());
                                  // productController.text =
                                  //     selectedProduct!['name'].toString();
                                });
                              },
                              items: products.map<DropdownMenuItem<dynamic>>(
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

                  ///////////////////////////////////// Select Size / Species /////////////////////////////////////

                  Expanded(
                    child: TextField(
                      enabled: isCustomerVerified,
                      decoration: InputDecoration(
                        // hintText: productController.text.isEmpty
                        //     ? ''
                        //     : productController.text,
                        labelText: 'سایز / ویژگی',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<dynamic>(
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
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: isCustomerVerified,
                      decoration: InputDecoration(
                        // hintText: productController.text.isEmpty
                        //     ? ''
                        //     : productController.text,
                        labelText: 'گرید',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<dynamic>(
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              value: selectedGrade,
                              onChanged: (dynamic value) {
                                setState(() {
                                  // selectedSize = null; // Reset selected size
                                  selectedGrade = value;
                                  // fetchSizes(value['id'].toString());
                                  print(value);
                                  // print(selectedProduct['name'].toString());
                                  gradeController.text =
                                      selectedGrade!['name'].toString();
                                });
                              },
                              items: grades.map<DropdownMenuItem<dynamic>>(
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
                      enabled: isCustomerVerified,
                      decoration: InputDecoration(
                        // hintText: productController.text.isEmpty
                        //     ? ''
                        //     : productController.text,
                        labelText: 'وزن',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      controller: weightController,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    enabled: isCustomerVerified,
                    decoration: InputDecoration(
                      // hintText: productController.text.isEmpty
                      //     ? ''
                      //     : productController.text,
                      labelText: 'کد اقتصادی',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    controller: economyCode,
                  )),
                  Expanded(
                      child: TextField(
                    enabled: isCustomerVerified,
                    decoration: InputDecoration(
                      // hintText: productController.text.isEmpty
                      //     ? ''
                      //     : productController.text,
                      labelText: 'ارزش افزوده',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    controller: onTax,
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    enabled: isCustomerVerified,
                    decoration: InputDecoration(
                      // hintText: productController.text.isEmpty
                      //     ? ''
                      //     : productController.text,
                      labelText: 'فی',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    controller: feeController,
                  )),
                  Expanded(
                      child: TextField(
                    enabled: isCustomerVerified,
                    decoration: InputDecoration(
                      // hintText: productController.text.isEmpty
                      //     ? ''
                      //     : productController.text,
                      labelText: 'شرایط پرداخت',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    controller: howPayController,
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    enabled: isCustomerVerified,
                    decoration: InputDecoration(
                      // hintText: productController.text.isEmpty
                      //     ? ''
                      //     : productController.text,
                      labelText: 'مدت زمان پرداخت',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    controller: untilPayController,
                  )),
                  Expanded(
                      child: TextField(
                    enabled: isCustomerVerified,
                    decoration: InputDecoration(
                      // hintText: productController.text.isEmpty
                      //     ? ''
                      //     : productController.text,
                      labelText: 'درصد سود ماهانه',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    controller: profitonmonth,
                  ))
                ],
              ),
              Expanded(
                  child: TextField(
                enabled: isCustomerVerified,
                decoration: InputDecoration(
                  // hintText: productController.text.isEmpty
                  //     ? ''
                  //     : productController.text,
                  labelText: 'اپراتور',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                controller: operatorName,
              ))

              // DropdownButton<dynamic>(
              //   hint: Text('انتخاب محصول'),
              //   value: selectedProduct,
              //   onChanged: (dynamic value) {
              //     setState(() {
              //       selectedSize = null; // Reset selected size
              //       selectedProduct = value;
              //       fetchSizes(value['id'].toString());
              //     });
              //   },
              //   items:
              //       products.map<DropdownMenuItem<dynamic>>((dynamic product) {
              //     return DropdownMenuItem<dynamic>(
              //       value: product,
              //       child: Text(product['name']),
              //     );
              //   }).toList(),
              // ),
              // SizedBox(height: 16.0),
              // DropdownButton<dynamic>(
              //   hint: Text('انتخاب سایز'),
              //   value: selectedSize,
              //   onChanged: (dynamic value) {
              //     setState(() {
              //       selectedSize = value;
              //     });
              //   },
              //   items: sizes.map<DropdownMenuItem<dynamic>>((dynamic size) {
              //     return DropdownMenuItem<dynamic>(
              //       value: size,
              //       child: Text(size['size']),
              //     );
              //   }).toList(),
              // ),
              // SizedBox(height: 16.0),
              ,
              TextField(
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
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: addOrder,
                child: const Text('ثبت سفارش',
                    style: TextStyle(fontFamily: 'Irs', color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
