// // import 'dart:html';

// // import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:steelpanel/api/user_info_get.dart';
// // import 'package:steelpanel/widgets/mytextfield.dart';

// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});

// //   @override
// //   State<LoginPage> createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   TextEditingController userController = TextEditingController();
// //   TextEditingController passwordController = TextEditingController();
// //   double screenWidth = 0;

// //   double screenHeight = 0;

// // //baraye yekbar farakhuni shodan
// //   @override
// //   void didChangeDependencies() {
// //     screenWidth = MediaQuery.of(context).size.width;
// //     screenHeight = MediaQuery.of(context).size.height;
// //     super.didChangeDependencies();
// //   }

// //   final formkey = GlobalKey<FormState>();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color.fromARGB(255, 230, 227, 222),
// //       body: Center(
// //         child: Container(
// //           width: screenWidth * 0.25,
// //           height: screenHeight * 0.65,
// //           decoration: BoxDecoration(
// //               color: Colors.white, borderRadius: BorderRadius.circular(25)),
// //           child: SingleChildScrollView(
// //             child: Form(
// //               key: formkey,
// //               child: Column(
// //                 // mainAxisAlignment: MainAxisAlignment.center,
// //                 // crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   SizedBox(
// //                     height: screenHeight * 0.04,
// //                   ),
// //                   SizedBox(
// //                     child: Image.asset('assets/images/login.png', scale: 5),
// //                     // height: 40,
// //                   ),
// //                   const Text('وارد شوید'),
// //                   SizedBox(
// //                     height: screenHeight * 0.04,
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: myTextField(
// //                         prefixicon: const Icon(Icons.supervised_user_circle),
// //                         controller: userController,
// //                         hintText: 'نام کاربری',
// //                         type: TextInputType.name,
// //                         errorText: 'نام کاربری را وارد کنید'),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: myTextField(
// //                         prefixicon: const Icon(Icons.password),
// //                         controller: passwordController,
// //                         hintText: 'رمز خود را وارد کنید',
// //                         type: TextInputType.name,
// //                         errorText: 'رمز عبور را وارد کنید'),
// //                   ),
// //                   SizedBox(
// //                     height: screenHeight * 0.01,
// //                   ),
// //                   SizedBox(
// //                     width: 120,
// //                     height: screenHeight * 0.06,
// //                     child: OutlinedButton(
// //                         style: ButtonStyle(
// //                             backgroundColor:
// //                                 MaterialStateProperty.all(Colors.blue),
// //                             shape: MaterialStateProperty.all<
// //                                     RoundedRectangleBorder>(
// //                                 RoundedRectangleBorder(
// //                                     borderRadius: BorderRadius.circular(25.0),
// //                                     side:
// //                                         const BorderSide(color: Colors.red)))),
// //                         onPressed: () {
// //                           if (formkey.currentState!.validate()) {}
// //                           LogintoPanel(
// //                               userController.text, passwordController.text);
// //                           // Get.to(testpage());
// //                         },
// //                         child: const Text(
// //                           'ورود',
// //                           style:
// //                               TextStyle(fontFamily: 'Irs', color: Colors.white),
// //                         )),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:steelpanel/screens/homescreen.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController userController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   double screenWidth = 0;
//   double screenHeight = 0;

//   @override
//   void didChangeDependencies() {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     super.didChangeDependencies();
//   }

//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   final formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 230, 227, 222),
//       body: Center(
//         child: Container(
//           width: screenWidth * 0.25,
//           height: screenHeight * 0.65,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(25)),
//           child: SingleChildScrollView(
//             child: Form(
//               key: formkey,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: screenHeight * 0.04,
//                   ),
//                   SizedBox(
//                     child: Image.asset('assets/images/login.png', scale: 5),
//                   ),
//                   const Text('وارد شوید'),
//                   SizedBox(
//                     height: screenHeight * 0.04,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: userController,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.supervised_user_circle),
//                         hintText: 'نام کاربری',
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: passwordController,
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.password),
//                         hintText: 'رمز عبور',
//                       ),
//                       obscureText: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.01,
//                   ),
//                   SizedBox(
//                     width: 120,
//                     height: screenHeight * 0.06,
//                     child: OutlinedButton(
//                       onPressed: () async {
//                         if (formkey.currentState!.validate()) {
//                           LogintoPanel(
//                               userController.text, passwordController.text);
//                           // final response = await http.post(
//                           //   Uri.parse('http://localhost/save_login.php'),
//                           //   body: jsonEncode({
//                           //     'username': userController.text,
//                           //     'password': passwordController.text,
//                           //   }),
//                           // );

//                           // if (response.statusCode == 200) {
//                           //   final responseData = jsonDecode(response.body)
//                           //       as Map<String, dynamic>;
//                           //   final sessionId = responseData['sessionId'];
//                           //   await Get.defaultDialog(title: 'Success!');
//                           //   // ذخیره کردن شناسه کاربر در localStorage
//                           //   saveToLocalStorage('sessionId', sessionId);
//                           //   await Get.to(HomePage());

//                           //   // انتقال به صفحه دیگر یا انجام اقدامات دیگر
//                           // } else {
//                           //   // نمایش پیام خطا
//                           // }
//                         }
//                       },
//                       child: const Text(
//                         'ورود',
//                         style:
//                             TextStyle(fontFamily: 'Irs', color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                       onPressed: () async {
//                         SharedPreferences prefs = await _prefs;
//                         prefs.setString('Username', userController.text);
//                       },
//                       child: Text('Save'))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void saveToLocalStorage(String key, String value) {
//     window.localStorage[key] = value;
//   }
// }
