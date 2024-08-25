// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:sidebarx/sidebarx.dart';
// import 'package:steelpanel/api/add-log.dart';
// import 'package:steelpanel/api/config.dart';
// import 'package:steelpanel/control/user-info.dart';
// import 'package:steelpanel/login/saveddata.dart';
// import 'package:steelpanel/screens/homescreen.dart';
// import 'package:steelpanel/screens/pages/home.dart';
// import 'package:steelpanel/widgets/mytextfield.dart';
// import 'package:universal_html/html.dart' as html;
// import 'package:http/http.dart' as http;

// class LoginPageSk extends StatefulWidget {
//   const LoginPageSk({super.key, this.refresh});
//   final refresh;
//   @override
//   _LoginPageSkState createState() => _LoginPageSkState();
// }

// class _LoginPageSkState extends State<LoginPageSk> {
//   late SidebarXController xxcontroller;
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _username = TextEditingController();
//   final TextEditingController _password = TextEditingController();

//   TextEditingController userController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   double screenWidth = 0;

//   double screenHeight = 0;

// //baraye yekbar farakhuni shodan
//   @override
//   void didChangeDependencies() {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     super.didChangeDependencies();
//   }

//   final formkey = GlobalKey<FormState>();
//   String _savedValue = '';
//   String _token = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedValue();
//   }

//   void refresh() {
//     setState(() {});
//   }

//   void _loadSavedValue() async {
//     // دریافت مقدار ذخیره شده در کوکی
//     final cookies = html.document.cookie?.split('; ') ?? [];
//     for (var cookie in cookies) {
//       if (cookie.startsWith('textfield_value=')) {
//         setState(() {
//           _savedValue = cookie.substring('textfield_value='.length);
//           print(_savedValue);
//         });
//       }
//     }

//     var url = Uri.parse('${apiService.apiurl}/ctoken.php/');
//     var data = jsonEncode({"token": _savedValue});
//     var response = await http.post(url, body: data);
//     print(data);
//     if (response.statusCode == 200) {
//       print('Response body: ${response.body}');
//       String userName = jsonDecode(response.body)['username'];
//       String fname = jsonDecode(response.body)['name'];
//       String lname = jsonDecode(response.body)['lastname'];
//       String userType = jsonDecode(response.body)['userType'];
//       String userAvatar = jsonDecode(response.body)['base64_image'];
//       String takeData = jsonDecode(response.body)['take_data'];
//       print(fname);
//       print(
//           'innnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnttttt :$userAvatar');
//       // String token = jsonDecode(response.body)['token'];
//       print(userName);
//       print('object');
//       print('this is take data : ${jsonDecode(response.body)['take_data']}');
//       UserInfoControll.user_id.value = jsonDecode(response.body)['user_id'];
//       UserInfoControll.userType.value = userType;
//       UserInfoControll.username.value = userName;
//       UserInfoControll.first_name.value = fname;
//       UserInfoControll.last_name.value = lname;
//       UserInfoControll.token.value = _savedValue;
//       UserInfoControll.user_avatar.value = userAvatar;
//       UserInfoControll.takeData.value = int.parse(takeData);
//       print(UserInfoControll.takeData.value);
//       // saveData.username = jsonDecode(response.body)['username'];
//       // saveData.name = jsonDecode(response.body)['name'] ?? '';
//       // saveData.lastname = jsonDecode(response.body)['lastname'] ?? '';
//       // saveData.userType = jsonDecode(response.body)['userType'] ?? '';
//       // saveData.id = jsonDecode(response.body)['user_id'];
//       // دریافت مقدار اطلاعات کاربر
//       // مثال: String name = jsonDecode(response.body)['name'];
//       // Get.snackbar('title', 'yesss');

//       Get.to(

//           // HomePage()
//           Directionality(
//               textDirection: TextDirection.ltr,
//               child: HomeMain(
//                 xxcontroller:
//                     SidebarXController(selectedIndex: 0, extended: true),
//               )));
//       AddtoLogs('ورود', 'کاربر ${UserInfoControll.username} وارد شد');
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//       Get.snackbar('پیام سیستم', 'لطفا وارد شوید');
//     }
//   }

//   Future<void> _saveValue() async {
//     final value = _controller.text;
//     // ذخیره مقدار در کوکی
//     html.document.cookie = 'textfield_value=$value; path=/';
//     // رفرش صفحه برای بارگذاری مجدد مقدار
//     html.window.location.reload();
//   }

//   String _response = '';
//   void _login() async {
//     var url = Uri.parse('${apiService.apiurl}/clogin.php');
//     var data =
//         jsonEncode({"username": _username.text, "password": _password.text});

//     try {
//       var response = await http.post(
//         url,
//         // headers: {
//         //   'Content-Type': 'application/json',
//         // },
//         body: data,
//       );

