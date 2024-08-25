// import 'package:flutter/material.dart';
// import 'package:steelpanel/data/sql/mysql-admin.dart';
// import 'package:steelpanel/data/sql/sqladmin.dart';

// class UsersIndb extends StatefulWidget {
//   const UsersIndb({super.key});

//   @override
//   State<UsersIndb> createState() => _UsersIndbState();
// }

// class _UsersIndbState extends State<UsersIndb> {
//   List<User> _users = [];
//   final DatabaseHelper _dbHelper = DatabaseHelper(); // ایجاد نمونه

//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//   }

//   Future<void> _loadUsers() async {
//     final users = await _dbHelper.getAllUsers();
//     setState(() {
//       _users = users;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('لیست کاربران'),
//       ),
//       body: ListView.builder(
//         itemCount: _users.length,
//         itemBuilder: (context, index) {
//           final user = _users[index];
//           return ListTile(
//             title: Text('${user.username} ${user.password}'),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () async {
//                 await _dbHelper.deleteUserById(user.id);
//                 await _loadUsers(); // دوباره لیست را بارگیری کنید
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// superAdmin
// 111111111

// admin
// 111111110
// support
// 111111110

// weboperator
// 111111100


// Commerce
// 111101100
// Commerce oprator
// 111101000

// financial_admin 
// 111111000
// financial_operator
// 111110000

// customers
// panel shakhsi

// supplier
// panel shakhsi

