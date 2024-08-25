import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
// import 'package:steelpanel/login/saveddata.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/widgets/login/register.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

class LoginPageSk extends StatefulWidget {
  const LoginPageSk({super.key});

  @override
  _LoginPageSkState createState() => _LoginPageSkState();
}

class _LoginPageSkState extends State<LoginPageSk> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _errorWaringn() {
    MotionToast(
      toastDuration: Durations.extralong3,
      icon: Icons.login,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.redAccent,
      title: const Text(
        'پیام سیستم',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('نام کاربری یا رمز عبور اشتباه است'),
      position: MotionToastPosition.top,
      width: 350,
      height: 100,
    ).show(context);
  }

  void _displayTransparentMotionToast() {
    MotionToast(
      toastDuration: Durations.extralong2,
      icon: Icons.login,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        'پیام سیستم',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('لطفا وارد شوید'),
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

  final formkey = GlobalKey<FormState>();
  String _savedValue = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  void refresh() {
    setState(() {});
  }

  void _loadSavedValue() async {
    // دریافت مقدار ذخیره شده در کوکی
    final cookies = html.document.cookie?.split('; ') ?? [];
    for (var cookie in cookies) {
      if (cookie.startsWith('textfield_value=')) {
        setState(() {
          _savedValue = cookie.substring('textfield_value='.length);
          print(_savedValue);
        });
      }
    }
    print('1 token');
    var url = Uri.parse('${apiService.apiurl}/ctoken.php/');
    var data = jsonEncode({"token": _savedValue});
    var response = await http.post(url, body: data);
    print(data);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      String userName = jsonDecode(response.body)['username'];
      String userType = jsonDecode(response.body)['userType'];
      String fname = jsonDecode(response.body)['name'];
      String lname = jsonDecode(response.body)['lastname'];
      print('2 token');
      String userAvatar = jsonDecode(response.body)['base64_image'] ?? '';
      print('2.2 token');
      int verified = jsonDecode(response.body)['verified'] ?? 0;
      print('2.3 token');
      String permission = jsonDecode(response.body)['permission'].toString();
      print('2.4 token');
      int takeData = jsonDecode(response.body)['take_data'] ?? 0;
      print('2.5 token');
      String userTypeId = jsonDecode(response.body)['usertype_id'] ?? '0';
      print('2.6 token');
      String orderid = jsonDecode(response.body)['order_id'].toString() ?? '';
      print('3 token');
      print(
          'innnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn :$userAvatar');
      // String token = jsonDecode(response.body)['token'];
      print(userName);

      UserInfoControll.user_id.value = jsonDecode(response.body)['user_id'];
      UserInfoControll.userTypeId.value = userTypeId;
      print('user type ok!');
      print('user type id = ${userTypeId}');
      print(UserInfoControll.user_id.value);
      UserInfoControll.userType.value = userType;
      print('user type ok!');
      UserInfoControll.username.value = userName;
      print('username  ok!');

      UserInfoControll.first_name.value = fname;
      print('fname  ok!');
      UserInfoControll.last_name.value = lname;
      print('lname  ok!');

      UserInfoControll.token.value = _savedValue;
      print('token  ok!');
      UserInfoControll.user_avatar.value = userAvatar;
      print('user avatar  ok!');
      UserInfoControll.verify.value = (verified == 1 ? true : false);
      print('verified ok! ${UserInfoControll.verify.value}');

      UserInfoControll.takeData.value = (takeData == 0 ? 0 : 1);
      print('take data ok! ${UserInfoControll.takeData.value}');
      // تبدیل هر رقم از رشته permission به یک عدد و اضافه کردن به لیست
      UserInfoControll.orderId.value = orderid;
      print('in meghdare orderid : ${UserInfoControll.orderId.value}');
      List<int> permissionList =
          permission.split('').map((char) => int.parse(char)).toList();
      UserInfoControll.permission.value = permissionList;

      // print(verified == '' ? 'no maybe null' : 'yes');
      print(permission);
      // // تبدیل رشته JSON به یک Map
      // Map<String, dynamic> jsonMap = jsonDecode(response.body)['permission'];

      // // دریافت مقدار permission به عنوان یک رشته
      // String permissionString = jsonMap['permission'].toString();

      // تبدیل هر رقم از رشته permission به یک عدد و اضافه کردن به لیست
      // List<int> permissionList =
      //     permission.split('').map((char) => int.parse(char)).toList();

      // چاپ لیست permission
      print(permissionList); // [5, 5, 5]
      // saveData.username = jsonDecode(response.body)['username'];
      // saveData.name = jsonDecode(response.body)['name'] ?? '';
      // saveData.lastname = jsonDecode(response.body)['lastname'] ?? '';
      // saveData.userType = jsonDecode(response.body)['userType'] ?? '';
      // saveData.id = jsonDecode(response.body)['user_id'];
      // دریافت مقدار اطلاعات کاربر
      // مثال: String name = jsonDecode(response.body)['name'];
      // Get.snackbar('title', 'yesss');
      int checkOrderId = jsonDecode(response.body)['order_id'] ?? 0;
      checkOrderId.toString();
      if (userType == 'confirmed_customers') {
        print('yes');
        if (checkOrderId != 0 || checkOrderId != null) {
          final response = await http.get(Uri.parse(
              'https://test.ht-hermes.com/orders/read-order.php?order_id=${checkOrderId}'));

          if (response.statusCode == 200) {
            print('object');
            print(jsonDecode(response.body));

            List<dynamic> responseData = jsonDecode(response.body);

            // دسترسی به اولین عنصر لیست و سپس دسترسی به کلید `status`
            int status = responseData[0]['status'];
            String product = responseData[0]['product'];
            String weight = responseData[0]['weight'];
            String grade = responseData[0]['grade'];
            UserInfoControll.items.clear();
            UserInfoControll.items.add(product);
            UserInfoControll.items.add(weight);
            UserInfoControll.items.add(grade);
            print(UserInfoControll.items);

            print('Status: $status');
            UserInfoControll.status.value = status;

            setState(() {});

            print(' yes $status');
            // print(status.toString());

            setState(() {});
          } else {
            throw Exception('Failed to load sell orders');
          }
        }
      }
      void refresh() {
        setState(() {});
      }

      print('ine dggggg ${UserInfoControll.userType.value}');
      Get.to(HomeMain(
        xxcontroller: SidebarXController(selectedIndex: 0, extended: true),
      )
          //   const
          // HomePage()

          );
      AddtoLogs('ورود', 'کاربر ${UserInfoControll.username} وارد شد');
    } else {
      print('Request failed with status: ${response.statusCode}');

      _displayTransparentMotionToast();
    }
  }

  Future<void> _saveValue() async {
    final value = _controller.text;
    // ذخیره مقدار در کوکی
    html.document.cookie = 'textfield_value=$value; path=/';
    // رفرش صفحه برای بارگذاری مجدد مقدار
    html.window.location.reload();
  }

  String _response = '';
  void _login() async {
    var url = Uri.parse('${apiService.apiurl}/clogin.php');
    var data =
        jsonEncode({"username": _username.text, "password": _password.text});

    try {
      var response = await http.post(
        url,
        // headers: {
        //   'Content-Type': 'application/json',
        // },
        body: data,
      );

      if (response.statusCode == 200) {
        int verified = jsonDecode(response.body)['verified'] ?? 0;
        var response0 = jsonDecode(response.body);
        print('in Response $response0');
        print('11111');
        print('in UserName ${response0['username']}');
        print('object');
        _token = response0['token'];
        print('ok save shod');
        UserInfoControll.username.value = response0['username'];
        print('username ok!');
        UserInfoControll.token.value = _token;
        UserInfoControll.userType.value = response0['userType'];
        print('1');
        UserInfoControll.userTypeId.value = response0['usertype_id'] ?? '';
        print('2');
        UserInfoControll.verify.value = (verified == 1 ? true : false);
        print('3');
        print('userType ok!');
        UserInfoControll.first_name.value = response0['name'] ?? '';
        print('name ok!');
        UserInfoControll.last_name.value = response0['lastname'] ?? '';
        print('lastname ok!');
        UserInfoControll.user_id.value = response0['userID'];
        print('userID ok!');
        print('in user id hast ; ${UserInfoControll.user_id.value}');
        String permission = jsonDecode(response.body)['permission'] == null ||
                jsonDecode(response.body)['permission'] == 0
            ? ''
            : jsonDecode(response.body)['permission'].toString();
        print('permission ok!');
        UserInfoControll.user_avatar.value =
            jsonDecode(response.body)['base64_image'] ?? '';
        print('userAvatar ok!');
        List<int> permissionList =
            permission.split('').map((char) => int.parse(char)).toList();
        UserInfoControll.permission.value = permissionList;
        print('pk ok!');

        UserInfoControll.takeData.value =
            jsonDecode(response.body)['take_data'] ?? 0;
        print(UserInfoControll.takeData.value);
        String orderid = jsonDecode(response.body)['order_id'].toString() ?? '';
        UserInfoControll.orderId.value = orderid;
        // UserInfoControll.userType = _response['userType'];
        // UserInfoControll.first_name = _response['name'] ?? '';
        // UserInfoControll.last_name = _response['lastname'] ?? '';
        // UserInfoControll.user_id = _response['user_id'];

        print('in token jadid$_token');
        const value = "_controller.text";
        // ذخیره مقدار در کوکی
        html.document.cookie = 'textfield_value=$_token; path=/';
        // Get.to(const HomePage());
        // رفرش صفحه برای بارگذاری مجدد مقدار
        // html.window.location.reload();
        // setState(() {
        // HomePage.user_name = _response['username'];
        // saveData.username = _response['username'];
        // saveData.name = _response['name'] ?? '';
        // saveData.lastname = _response['lastname'] ?? '';
        // saveData.userType = _response['userType'] ?? '';
        // saveData.id = _response['user_id'];
        // String userType = _response['userType'];
        // String userName = _response['username'];
        // UserInfoControll.user_id = _response['user_id'];
        // UserInfoControll.userType.value = userType;
        // UserInfoControll.username.value = userName;
        // print(saveData.id);
        // // });
        // await Future.delayed(Duration(
        //     milliseconds:
        //         100)); // این خط برای اطمینان از به روز رسانی مقادیر است
        // setState(() {
        //   String userType = _response['userType'];
        //   String userName = _response['username'];
        //   UserInfoControll.user_id = _response['user_id'];
        //   UserInfoControll.userType.value = userType;
        //   UserInfoControll.username.value = userName;
        // });
        // print(jsonDecode(response.body)['base64_image']);

        refresh();
        print('ine dg ${UserInfoControll.userType.value}');
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomeMain(
              xxcontroller:
                  SidebarXController(selectedIndex: 0, extended: true),
            );
          },
        ));

        print('object');

        print('object');
      } else {
        setState(() {
          _response = 'Error: ${response.statusCode}';
        });
        _errorWaringn();
      }
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 1, 1, 34),

      // const Color.fromARGB(255, 230, 227, 222),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(blurStyle: BlurStyle.outer)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  SizedBox(
                    child: Image.asset('assets/images/hs.png', scale: 4),
                    // height: 40,
                  ),
                  const Text(
                    'وارد شوید',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(
                    height: screenHeight * 0.00005,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.supervised_user_circle),
                          controller: _username,
                          hintText: 'نام کاربری',
                          type: TextInputType.name,
                          errorText: 'نام کاربری را وارد کنید'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.password),
                          controller: _password,
                          hintText: 'رمز خود را وارد کنید',
                          type: TextInputType.name,
                          errorText: 'رمز عبور را وارد کنید'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Row(
                      children: [
                        OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.orange),
                                shape: MaterialStatePropertyAll<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                            color: Colors.red)))),
                            onPressed: () {
                              setState(() {
                                if (formkey.currentState!.validate()) {}

                                _login();
                              });
                            },
                            child: const Text(
                              'ورود',
                              style: TextStyle(
                                  fontFamily: 'Irs', color: Colors.white),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 206, 201, 201),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                                onPressed: () {
                                  Get.to(const RegsiterPage());
                                },
                                child: const Text(
                                  'ثبت نام',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontFamily: 'Irs',
                                      fontWeight: FontWeight.bold),
                                )))
                      ],
                    ),
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
