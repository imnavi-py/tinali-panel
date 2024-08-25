import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

class User {
  final String userId;
  final String username;
  final String password;
  final bool isAdmin;
  final String? name;
  final String? lastname;
  final String? unit;
  final String? number;
  final String userType;
  final String? token;

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.isAdmin,
    this.name,
    this.lastname,
    this.unit,
    this.number,
    required this.userType,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      password: json['password'],
      isAdmin: json['isadmin'] == 1,
      name: json['name'],
      lastname: json['lastname'],
      unit: json['unit'],
      number: json['number'],
      userType: json['userType'],
      token: json['token'],
    );
  }
}

class UsersConfig extends StatefulWidget {
  const UsersConfig({super.key});

  @override
  _UsersConfigState createState() => _UsersConfigState();
}

class _UsersConfigState extends State<UsersConfig> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
        Uri.parse('https://test.ht-hermes.com/users-config/read-users.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await http.delete(Uri.parse(
        'https://test.ht-hermes.com/users-config/delete-user.php/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        futureUsers = fetchUsers();
      });
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse(
          'https://test.ht-hermes.com/users-config/update-user.php/${user.userId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': user.username,
        'password': user.password,
        'isadmin': user.isAdmin ? 1 : 0,
        'name': user.name,
        'lastname': user.lastname,
        'unit': user.unit,
        'number': user.number,
        'userType': user.userType,
        'token': user.token,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        futureUsers = fetchUsers();
      });
    } else {
      throw Exception('Failed to update user');
    }
  }

  void showUserActions(User user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('پاک کردن'),
              onTap: () {
                Navigator.pop(context);
                deleteUser(user.userId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('آپدیت مشخصات'),
              onTap: () {
                Navigator.pop(context);
                showUpdateUserDialog(user);
              },
            ),
          ],
        );
      },
    );
  }

  void showUpdateUserDialog(User user) {
    final TextEditingController usernameController =
        TextEditingController(text: user.username);
    final TextEditingController passwordController =
        TextEditingController(text: user.password);
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController lastnameController =
        TextEditingController(text: user.lastname);
    final TextEditingController unitController =
        TextEditingController(text: user.unit);
    final TextEditingController numberController =
        TextEditingController(text: user.number);
    final TextEditingController userTypeController =
        TextEditingController(text: user.userType);
    final TextEditingController tokenController =
        TextEditingController(text: user.token);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('آپدیت مشخصات'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username')),
                TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password')),
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name')),
                TextField(
                    controller: lastnameController,
                    decoration: const InputDecoration(labelText: 'Lastname')),
                TextField(
                    controller: unitController,
                    decoration: const InputDecoration(labelText: 'Unit')),
                TextField(
                    controller: numberController,
                    decoration: const InputDecoration(labelText: 'Number')),
                TextField(
                    controller: userTypeController,
                    decoration: const InputDecoration(labelText: 'User Type')),
                TextField(
                    controller: tokenController,
                    decoration: const InputDecoration(labelText: 'Token')),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                User updatedUser = User(
                  userId: user.userId,
                  username: usernameController.text,
                  password: passwordController.text,
                  isAdmin: user.isAdmin,
                  name: nameController.text,
                  lastname: lastnameController.text,
                  unit: unitController.text,
                  number: numberController.text,
                  userType: userTypeController.text,
                  token: tokenController.text,
                );
                updateUser(updatedUser);
                Navigator.pop(context);
              },
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
      appBar: AppBar(backgroundColor: Colors.blue, title: const Text('Users')),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Card(
                    child: InkWell(
                      onTap: () => showUserActions(user),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Username: ${user.username}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Name: ${user.name} ${user.lastname}'),
                            Text('Unit: ${user.unit}'),
                            Text('Number: ${user.number}'),
                            Text('User Type: ${user.userType}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