//       if (response.statusCode == 200) {
//         var response0 = jsonDecode(response.body);
//         print('in Response $response0');
//         print('in UserName ${response0['username']}');
//         _token = response0['token'];
//         UserInfoControll.username.value = response0['username'];
//         UserInfoControll.token.value = _token;
//         UserInfoControll.userType.value = response0['userType'];
//         UserInfoControll.first_name.value = response0['name'] ?? '';
//         UserInfoControll.last_name.value = response0['lastname'] ?? '';
//         UserInfoControll.user_id.value = response0['userID'];
//         UserInfoControll.takeData.value = response0['take_data'];
//         print(UserInfoControll.takeData.value);
//         // UserInfoControll.userType = _response['userType'];
//         // UserInfoControll.first_name = _response['name'] ?? '';
//         // UserInfoControll.last_name = _response['lastname'] ?? '';
//         // UserInfoControll.user_id = _response['user_id'];

//         print('in token jadid$_token');
//         const value = "_controller.text";
//         // ذخیره مقدار در کوکی
//         html.document.cookie = 'textfield_value=$_token; path=/';
//         // Get.to(const HomePage());
//         // رفرش صفحه برای بارگذاری مجدد مقدار
//         // html.window.location.reload();
//         // setState(() {
//         // HomePage.user_name = _response['username'];
//         // saveData.username = _response['username'];
//         // saveData.name = _response['name'] ?? '';
//         // saveData.lastname = _response['lastname'] ?? '';
//         // saveData.userType = _response['userType'] ?? '';
//         // saveData.id = _response['user_id'];
//         // String userType = _response['userType'];
//         // String userName = _response['username'];
//         // UserInfoControll.user_id = _response['user_id'];
//         // UserInfoControll.userType.value = userType;
//         // UserInfoControll.username.value = userName;
//         // print(saveData.id);
//         // // });
//         // await Future.delayed(Duration(
//         //     milliseconds:
//         //         100)); // این خط برای اطمینان از به روز رسانی مقادیر است
//         // setState(() {
//         //   String userType = _response['userType'];
//         //   String userName = _response['username'];
//         //   UserInfoControll.user_id = _response['user_id'];
//         //   UserInfoControll.userType.value = userType;
//         //   UserInfoControll.username.value = userName;
//         // });
//         // print(jsonDecode(response.body)['base64_image']);
//         UserInfoControll.user_avatar.value =
//             jsonDecode(response.body)['base64_image'];

//         refresh();

//         Get.to(HomePage(
//             controller: SidebarXController(selectedIndex: 0, extended: true)));
//         print('object');

//         print('object');
//       } else {
//         setState(() {
//           _response = 'Error: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _response = 'Error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(251, 1, 1, 34),

//       // const Color.fromARGB(255, 230, 227, 222),
//       body: Center(
//         child: Container(
//           width: 400,
//           height: 400,
//           decoration: BoxDecoration(
//               boxShadow: const [BoxShadow(blurStyle: BlurStyle.outer)],
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20)),
//           child: SingleChildScrollView(
//             child: Form(
//               key: formkey,
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: screenHeight * 0.01,
//                   ),
//                   SizedBox(
//                     child: Image.asset('assets/images/hs.png', scale: 4),
//                     // height: 40,
//                   ),
//                   const Text(
//                     'وارد شوید',
//                     style: TextStyle(
//                         fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.00005,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: 50,
//                       width: 300,
//                       child: myTextField(
//                           prefixicon: const Icon(Icons.supervised_user_circle),
//                           controller: _username,
//                           hintText: 'نام کاربری',
//                           type: TextInputType.name,
//                           errorText: 'نام کاربری را وارد کنید'),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: 50,
//                       width: 300,
//                       child: myTextField(
//                           prefixicon: const Icon(Icons.password),
//                           controller: _password,
//                           hintText: 'رمز خود را وارد کنید',
//                           type: TextInputType.name,
//                           errorText: 'رمز عبور را وارد کنید'),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   SizedBox(
//                     width: 150,
//                     height: 50,
//                     child: Row(
//                       children: [
//                         OutlinedButton(
//                             style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStatePropertyAll<Color>(
//                                         Colors.orange),
//                                 shape: MaterialStatePropertyAll<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         side: const BorderSide(
//                                             color: Colors.red)))),
//                             onPressed: () {
//                               setState(() {
//                                 if (formkey.currentState!.validate()) {}

//                                 _login();
//                               });
//                             },
//                             child: const Text(
//                               'ورود',
//                               style: TextStyle(
//                                   fontFamily: 'Irs', color: Colors.white),
//                             )),
//                         TextButton(
//                             onPressed: () {}, child: const Text('ثبت نام'))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),

//       // appBar: AppBar(
//       //   title: Text('Flutter Web Cookies'),
//       // ),
//       // body: Center(
//       //   child: Padding(
//       //     padding: const EdgeInsets.all(16.0),
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       children: <Widget>[
//       //         TextField(
//       //           controller: _controller,
//       //           decoration: InputDecoration(
//       //             labelText: 'Enter value',
//       //           ),
//       //         ),
//       //         SizedBox(height: 20),
//       //         ElevatedButton(
//       //           onPressed: _login,
//       //           // () {
//       //           //   _login();
//       //           //   _saveValue();
//       //           // },
//       //           child: Text('Save to Cookie and Refresh'),
//       //         ),
//       //         SizedBox(height: 20),
//       //         Text(
//       //           'Saved value: $_savedValue',
//       //           style: TextStyle(fontSize: 20),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
