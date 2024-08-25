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
import 'package:steelpanel/widgets/login/testlocal.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import '../../control/user-info.dart';
import '../../models/currency-model.dart';

import 'dart:html' as html;

class GuestsPanel extends StatefulWidget {
  const GuestsPanel({super.key});

  @override
  State<GuestsPanel> createState() => _GuestsPanelState();
}

class _GuestsPanelState extends State<GuestsPanel> {
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

  void exitTouserType() {
    MotionToast(
      toastDuration: Durations.extralong2,
      icon: Icons.login,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        'پیام سیستم',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('لطفا وارد شوید'),
      position: MotionToastPosition.top,
      width: 350,
      height: 100,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              updateUserType(
                  UserInfoControll.user_id.value.toString(), 'Customers');
            },
            text: 'خریدارم',
            image: Image.asset(
              'assets/images/customerpic.png',
              scale: 0.8,
            ),
          ),
          MyCardWidget(
            onpress: () {
              updateUserType(
                  UserInfoControll.user_id.value.toString(), 'Seller');
            },
            text: 'فروشندم',
            image: Image.asset(
              'assets/images/supplierpic.png',
              scale: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateUserType(String userID, String userType) async {
    const String apiUrl =
        "https://test.ht-hermes.com/users/update_usr_advanced.php"; // آدرس API خود را وارد کنید

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{'user_id': userID, 'userType': userType.toString()},
      ),
    );

    if (response.statusCode == 200) {
      // Parsing the response as a Map
      final responseData = jsonDecode(response.body);

      // Check if responseData is a Map and contains the desired key
      UserInfoControll.userType.value = responseData['userType'] ?? '';
      // Refresh the UI
      setState(() {});

      // Navigate to LoginPageSk
      _deleteCookie('textfield_value=');
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return LoginPageSk();
        },
      ));
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);
    }
  }
}
