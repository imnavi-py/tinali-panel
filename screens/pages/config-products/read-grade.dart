import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:steelpanel/api/config.dart';

class GradeList extends StatefulWidget {
  const GradeList({super.key});

  @override
  _GradeListState createState() => _GradeListState();
}

class _GradeListState extends State<GradeList> {
  List<dynamic> grades = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGrades();
  }

  Future<void> fetchGrades() async {
    try {
      final response = await http
          .get(Uri.parse('${apiService.apiurl}/grade/read-grade.php'));
      if (response.statusCode == 200) {
        setState(() {
          grades = jsonDecode(response.body)['grades'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load grades');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addGrade(String name) async {
    try {
      final response = await http.post(
        Uri.parse('${apiService.apiurl}/grade/add-grade.php'),
        // headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name}),
      );
      if (response.statusCode == 201) {
        fetchGrades();
      } else {
        throw Exception('Failed to add grade');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add grade')),
      );
    }
  }

  void _showAddGradeDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Grade'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter grade name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  addGrade(nameController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
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
      appBar: AppBar(
        title: const Text('Grade List'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : grades.isEmpty
              ? const Center(child: Text('No grades found'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3.0,
                    ),
                    itemCount: grades.length + 1, // Add 1 for the add button
                    itemBuilder: (context, index) {
                      if (index == grades.length) {
                        return Card(
                          elevation: 3.0,
                          child: InkWell(
                            onTap: _showAddGradeDialog,
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 40.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        );
                      }
                      return Card(
                        elevation: 3.0,
                        child: ListTile(
                          trailing: TextButton(
                              onPressed: () {}, child: const Text('مشخصات')),
                          leading: const Icon(Icons.grade),
                          title: Text(
                            grades[index]['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            // Handling item tap
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
