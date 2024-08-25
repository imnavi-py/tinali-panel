import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/data/admin_info.dart';
import 'package:steelpanel/main.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/utils/adduserfunc.dart';
import 'package:steelpanel/utils/dialog_functions.dart';
import 'package:http/http.dart' as http;

class Addunituser extends StatefulWidget {
  const Addunituser({super.key});

  @override
  State<Addunituser> createState() => _AddunituserState();
}

class _AddunituserState extends State<Addunituser> {
  // Box<AdminInfo> hivebox = Hive.box<AdminInfo>('adminBox');
  String usrtype = '';
  final controller = Get.put(DialogFuncs());
  // final checkdialog_void = Get.put(checkdialog());

  TextEditingController newUserName = TextEditingController();
  TextEditingController newUserPassword = TextEditingController();
  final List<String> genderItems = [
    // 'Guest','Admin','Customers','Seller','Moneyoperator','MoneyAdmin','SuperAdmin','Supporter'
    'مدیر', 'اپراتور برنامه', 'پشتیبانی', 'مدیربازرگانی', 'اپراتور فروش',
    'اپراتور واحد مالی', 'مدیر واحد مالی', 'مشتری', 'تامین کننده'
  ];
  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.white,
      width: 300,
      height: 400,
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFieldContainer(
                    child: TextFormField(
                      controller: newUserName,
                      autofillHints: const [AutofillHints.email],
                      onEditingComplete: () =>
                          TextInput.finishAutofillContext(),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person_2_rounded,
                            color: Colors.blue,
                          ),
                          labelText: 'نام کاربری'),
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'لطفا نام کاربری را وارد کنید';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Obx(() {
                  return SizedBox(
                    width: 200,
                    child: TextFieldContainer(
                      child: TextFormField(
                        obscureText: controller.secureText.value,
                        controller: newUserPassword,
                        autofillHints: const [AutofillHints.email],
                        onEditingComplete: () =>
                            TextInput.finishAutofillContext(),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleSecureText();
                              print(controller.secureText);
                            },
                            icon: Icon(controller.secureText.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          labelText: 'رمز عبور',
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'رمز عبور را وارد کنید';
                          }
                          return null;
                        },
                      ),
                    ),
                  );
                }),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            fillColor: Colors.blue[50],
                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                            // the menu padding when button's width is not specified.
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // Add more decoration..
                          ),
                          hint: const Text(
                            'بخش کاربری',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'BYekan',
                                color: Colors.black),
                          ),
                          items: genderItems
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            //Do something when selected item is changed.

                            // value != null ? usrtype = value : usrtype = '';
                            switch (value) {
                              // 'Guest','Admin','Customers','Seller','Moneyoperator','MoneyAdmin','SuperAdmin','Supporter'
                              case 'مدیر':
                                usrtype = 'Admin';
                                break;
                              case 'اپراتور برنامه':
                                usrtype = 'oprator';
                                break;
                              case 'اپراتور واحد مالی':
                                usrtype = 'Moneyoperator';
                                break;
                              case 'مدیر واحد مالی':
                                usrtype = 'MoneyAdmin';
                                break;
                              case 'مشتری':
                                usrtype = 'Customers';
                                break;
                              case 'تامین کننده':
                                usrtype = 'Supplier';
                                break;
                              case 'پشتیبانی':
                                usrtype = 'Supporter';
                                break;
                              case 'مدیر بازرگانی':
                                usrtype = 'Commerce';
                                break;
                              case 'اپراتور فروش':
                                usrtype = 'SellOperator';
                                break;
                            }
                            print(usrtype);
                          },
                          onSaved: (value) {
                            selectedValue = value.toString();
                            print(value.toString());
                          },
                          buttonStyleData: ButtonStyleData(
                            overlayColor: MaterialStatePropertyAll<Color>(
                                Colors.blue[50]!),
                            padding: const EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.blue[50]!)),
                            onPressed: () async {
                              // if (_formKey.currentState!.validate()) {
                              // Navigator.pop(context);
                              Get.back();

                              // createUser(
                              //   newUserName.text,
                              //   newUserPassword.text,
                              //   true,
                              //   usrtype,
                              // );

                              //////////////////////////////////////////////////////////////////////

                              var url =
                                  Uri.parse('${apiService.apiurl}/new.php');

                              var data = jsonEncode({
                                "username": newUserName.text,
                                "password": newUserPassword.text,
                                "isadmin": true,
                                "userType": usrtype,
                              });

                              try {
                                var response = await http.post(
                                  url,
                                  headers: {
                                    'Content-Type': 'application/json',
                                  },
                                  body: data,
                                );
                                print(response);
                                if (response.statusCode == 201) {
                                  print('object');

                                  // Extract user_id from response
                                  Map<String, dynamic> responseData =
                                      json.decode(response.body);
                                  int userId = responseData['user_id'];
                                  // checkdialog.idValue = userId.toString();
                                  print('User ID: $userId');
                                  Get.defaultDialog(
                                      title: 'موفقیت',
                                      titleStyle: const TextStyle(
                                        fontFamily: 'Irs',
                                        fontSize: 15,
                                      ),
                                      content: Text(
                                          'آیدی کاربر : ${userId.toString()}'));

                                  // checkdialog_void.servicedialog();
                                  // Get.defaultDialog(
                                  //     title: 'آیدی کاربر',
                                  //     middleText: userId.toString());

                                  // Close the current page
                                  // Navigator.pop(context);
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const HomePage(),
                                  //     ),
                                  //     (route) => false);

                                  // Show a success snackbar
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(
                                  //   SnackBar(
                                  //     content:
                                  //         Text('کاربر با موفقیت اضافه شد'),
                                  //   ),
                                  // );

                                  // await Get.defaultDialog(title: 'موفقیت');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('خطا در ایجاد کاربر'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                Get.defaultDialog(title: 'ارور');
                                print('Error: $e');
                              }

                              /////////////////////////////////////////////////////////////////////////////////////////////

                              // SnackBar(
                              //     content:
                              //         Text('کاربر با موفقیت اضافه شد'));
                              // Get.snackbar(
                              //     'موفقیت', 'کاربر با موفقیت اضافه شد');
                              // Get.back();
                            },
                            child: const Text(
                              'اضافه کردن',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createUser(
      String username, String password, bool isAdmin, String userType) async {
    var url = Uri.parse('${apiService.apiurl}/new.php');

    var data = jsonEncode({
      "username": username,
      "password": password,
      "isadmin": isAdmin,
      "userType": userType,
    });

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        // Extract user_id from response
        Map<String, dynamic> responseData = json.decode(response.body);
        int userId = responseData['user_id'];
        print('User ID: $userId');

        // Close the current page
        Navigator.pop(context);

        // Show a success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('کاربر با موفقیت اضافه شد'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطا در ایجاد کاربر'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
