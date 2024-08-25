import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/customers_controller.dart';
import 'package:steelpanel/api/req/delete-customer.dart';
import 'package:steelpanel/widgets/bottombutton.dart';
import 'package:steelpanel/widgets/newuser_textfield.dart';
import 'package:universal_html/html.dart' as html;
import 'package:persian_tools/persian_tools.dart';

final CustomersController controller = Get.put(CustomersController());
const String url = 'https://test.ht-hermes.com/customers/readcustomer.php';
const String confirmedUrl =
    'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php';

Future<void> fetchCustomers() async {
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> newCustomers = jsonDecode(response.body);
      controller.updateCustomers(newCustomers);
    } else {
      print('Failed to load customers. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading customers: $e');
  }
}

Future<void> fetchConfirmedCustomers() async {
  try {
    var response = await http.get(Uri.parse(confirmedUrl));
    if (response.statusCode == 200) {
      print('confirmed');
      List<dynamic> confirmedCustomers = jsonDecode(response.body);
      controller.updateConfirmedCustomers(confirmedCustomers);
    } else {
      print(
          'Failed to load confirmed customers. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading confirmed customers: $e');
  }
}

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  static final TextEditingController incname = TextEditingController();
  static final TextEditingController manager_name = TextEditingController();
  static final TextEditingController eghtsadi_code = TextEditingController();
  static final TextEditingController shenase_code = TextEditingController();
  static final TextEditingController tellnumber = TextEditingController();
  static final TextEditingController postal_code = TextEditingController();
  static final TextEditingController addrress = TextEditingController();
  static final TextEditingController sabt_code = TextEditingController();
  static final TextEditingController operator_name = TextEditingController();

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage>
    with SingleTickerProviderStateMixin {
  double screenWidth = 0;
  double screenHeight = 0;

  late TabController _tabController;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final CustomersController controller = Get.put(CustomersController());
  final RxSet<Map<String, String>> selectedCustomers =
      <Map<String, String>>{}.obs;
  List<int> ids = [];

  Future<void> _submitForm(Map<String, String> formDatasend) async {
    const String url =
        'http://test.ht-hermes.com/customers/create-newcustomer.php';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(formDatasend),
      );

      if (response.statusCode == 201) {
        print('Form submitted successfully');
        print(jsonDecode(response.body));
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }

  Future<void> deleteCustomers(List<int> ids) async {
    final url = Uri.parse(
        'http://test.ht-hermes.com/customers/delete-customer.php'); // URL سرور شما

    try {
      // ارسال درخواست POST به سرور
      var response = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{'ids': ids}),
      );

      if (response.statusCode == 200) {
        // با موفقیت اجرا شد، می‌توانید پاسخ را نمایش دهید
        print('Response: ${response.body}');
      } else {
        // اگر هر گونه خطا رخ داد
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting customers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 226, 219, 219),
          appBar: AppBar(
            leading: IconButton(
              iconSize: 25,
              color: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      controller:
                          SidebarXController(selectedIndex: 0, extended: true),
                    ),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.home),
            ),
            title: const Text(
              'مدیریت مشتریان',
              style: TextStyle(fontFamily: 'Byekan', color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            bottom: TabBar(
              controller: _tabController,
              labelStyle: const TextStyle(
                fontFamily: 'Byekan',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(text: 'در انتظار'),
                Tab(text: 'تأیید شده'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              FutureBuilder<void>(
                future: fetchCustomers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('خطا در بارگذاری داده‌ها'));
                  } else {
                    return buildPendingTab();
                  }
                },
              ),
              FutureBuilder<void>(
                future: fetchConfirmedCustomers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('خطا در بارگذاری داده‌ها'));
                  } else {
                    return buildConfirmedTab();
                  }
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _tabController.animateTo((_tabController.index + 1) % 2);
            },
            child: const Icon(Icons.swap_horiz),
          ),
        ),
      ),
    );
  }

  Widget buildPendingTab() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {
                  CustomersPage.incname.clear();
                  CustomersPage.eghtsadi_code.clear();
                  CustomersPage.manager_name.clear();
                  CustomersPage.shenase_code.clear();
                  CustomersPage.tellnumber.clear();
                  CustomersPage.postal_code.clear();
                  CustomersPage.addrress.clear();
                  CustomersPage.sabt_code.clear();
                  CustomersPage.operator_name.clear();

                  Get.defaultDialog(
                    barrierDismissible: true,
                    backgroundColor: Colors.white,
                    title: 'ثبت مشتری جدید',
                    titleStyle: const TextStyle(fontFamily: 'BYekan'),
                    content: const Center(child: MyTextFieldnu()),
                    onCancel: () {},
                    textCancel: 'انصراف',
                    onConfirm: () async {
                      Map<String, String> formDatasend = {
                        'company_name': CustomersPage.incname.text,
                        'responsible_name': CustomersPage.manager_name.text,
                        'national_id': CustomersPage.shenase_code.text,
                        'economic_code': CustomersPage.eghtsadi_code.text,
                        'postal_code': CustomersPage.postal_code.text,
                        'phone_number': CustomersPage.tellnumber.text,
                        'address': CustomersPage.addrress.text,
                        'operator_name': CustomersPage.operator_name.text,
                        'registration_number': CustomersPage.sabt_code.text,
                      };
                      await _submitForm(formDatasend);

                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    textConfirm: 'ثبت',
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ),
        Obx(() {
          if (controller.jsonData.isEmpty) {
            return const Text('هیچ مشتری در حال انتظاری وجود ندارد');
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: controller.jsonData.length,
                itemBuilder: (context, index) {
                  var customer = controller.jsonData[index];
                  return ListTile(
                    title: Text(customer['company_name']),
                    subtitle: Text('کد اقتصادی: ${customer['economic_code']}'),
                    trailing: Checkbox(
                      value: selectedCustomers.contains(customer),
                      onChanged: (checked) {
                        setState(() {
                          if (checked!) {
                            selectedCustomers.add(customer);
                            ids.add(int.parse(customer['id']));
                          } else {
                            selectedCustomers.remove(customer);
                            ids.remove(int.parse(customer['id']));
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            );
          }
        }),
        bottombutton(
          txt: const Text('حذف مشتریان انتخاب شده'),
          onpress: () async {
            if (ids.isNotEmpty) {
              await deleteCustomers(ids);
              await fetchCustomers();
              selectedCustomers.clear();
              ids.clear();
            } else {
              print('لطفاً حداقل یک مشتری را انتخاب کنید.');
            }
          },
        ),
      ],
    );
  }

  Widget buildConfirmedTab() {
    return Obx(() {
      if (controller.confirmedCustomers.isEmpty) {
        return const Center(child: Text('هیچ مشتری تأیید شده‌ای وجود ندارد.'));
      } else {
        return ListView.builder(
          itemCount: controller.confirmedCustomers.length,
          itemBuilder: (context, index) {
            var customer = controller.confirmedCustomers[index];
            return ListTile(
              title: Text(customer['company_name']),
              subtitle: Text('کد اقتصادی: ${customer['economic_code']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await deleteCustomers([int.parse(customer['id'])]);
                  await fetchConfirmedCustomers();
                },
              ),
            );
          },
        );
      }
    });
  }
}
