import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/userupdate.dart';
import 'package:steelpanel/login/testlocal.dart';
import 'package:steelpanel/login/token.dart';
import 'package:http/http.dart' as http;
import 'package:steelpanel/screens/homescreen.dart';
import 'package:steelpanel/screens/pages/customers.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/screens/pages/logs.dart';
import 'package:steelpanel/screens/pages/suppliers.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import '../control/user-info.dart';
import '../models/currency-model.dart';

import 'dart:html' as html;

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  /////////
  String? _fileUrl;
  String? _base64File;
  String? _fileName;

  void _handleFileSelection(html.File file) {
    setState(() {
      _fileName = file.name;
    });
    _uploadFile(file);
  }

  // Function to open file picker
  void _openFilePicker() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept =
        'image/*'; // Specify accepted file types (e.g., images)
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        _handleFileSelection(file);
      }
    });
  }

  // Function to upload selected file (can be adapted to send file to server)
  void _uploadFile(html.File file) {
    final reader = html.FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((e) {
      final dataUrl = reader.result as String;
      final base64Data = dataUrl.split(',').last; // Extract base64 string
      setState(() {
        _fileUrl = reader.result as String;
        _base64File = base64Data;
        print('Encoded Base64 File: $_base64File');
        UserInfoControll.user_avatar.value = _base64File!;
      });

      // Call the function to send the base64 string to the server
      _sendBase64ToServer(_base64File!, 53); // Replace 123 with actual user_id
    });
  }

  // Function to send base64 string to server
  Future<void> _sendBase64ToServer(String base64File, int userId) async {
    final url = Uri.parse(
        'https://test.ht-hermes.com/add-photo.php'); // Replace with your server URL
    final response = await http.post(
      url,
      // headers: {
      //   'Content-Type': 'application/json',
      // },
      body: json.encode({
        'user_id': userId,
        'base64': base64File,
      }),
    );

    if (response.statusCode == 200) {
      print('Base64 file uploaded successfully');
      setState(() {});
      // refresh();
      EasyLoading.dismiss();
      AddtoLogs('تصویر پروفایل',
          'کاربر ${UserInfoControll.user_id} تصویر خود را تغییر داد');
    } else {
      print('Failed to upload base64 file: ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      EasyLoading.dismiss();
    }
  }

  ///

  PopupMenuItem _buildPopupMenuItem(String title, Function()? setAction) {
    return PopupMenuItem(
      onTap: setAction,
      child: Text(title),
    );
  }

//

  void _deleteCookie(String name) {
    html.document.cookie =
        '$name=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  //
  TextEditingController ironfee = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView(
        shrinkWrap: true, // اضافه شده
        // physics: NeverScrollableScrollPhysics(), // اضافه شده
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        children: [
          // MyCardWidget(
          //   onpress: () {
          //     // Navigator.pushAndRemoveUntil(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //       builder: (context) => TestPage(),
          //     //     ),
          //     //     (route) => false);
          //   },
          //   text: 'خرید / فروش',
          //   image: Image.asset(
          //     'assets/images/trade.gif',
          //     scale: 0.8,
          //   ),
          // ),

          MyCardWidget(
            onpress: () {
              print(UserInfoControll.userType.value);
              if (UserInfoControll.userType.value != 'Customers' &&
                  UserInfoControll.userType.value != 'Supplier') {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            // OrdersPage(
                            //       refresh: refresh,
                            //     )
                            HomeMain(
                                xxcontroller: SidebarXController(
                                    selectedIndex: 2, extended: true))),
                    (route) => false);
              } else {
                Get.defaultDialog(
                    title: 'خطا', middleText: 'مجوز دیدن این بخش را ندارید');
              }
            },
            text: 'سفارشات',
            image: Image.asset(
              'assets/images/orders.gif',
              scale: 0.8,
            ),
          ),
          MyCardWidget(
            onpress: () {
              if (UserInfoControll.userType.value != 'Customers' &&
                  UserInfoControll.userType.value != 'Supplier') {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeMain(
                            xxcontroller: SidebarXController(
                                selectedIndex: 4, extended: true))
                        // InvoicesPage(
                        //       refresh: refresh,
                        //     )

                        ),
                    (route) => false);
              } else {
                Get.defaultDialog(
                    title: 'خطا', middleText: 'مجوز دیدن این بخش را ندارید');
              }
            },
            text: 'فاکتورها',
            image: Image.asset(
              'assets/images/factors.gif',
              scale: 0.8,
            ),
          ),
          // MyCardWidget(
          //   onpress: () {
          //     fetchCustomers();

          //     setState(() {});
          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => HomeMain(
          //                 xxcontroller: SidebarXController(
          //                     selectedIndex: 1, extended: true))
          //             // CustomersPage(),
          //             ),
          //         (route) => false);
          //   },
          //   text: 'مشتریان',
          //   image: Image.asset(
          //     'assets/images/customers.gif',
          //     scale: 0.8,
          //   ),
          // ),
          MyCardWidget(
            onpress: () {
              Get.to(const LogsScreen());
            },
            text: 'کاتالوگ',
            image: Image.asset(
              'assets/images/report.gif',
              scale: 0.8,
            ),
          ),
          // MyCardWidget(
          //   onpress: () {
          //     Get.to(ConfirmedSuppliersPage());
          //   },
          //   text: 'تامیین کنندگان',
          //   image: Image.asset(
          //     'assets/images/supply.gif',
          //     scale: 0.8,
          //   ),
          // ),
          // MyCardWidget(
          //   onpress: () {},
          //   text: 'حمل و نقل',
          //   image: Image.asset(
          //     'assets/images/transfer.gif',
          //     scale: 0.8,
          //   ),
          // ),
          // MyCardWidget(
          //   onpress: () {
          //     void refresh() {
          //       setState(() {});
          //     }

          //     Navigator.pushReplacement(context, MaterialPageRoute(
          //       builder: (context) {
          //         return HomeMain(
          //             xxcontroller:
          //                 SidebarXController(selectedIndex: 1, extended: true));
          //       },
          //     ));

          //     // widget.controller.selectIndex(1);
          //     // تغییر index به صفحه اصلی homeController.intjer.value = 1;
          //     print('object');
          //     setState(() {});
          //   },
          //   text: 'مالی',
          //   image: Image.asset(
          //     'assets/images/money.gif',
          //     scale: 0.8,
          //   ),
          // ),
          UserInfoControll.userType == 'Customers'
              ? MyCardWidget(
                  image: Image.network(''),
                  onpress: () {},
                  text: '',
                )
              : Container(),
          UserInfoControll.userType == 'Customers'
              ? MyCardWidget(
                  onpress: () {
                    void refresh() {
                      setState(() {});
                    }

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return HomeMain(
                            xxcontroller: SidebarXController(
                                selectedIndex: 1, extended: true));
                      },
                    ));

                    // widget.controller.selectIndex(1);
                    // تغییر index به صفحه اصلی homeController.intjer.value = 1;
                    print('object');
                    setState(() {});
                  },
                  text: 'سفارشات',
                  image: Image.asset(
                    'assets/images/money.gif',
                    scale: 0.8,
                  ),
                )
              : const SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }
}
