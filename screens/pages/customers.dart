import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/api/req/confirmed-customers-create.dart';
import 'package:steelpanel/api/req/delete-confirmed-customers.dart';
import 'package:steelpanel/api/req/make-confirmed.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/models/confirmed-customers-model-create.dart';
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/customers_controller.dart';
import 'package:steelpanel/api/req/delete-customer.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/widgets/bottombutton.dart';
import 'package:steelpanel/widgets/newuser_textfield.dart';
import 'package:universal_html/html.dart' as html;
import 'package:persian_tools/persian_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

final CustomersController controller = Get.put(CustomersController());
final String url = '${apiService.apiurl}/customers/readcustomer.php';
final String confirmedUrl =
    '${apiService.apiurl}/customers/confirmed/confirmed-customers-read.php';

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

  static TextEditingController incname = TextEditingController();
  static TextEditingController manager_name = TextEditingController();
  static TextEditingController eghtsadi_code = TextEditingController();
  static TextEditingController shenase_code = TextEditingController();
  static TextEditingController tellnumber = TextEditingController();
  static TextEditingController postal_code = TextEditingController();
  static TextEditingController addrress = TextEditingController();
  static TextEditingController sabt_code = TextEditingController();
  static TextEditingController operator_name = TextEditingController();

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage>
    with SingleTickerProviderStateMixin {
  sentmessage() {
    setState(() {});
    Get.snackbar('title', 'message');
  }

  double screenWidth = 0;
  double screenHeight = 0;

  late TabController _tabController;
  List<int> cusid = [];
  List<int> userid = [];

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
  bool premiumCustomer = true;

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
            backgroundColor: const Color(0xFF2E2E48),
            bottom: TabBar(
              unselectedLabelColor: const Color.fromARGB(125, 255, 255, 255),
              controller: _tabController,
              labelStyle: const TextStyle(
                fontFamily: 'Byekan',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(
                  text: 'در انتظار',
                ),
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
                future: fetchConfirmedCustomers().then((value) => ids.clear()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('خطا در بارگذاری داده‌ها'));
                  } else {
                    ids.clear();
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
                    buttonColor: Colors.blueAccent,
                    cancelTextColor: Colors.blueAccent,
                    confirmTextColor: Colors.white,
                  );
                },
                icon: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black, offset: Offset.infinite),
                        ],
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.add, size: 30)),
              ),
            ),
          ),
        ),
        Expanded(
          child: GetBuilder<CustomersController>(
            builder: (controller) {
              return controller.jsonData.isNotEmpty
                  ? Obx(
                      () => Wrap(
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: screenWidth,
                              height: 20,
                              color: Colors.grey,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: const Text('نام مسئول')),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                          color: Colors.red,
                                          alignment: Alignment.center,
                                          child: const Text('نام شرکت'))),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          alignment: Alignment.center,
                                          color: Colors.amber,
                                          child: const Text('شماره اقتصادی'))),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          color: Colors.purple,
                                          alignment: Alignment.center,
                                          child: const Text('شماره ملی'))),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          alignment: Alignment.center,
                                          color: Colors.green,
                                          child: const Text('شماره تلفن')))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              width: screenWidth,
                              height: screenHeight,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(5),
                                itemCount: controller.jsonData.length,
                                itemBuilder: (context, index) {
                                  final customerData = Map<String, String>.from(
                                      controller.jsonData[index]);

                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('جزئیات مشتری'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: customerData.entries
                                                    .map((entry) => Text(
                                                        '${entry.key}: ${entry.value}'))
                                                    .toList(),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('بستن'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Container(
                                        width: screenWidth,
                                        height: 70,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0),
                                                child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                      // color: Colors.red,
                                                      child: Obx(
                                                        () => Checkbox(
                                                          value: selectedCustomers
                                                              .contains(
                                                                  customerData),
                                                          onChanged:
                                                              (bool? value) {
                                                            if (value == true) {
                                                              selectedCustomers.add(
                                                                  customerData);
                                                              if (customerData
                                                                      .containsKey(
                                                                          'id') &&
                                                                  customerData
                                                                      .containsKey(
                                                                          'usr')) {
                                                                int? id = int.tryParse(
                                                                    customerData[
                                                                            'id'] ??
                                                                        '');

                                                                int? userID =
                                                                    int.tryParse(
                                                                        customerData['usr'] ??
                                                                            '');
                                                                if (id !=
                                                                        null &&
                                                                    !ids.contains(
                                                                        id)) {
                                                                  ids.add(id);
                                                                }
                                                                //
                                                                if (userID !=
                                                                        null &&
                                                                    !userid.contains(
                                                                        userID)) {
                                                                  userid.add(
                                                                      userID);
                                                                }
                                                                //
                                                                print(
                                                                    'ine $userID');
                                                              }
                                                              print(
                                                                  selectedCustomers);
                                                              print(ids);
                                                            } else {
                                                              selectedCustomers
                                                                  .remove(
                                                                      customerData);
                                                              if (customerData
                                                                  .containsKey(
                                                                      'id')) {
                                                                int? id = int.tryParse(
                                                                    customerData[
                                                                            'id'] ??
                                                                        '');
                                                                if (id !=
                                                                    null) {
                                                                  ids.remove(
                                                                      id);
                                                                }
                                                              }
                                                              print(
                                                                  selectedCustomers);
                                                              print(ids);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        // color: Colors.orange,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          customerData[
                                                              'responsible_name']!,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    'از  ${customerData['company_name']}'),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(convertEnToFa(
                                                    '${customerData['economic_code']}')),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(convertEnToFa(
                                                    '${customerData['national_id']}')),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(convertEnToFa(
                                                      '${customerData['phone_number']}')),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: screenWidth * .7,
                      height: screenHeight * .8,
                      child: Image.asset('assets/images/noresult.png'),
                    );
            },
          ),
        ),
        if (controller.jsonData.isNotEmpty)
          Center(
            child: Container(
              color: Colors.blueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bottombutton(
                    onpress: () async {
                      if (
                          // UserInfoControll.userType.value == 'Commerce' ||
                          // UserInfoControll.userType.value == 'SellOperator' ||
                          UserInfoControll.userType.value == 'oprator' ||
                              UserInfoControll.userType.value == 'Admin') {
                        print(selectedCustomers);
                        // deleteCustomers(ids);
                        selectedCustomers.clear();
                        setState(() {});
                      } else {
                        Get.defaultDialog(
                            title: 'خطا',
                            middleText: 'مجوز تایید پاک کردن مشتری را ندارید');
                      }
                      cusid.clear();
                      cusid.addAll(ids);
                      print('this is cusid $cusid');
                      print('this is $cusid');
                      await transferCustomers(cusid, userid[0], context);
                      // await updateUser(
                      //     cusid[0].toString());

                      setState(() {});
                      // Get.defaultDialog(
                      //     backgroundColor:
                      //         const Color.fromARGB(255, 226, 219, 219),
                      //     title: 'تایید شود ؟',
                      //     titleStyle: const TextStyle(
                      //         fontFamily: 'Irs',
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.w600),
                      //     content: Directionality(
                      //       textDirection: TextDirection.rtl,
                      //       child: Container(
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Container(
                      //                     child: const Text(
                      //                       'کاربر ویژه',
                      //                       style: TextStyle(
                      //                         fontFamily: 'Irs',
                      //                         fontSize: 15,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   Directionality(
                      //                     textDirection: TextDirection.ltr,
                      //                     child: SizedBox(
                      //                       // width: 150,
                      //                       height: 30,
                      //                       child: ToggleSwitch(
                      //                         activeBgColor: const [
                      //                           Colors.white
                      //                         ],
                      //                         initialLabelIndex: 0,
                      //                         totalSwitches: 2,
                      //                         customTextStyles: const [
                      //                           TextStyle(color: Colors.black)
                      //                         ],
                      //                         labels: const [
                      //                           'خیر',
                      //                           'بله',
                      //                         ],
                      //                         onToggle: (index) {
                      //                           print('switched to: $index');
                      //                         },
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 25,
                      //             ),
                      //             SizedBox(
                      //               width: 180,
                      //               child: Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Expanded(
                      //                     child: OutlinedButton(
                      //                         style: ButtonStyle(
                      //                             backgroundColor:
                      //                                 MaterialStatePropertyAll<
                      //                                     Color>(Colors.white)),
                      //                         onPressed: () async {
                      //                           print('this is $cusid');
                      //                           await transferCustomers(
                      //                               cusid, userid[0], context);
                      //                           // await updateUser(
                      //                           //     cusid[0].toString());

                      //                           setState(() {});
                      //                         },
                      //                         child: const Text(
                      //                           'تایید',
                      //                           style: TextStyle(
                      //                             color: Colors.black,
                      //                             fontFamily: 'Irs',
                      //                             fontSize: 15,
                      //                           ),
                      //                         )),
                      //                   ),
                      //                   Expanded(
                      //                     child: OutlinedButton(
                      //                         onPressed: () {
                      //                           Navigator.of(context).pop();
                      //                         },
                      //                         child: const Text(
                      //                           'لغو',
                      //                           style: TextStyle(
                      //                             color: Colors.black,
                      //                             fontFamily: 'Irs',
                      //                             fontSize: 15,
                      //                           ),
                      //                         )),
                      //                   ),
                      //                 ],
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ));
                      setState(() {
                        // final toRemove = <Map<String, String>>[];
                        // for (var customer in selectedCustomers) {
                        //   controller.updateCustomerList(customer);
                        //   toRemove.add(customer);
                        // }
                        // controller.jsonData.removeWhere(
                        //   (customer) => toRemove.contains(customer),
                        // );
                        // selectedCustomers.clear();
                      });
                    },
                    txt: const Text(
                      'ثبت مشتری',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  bottombutton(
                    onpress: () {
                      if (
                          // UserInfoControll.userType.value == 'Commerce' ||
                          //   UserInfoControll.userType.value == 'SellOperator' ||
                          UserInfoControll.userType.value == 'oprator' ||
                              UserInfoControll.userType.value == 'Admin') {
                        print(selectedCustomers);
                        deleteCustomers(ids);
                        selectedCustomers.clear();
                        setState(() {});
                      } else {
                        Get.defaultDialog(
                            title: 'خطا',
                            middleText: 'مجوز تایید پاک کردن مشتری را ندارید');
                      }
                    },
                    txt: const Text('پاک کردن'),
                  ),
                ],
              ),
            ),
          )
        else
          const Text('رکوردی یافت نشد'),
      ],
    );
  }

  Widget buildConfirmedTab() {
    return

        // GetBuilder<CustomersController>(
        //   builder: (controller) {
        //     return controller.confirmedCustomers.isNotEmpty
        // ?

        Obx(() {
      if (controller.confirmedCustomers.isEmpty) {
        return const Center(child: Text('هیچ مشتری تأیید شده‌ای وجود ندارد.'));
      } else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('نام مشتری'))),
                    Expanded(
                        flex: 12,
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('شناسه'))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: const Text('عملیات'))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.confirmedCustomers.length,
                itemBuilder: (context, index) {
                  final customerData = controller.confirmedCustomers[index];
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          print('object');
                          Get.defaultDialog(
                              title: 'جزئیات مشتری',
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              customerData['responsible_name']),
                                          const Text(':نام مسئول'),
                                        ],
                                      ),

                                      ////

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(customerData['company_name']),
                                          const Text(':نام کمپانی'),
                                        ],
                                      ),

                                      //

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(customerData['has_open_order'] ==
                                                  0
                                              ? 'ندارد'
                                              : 'دارد'),
                                          const Text(':سفارش باز'),
                                        ],
                                      ),

                                      //
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(customerData['id'].toString()),
                                          const Text(':آیدی مشتری'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Container(
                            alignment: Alignment.center,
                            child: Text(
                              customerData['economic_code']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          leading: SizedBox(
                            width: screenWidth * 0.1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit)),
                                ),
                                Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        print('object');
                                        print('in index : $index');
                                        print(customerData['id']);
                                        List<int> idc = [];
                                        idc.add(customerData['id']);
                                        deleteConfirmCustomers(idc);
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.delete_forever)),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      _exportToExcel(customerData);
                                    },
                                    icon: const Icon(Icons.output),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Container(
                            alignment: Alignment.center,
                            child: Text(customerData['national_id']!),
                          ),
                          trailing: Container(
                            // color: Colors.red,
                            alignment: Alignment.centerRight,
                            width: screenWidth * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Container(
                                        // color: Colors.red,
                                        child: Text(
                                            '${customerData['company_name']!}  '))),
                                Expanded(
                                    child: Container(
                                        // color: Colors.blue,
                                        child: Text(
                                            ' از ${customerData['responsible_name']!}'))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: CircleAvatar(
                                      child: Text(
                                          customerData['company_name']![0]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    });
    // : Container(
    //     width: screenWidth * .7,
    //     height: screenHeight * .8,
    //     child: Image.asset('assets/images/noresult.png'),
    //   );
    //   },
    // );
  }

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
        AddtoLogs('مشتریان', 'ثبت شد  : ${CustomersPage.manager_name.text}');
        print(jsonDecode(response.body));
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error submitting form: $e');
    }
  }

  // void _submitForm(Map<String, String> formDatasend) async {
  //   final String url =
  //       'http://test.ht-hermes.com/customers/create-newcustomer.php';
  //   try {
  //     var response = await http.post(
  //       Uri.parse(url),
  //       body: jsonEncode(formDatasend),
  //     );

  //     if (response.statusCode == 201) {
  //       print('Form submitted successfully');
  //       print(jsonDecode(response.body));
  //     } else {
  //       print('Failed to submit form. Status code: ${response.statusCode}');
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     print('Error submitting form: $e');
  //   }
  // }

  void _exportToExcel(Map<String, dynamic> customerData) {
    final List<List<dynamic>> csvData = [];

    csvData.add(['پارامتر', 'مقدار']);

    customerData.forEach((key, value) {
      csvData.add([key, value.toString()]); // Convert value to string
    });

    String csvString = const ListToCsvConverter().convert(csvData);

    final blob = html.Blob([csvString]);

    final anchor =
        html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
          ..setAttribute('download', 'customer_data.csv');

    anchor.click();
  }

  Future<void> updateUser(String customerId) async {
    final String url = '${apiService.apiurl}/users/update_usr_advanced.php';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
          {"user_id": customerId, "userTypeid": "Customers", "verified": 1}),
    );

    if (response.statusCode == 200) {
      print('ok update shod');
      print(response.body);

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomeMain(
            xxcontroller: SidebarXController(selectedIndex: 0, extended: true),
          );
        },
      ));
      // مخفی کردن بارگذاری اندیکاتور
      Get.back();
      sentmessage();
      Get.defaultDialog(
        title: 'اطلاعات شما با موفقیت ثبت شد',
        middleText: 'در حال رسیدگی به تایید اطلاعات شما',
        titleStyle: const TextStyle(
          fontFamily: 'Irs',
          fontSize: 15,
          color: Colors.white,
        ),
      );
    } else {
      print('Failed to update user data. Status code: ${response.statusCode}');
      print(response.body);
    }
  }
}
