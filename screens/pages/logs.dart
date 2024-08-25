import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:steelpanel/api/config.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<dynamic> logs = [];

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    final response =
        await http.get(Uri.parse('${apiService.apiurl}/logs/read-logs.php'));

    if (response.statusCode == 200) {
      setState(() {
        logs = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load logs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'گزارشات',
          style: TextStyle(fontFamily: 'Irs', color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: logs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Row(
                      children: [
                        Text(
                          'فرایند: ${logs[index]['process']}',
                          style: const TextStyle(
                              fontFamily: 'Irs', color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'بخش: ${logs[index]['unit']}',
                          style: const TextStyle(
                              fontFamily: 'Irs',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'زمان: ${logs[index]['date']}',
                      style: const TextStyle(
                          fontFamily: 'Irs',
                          color: Color.fromARGB(255, 255, 136, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
