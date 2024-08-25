import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IndentityPage extends StatefulWidget {
  const IndentityPage({super.key});

  @override
  State<IndentityPage> createState() => _IndentityPageState();
}

class _IndentityPageState extends State<IndentityPage> {
  List<dynamic> products = [];
  List<dynamic> sizes = [];
  List<dynamic> grades = [];
  dynamic selectedProduct;
  dynamic selectedSize;
  dynamic selectedGrade;
  int selectedQuantity = 1;
  String customerName = '';
  String companyName = '';

  //////////////////////////////////////////////////////////////////////////////////////
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController flname = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController econamicCode = TextEditingController();
  final TextEditingController nationalid = TextEditingController();
  // final TextEditingController branchController = TextEditingController();
  final TextEditingController tellphone = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController registerCode = TextEditingController();
  // final TextEditingController howPayController = TextEditingController();
  // final TextEditingController untilPayController = TextEditingController();

  // final TextEditingController economyCode = TextEditingController();
  // final TextEditingController onTax = TextEditingController();

  // final TextEditingController profitonmonth = TextEditingController();
  // final TextEditingController operatorName = TextEditingController();
  // final TextEditingController branchController = TextEditingController();
  void _errorFields() {
    MotionToast(
      toastDuration: Durations.extralong3,
      icon: Icons.info,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.redAccent,
      title: const Text(
        'پیام سیستم',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('لطفا تمامی فیلد ها را پر کنید'),
      position: MotionToastPosition.top,
      width: 350,
      height: 100,
    ).show(context);
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

  sentmessage() {
    setState(() {});
    Get.snackbar('title', 'message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Container(
            alignment: Alignment.center,
            width: screenWidth - (screenWidth * 0.2),
            height: screenHeight - (screenHeight * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextFormField(
                          // enabled: OrdersCustomers.isCustomerVerified,
                          decoration: InputDecoration(
                            // hintText: productController.text.isEmpty
                            //     ? ''
                            //     : productController.text,
                            labelText: 'نام و نام خانوادگی',
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
                          ),
                          controller: flname,
                        )),
                        Expanded(
                            child: TextFormField(
                          // enabled: OrdersCustomers.isCustomerVerified,
                          decoration: InputDecoration(
                            // hintText: productController.text.isEmpty
                            //     ? ''
                            //     : productController.text,
                            labelText: 'شرکت',
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
                          ),
                          controller: company,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          // enabled: OrdersCustomers.isCustomerVerified,
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
                          ),
                          controller: econamicCode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا کد اقتصادی را وارد کنید';
                            }
                            return null;
                          },
                        )),
                        Expanded(
                            child: TextFormField(
                          // enabled: OrdersCustomers.isCustomerVerified,
                          decoration: InputDecoration(
                            // hintText: productController.text.isEmpty
                            //     ? ''
                            //     : productController.text,
                            labelText: 'شناسه ملی',
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
                          ),
                          controller: nationalid,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا شناسه ملی را وارد کنید';
                            }
                            return null;
                          },
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          // enabled: OrdersCustomers.isCustomerVerified,
                          decoration: InputDecoration(
                            // hintText: productController.text.isEmpty
                            //     ? ''
                            //     : productController.text,
                            labelText: 'شماره تلفن',
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
                          ),
                          controller: tellphone,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا شماره تلفن را وارد کنید';
                            }
                            return null;
                          },
                        )),
                        Expanded(
                            child: TextFormField(
                          // enabled: OrdersCustomers.isCustomerVerified,
                          decoration: InputDecoration(
                            // hintText: productController.text.isEmpty
                            //     ? ''
                            //     : productController.text,
                            labelText: 'کد پستی',
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
                          ),
                          controller: postalCode,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا کد پستی را وارد کنید';
                            } else if (value.length != 10) {
                              return 'کد پستی باید 10 رقم باشد';
                            }
                            return null;
                          },
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            // enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              // hintText: productController.text.isEmpty
                              //     ? ''
                              //     : productController.text,
                              labelText: 'آدرس',
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
                            ),
                            controller: address,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // enabled: OrdersCustomers.isCustomerVerified,
                            decoration: InputDecoration(
                              // hintText: productController.text.isEmpty
                              //     ? ''
                              //     : productController.text,
                              labelText: 'شماره ثبت',
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
                            ),
                            controller: registerCode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'لطفا شناسه ثبت را وارد کنید';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // TextField(
                    //   controller: branchController,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     labelText: 'تعداد',
                    //     hintText: '1',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   onChanged: (value) {
                    //     selectedQuantity = int.tryParse(value) ?? 1;
                    //   },
                    // ),
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
                                          selectedIndex: 0, extended: true));
                                },
                              ));
                            },
                            child: const Text('بازگشت')),
                        ElevatedButton(
                          onPressed: () async {
                            print(
                                'ino dare zakhire mikone : ${UserInfoControll.user_id.value.toString()}');
                            if (flname.text != '' &&
                                company.text != '' &&
                                econamicCode.text != '' &&
                                nationalid.text != '' &&
                                tellphone.text != '' &&
                                postalCode.text != '' &&
                                address.text != '' &&
                                registerCode.text != '') {
                              UserInfoControll.takeData.value = 1;
                              await _submitForm();
                            } else {
                              _errorFields();
                            }
                          },
                          // addOrder,
                          child: const Text('ثبت اطلاعات',
                              style: TextStyle(
                                  fontFamily: 'Irs', color: Colors.blue)),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    const String url =
        'https://test.ht-hermes.com/customers/create-newcustomer.php';

    // نمایش بارگذاری اندیکاتور
    Get.dialog(
      const Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
      barrierDismissible: false,
    );
    int intid = UserInfoControll.user_id.value;
    print('innnnnnnnnnnnnnnnn : ${intid}');
    try {
      print(UserInfoControll.user_id.value);
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          "responsible_name": company.text,
          "company_name": flname.text,
          "national_id": nationalid.text,
          "economic_code": econamicCode.text,
          "postal_code": postalCode.text,
          "phone_number": tellphone.text,
          "address": address.text,
          "operator_name": 'WebApp',
          "registration_number": registerCode.text,
          "usr": UserInfoControll.user_id.value
        }),
      );

      if (response.statusCode == 200) {
        String dataResponse = jsonDecode(response.body)['id'].toString();
        print(dataResponse);
        print('Form submitted successfully');
        AddtoLogs('مشتریان', 'ثبت شد  : ${UserInfoControll.username}');
        print(jsonDecode(response.body));
        await updateUser(dataResponse);
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error submitting form: $e');
    } finally {
      // مخفی کردن بارگذاری اندیکاتور
      Get.back();
    }
  }

  Future<void> updateUser(String userTypeid) async {
    final String url = '${apiService.apiurl}/users/update_usr_advanced.php';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "user_id": UserInfoControll.user_id.value,
        "national_id": nationalid.text,
        "usertype_id": userTypeid,
        "take_data": 1
      }),
    );

    if (response.statusCode == 200) {
      print('ok update shod');
      print(response.body);

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomeMain(
            xxcontroller: SidebarXController(selectedIndex: 0, extended: true),
          );
        },
      ));
      // مخفی کردن بارگذاری اندیکاتور
      Get.back();
      sentmessage();
      Get.defaultDialog(
        title: 'اطلاعات شما با موفقیت ثبت شد',
        middleText: 'در حال رسیدگی به تایید اطلاعات شما',
        titleStyle: const TextStyle(
          fontFamily: 'Irs',
          fontSize: 15,
          color: Colors.white,
        ),
      );
    } else {
      print('Failed to update user data. Status code: ${response.statusCode}');
      print(response.body);
    }
  }
}
