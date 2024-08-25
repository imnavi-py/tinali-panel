import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/config.dart';

import 'package:steelpanel/data/admin_info.dart';

import 'package:http/http.dart' as http;
import 'package:steelpanel/screens/homescreen.dart';

// import 'package:steelpanel/data/sql/mysql-admin.dart';
// import 'package:steelpanel/data/sql/sqladmin.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
// Import the Admin class
// import 'package:steelpanel/login/Testsave.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final regKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 227, 222),
      body: Center(
        child: Container(
          width: screenWidth * 0.25,
          height: screenHeight * 0.65,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: SingleChildScrollView(
            child: Form(
              key: regKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  SizedBox(
                    child: Image.asset('assets/images/login.png', scale: 5),
                    // height: 40,
                  ),
                  const Text('مشخصات ادمین'),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myTextField(
                        prefixicon: const Icon(Icons.supervised_user_circle),
                        controller: _usernameController,
                        hintText: 'نام کاربری',
                        type: TextInputType.name,
                        errorText: 'نام کاربری را وارد کنید'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myTextField(
                        prefixicon: const Icon(Icons.password),
                        controller: _passwordController,
                        hintText: 'رمز خود را وارد کنید',
                        type: TextInputType.name,
                        errorText: 'رمز عبور را وارد کنید'),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  SizedBox(
                    width: 120,
                    height: screenHeight * 0.06,
                    child: OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.blue),
                            shape: MaterialStatePropertyAll<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                        onPressed: () async {
                          if (regKey.currentState!.validate()) {
                            // final uuid = int.parse(Uuid().v4());
                            // final uuid = Random().nextInt(100000);
                            try {
                              createUser(_usernameController.text,
                                  _passwordController.text, true, 'SuperAdmin');
                              //_saveUserToDB(user); // اگر از پایگاه داده استفاده می کنید

                              // نمایش پیام موفقیت یا انجام اقدامات دیگر
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text('اوکی'),
                              //   ),
                              // );
                            } catch (e) {
                              print(e);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('ارور'),
                                ),
                              );
                            }

                            // final _scaffoldMessenger =
                            //     ScaffoldMessenger.of(context);

                            // final user = User(
                            //   name: 'admin',
                            //   lastName: 'admin',
                            //   fullControl: true,
                            //   password: _passwordController.text,
                            //   username: _usernameController.text,
                            //   unit: 'modirkol',
                            // );

                            // try {
                            //   await DatabaseHelper().insertUser(user);
                            //   _scaffoldMessenger.showSnackBar(
                            //     SnackBar(
                            //       content: Text('اطلاعات با موفقیت ذخیره شد!'),
                            //     ),
                            //   );
                            // } catch (e) {
                            //   print(e);
                            //   _scaffoldMessenger.showSnackBar(
                            //     SnackBar(
                            //       content: Text('خطا در ذخیره اطلاعات!'),
                            //     ),
                            //   );
                            // }
                          }
                        },
                        child: const Text(
                          'ثبت ادمین',
                          style:
                              TextStyle(fontFamily: 'Irs', color: Colors.white),
                        )),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Get.to(HomePage());
                  //     },
                  //     child: Text('data'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _testConnection() async {
  //   final conn = await connectToDatabase();
  //   try {
  //     print('Connected to database!'); // تأیید ساده تر
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('وصل شد'),
  //       ),
  //     );
  //     // هنوز هم می توانید پرس و جوهای SQL را در اینجا اجرا کنید

  //     final results = await conn.query('SELECT * FROM users');
  //     for (final row in results) {
  //       print('User: ${row[0]} - ${row[1]} - ${row[2]}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   } finally {
  //     await conn.close();
  //   }
  // }

  Future<void> createUser(
      String username, String password, bool isAdmin, String userType) async {
    // آدرس فایل PHP
    var url = Uri.parse('${apiService.apiurl}/new.php');

    // داده‌های JSON برای ارسال
    var data = jsonEncode({
      "username": username, "password": password, "isadmin": isAdmin,
      "userType": userType, // اضافه کردن فیلد userType
    });

    try {
      // ارسال درخواست POST با فرمت JSON
      var response = await http.post(
        url,
        headers: {
          'Content-Type':
              'application/json', // تنظیم هدر Content-Type به فرمت JSON
        },
        body: data, // ارسال داده‌های JSON به فایل PHP
      );

      // چک کردن کد وضعیت درخواست
      if (response.statusCode == 201) {
        print('User created successfully');

        Map<String, dynamic> responseData = json.decode(response.body);
        int userId = responseData['user_id'];
        // checkdialog.idValue = userId.toString();
        print('User ID: $userId');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(userId.toString()),
          ),
        );

        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                controller:
                    SidebarXController(selectedIndex: 0, extended: true),
              ),
            ),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Welcome Admin'),
          ),
        );
      } else {
        print('Failed to create user');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ارور'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
