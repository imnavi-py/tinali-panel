// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class testpage extends StatefulWidget {
//   const testpage({super.key});

//   @override
//   _testpageState createState() => _testpageState();
// }

// class _testpageState extends State<testpage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> _login() async {
//     var url = Uri.parse('http://localhost/user_auth.php');
//     var data = jsonEncode({"username": "admin", "password": "admin"});
//     var response = await http.post(url, body: data
//         // {
//         //   "username": _usernameController.text,
//         //   "password": _passwordController.text
//         // },
//         );

//     if (response.statusCode == 200) {
//       print('Response body: ${response.body}');
//       // دریافت مقدار اطلاعات کاربر
//       // مثال: String name = jsonDecode(response.body)['name'];
//       Get.snackbar('title', 'message');
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//       Get.snackbar('title', '${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Login'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(labelText: 'Username'),
//               ),
//               TextField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _login,
//                 child: const Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
