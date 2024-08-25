import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
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
import 'package:steelpanel/screens/user-panel/customers/add-order-customer.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import '../../../control/user-info.dart';
import '../../../models/currency-model.dart';

import 'dart:html' as html;

class CustomerPanel extends StatefulWidget {
  const CustomerPanel({super.key});

  @override
  State<CustomerPanel> createState() => _CustomerPanelState();
}

class _CustomerPanelState extends State<CustomerPanel> {
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

  void _IdentidyError() {
    MotionToast(
      icon: Icons.warning_amber_rounded,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        'پیام سیستم',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(
        'ابتدا احراز هویت را کامل کنید ویا در صورت انجام احراز هویت ، برای تایید  منتظر بمانید',
        textAlign: TextAlign.end,
      ),
      position: MotionToastPosition.top,
      width: 350,
      height: 100,
    ).show(context);
  }

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

          MyCardCostumers(
            onpress: () {
              print(UserInfoControll.verify.value);
              if (UserInfoControll.verify.value == true) {
                print(UserInfoControll.userType.value);
                refresh() {
                  // setState(() {});
                }
                // checkCustomerId(UserInfoControll.userTypeId.value.toString());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeMain(
                            xxcontroller: SidebarXController(
                                selectedIndex: 1, extended: true))
                        // InvoicesPage(
                        //       refresh: refresh,
                        //     )

                        ),
                    (route) => false);

                // print(UserInfoControll.user_id.value.toString());

                // OrdersCustomers();
                // Get.bottomSheet(OrdersCustomers());
                // return showModalBottomSheet<dynamic>(
                //   isScrollControlled: true,
                //   context: context,
                //   builder: (context) {
                //     return OrdersCustomers(refresh: refresh);
                //   },
                // );
              } else {
                _IdentidyError();
              }
            },
            text: 'ثبت سفارش',
            icon: Icon(
              Icons.production_quantity_limits,
              size: screenWidth * 0.08,
              color: const Color(0xFF2E2E48),
            ),
          ),
          MyCardCostumers(
            onpress: () {
              if (UserInfoControll.verify.value == true) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeMain(
                            xxcontroller: SidebarXController(
                                selectedIndex: 2, extended: true))
                        // InvoicesPage(
                        //       refresh: refresh,
                        //     )

                        ),
                    (route) => false);
              } else {
                _IdentidyError();
              }
            },
            text: 'پیگیری سفارش',
            icon: Icon(
              Icons.receipt,
              size: screenWidth * 0.08,
              color: const Color(0xFF2E2E48),
            ),
          ),

          MyCardCostumers(
            onpress: () {},
            text: 'سفارشات اخیر',
            icon: Icon(
              Icons.history_toggle_off,
              size: screenWidth * 0.08,
              color: const Color(0xFF2E2E48),
            ),
          ),

          MyCardCostumers(
            onpress: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => TestPage(),
              //     ),
              //     (route) => false);
            },
            text: 'کاتالوگ',
            icon: Icon(
              Icons.document_scanner,
              size: screenWidth * 0.08,
              color: const Color(0xFF2E2E48),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkCustomerId(String customerId) async {
    final response = await http.get(Uri.parse(
        'https://test.ht-hermes.com/customers/confirmed/confirmed-customers-read.php?id=$customerId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['id'].toString() == customerId) {
        _showCustomerDialog(data['responsible_name'], data['company_name'],
            data['has_open_order'] == 1 ? 'دارد/محدودیت سفارش' : 'ندارد');
        setState(() {
          OrdersCustomers.isCustomerVerified =
              data['has_open_order'] == 0 ? true : false;

          OrdersCustomers.showId = data['has_open_order'] == 0 ? false : true;
          OrdersCustomers.showInfo = data['has_open_order'] == 0 ? true : false;
          OrdersCustomers.customerName = data['responsible_name'];
          OrdersCustomers.companyName = data['company_name'];
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeMain(
                    xxcontroller:
                        SidebarXController(selectedIndex: 1, extended: true))
                // InvoicesPage(
                //       refresh: refresh,
                //     )

                ),
            (route) => false);
      } else {
        _showErrorDialog('مشخصات یافت نشد');
        setState(() {
          OrdersCustomers.isCustomerVerified = false;
        });
      }
    } else {
      _showErrorDialog('مشکلی در دریافت داده');
      setState(() {
        OrdersCustomers.isCustomerVerified = false;
      });
    }
  }

  // dialogs customer

  void _showCustomerDialog(
      String customerName, String companyName, String hasOpenOrder) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '! مشخصات یافت شد',
            style: TextStyle(fontFamily: 'Irs'),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text('نام مشتری: $customerName',
                      style: const TextStyle(fontFamily: 'Irs')),
                  Text('نام کمپانی : $companyName',
                      style: const TextStyle(fontFamily: 'Irs')),
                  Text('سفارش باز : $hasOpenOrder')
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('! خطا '),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }
}

class MyCardCostumers extends StatefulWidget {
  const MyCardCostumers({
    super.key,
    required this.icon,
    required this.text,
    required this.onpress,
  });
  final Icon icon;
  final String text;
  final Function() onpress;

  @override
  State<MyCardCostumers> createState() => _MyCardCostumersState();
}

class _MyCardCostumersState extends State<MyCardCostumers> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Card(
          elevation: 5,
          child: GestureDetector(
            onTap: widget.onpress,
            child: Container(
              decoration: BoxDecoration(
                color: isHovered ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            color: isHovered ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.icon)),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: isHovered ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.text,
                            style: const TextStyle(
                                fontFamily: 'Byekan',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )))
                ],
              ),
            ),
          )),
    );
  }
}
