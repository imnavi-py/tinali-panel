import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/add-log.dart';
import 'package:steelpanel/api/req/currency-req.dart';
import 'package:steelpanel/api/userupdate.dart';
import 'package:steelpanel/control/user-info.dart';
// import 'package:steelpanel/login/saveddata.dart';
// import 'package:steelpanel/login/token.dart';
import 'package:steelpanel/models/currency-model.dart';
import 'package:steelpanel/models/read-order-model.dart';
import 'package:steelpanel/screens/buyandsell.dart';
import 'package:steelpanel/screens/factors.dart';
import 'package:steelpanel/screens/pages/adduserhome.dart';
import 'package:steelpanel/screens/pages/config-products/read-grade.dart';
import 'package:steelpanel/screens/pages/customers.dart';
import 'package:steelpanel/screens/pages/home-controller.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/screens/pages/logs.dart';
import 'package:steelpanel/screens/pages/orders.dart';
// import 'package:steelpanel/login/testlocal.dart';
import 'package:steelpanel/api/req/fetch-customers.dart';
import 'package:steelpanel/screens/pages/suppliers.dart';
import 'package:steelpanel/screens/pages/testpage.dart';
import 'package:steelpanel/screens/user-panel/customers/customer-panel.dart';
import 'package:steelpanel/screens/user-panel/guest-panel.dart';
import 'package:steelpanel/utils/dialog_functions.dart';
import 'package:steelpanel/utils/state_date.dart';
import 'package:steelpanel/widgets/login/testlocal.dart';
import 'package:steelpanel/widgets/login/token.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import 'dart:html' as html;
import '../data/admin_info.dart';
import 'pages/users-config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});
  final SidebarXController controller;

  static List<AdminInfo> logininfo = [];
  static String user_name = '';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  //
  TextEditingController ironfee = TextEditingController();
  final CurrencyController currencyController = Get.put(CurrencyController());
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
      _sendBase64ToServer(_base64File!,
          UserInfoControll.user_id.value); // Replace 123 with actual user_id
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
      refresh();
      EasyLoading.dismiss();
      AddtoLogs('تصویر پروفایل',
          'کاربر ${UserInfoControll.user_id} تصویر خود را تغییر داد');
    } else {
      print('Failed to upload base64 file: ${response.reasonPhrase}');
      print('Response body: ${response.body}');
      EasyLoading.dismiss();
    }
  }

  void refresh() {
    setState(() {});
  }

  late SidebarXController controllerx;
  final controller = Get.put(DialogFuncs());
  // final check_void = Get.put(checkdialog());

  TextEditingController newUserName = TextEditingController();
  TextEditingController newUserPassword = TextEditingController();
  final List<String> genderItems = [
    // 'Guest','Admin','Customers','Seller','Moneyoperator','MoneyAdmin','SuperAdmin','Supporter'
    'مدیر', 'اپراتور واحد مالی', 'مدیر واحد مالی', 'خریدار و فروشنده'
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  void _deleteCookie(String name) {
    html.document.cookie =
        '$name=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Uint8List convertBase64Image(String base64String) {
    final base64Stripped = base64String.split(',').last;
    // print(
    //     'in Strip shodeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee : ${base64Decode(base64Stripped)}');
    return base64Decode(base64Stripped);
  }

  // void convertBase64() {
  //   convertBase64Image(UserInfoControll.testavatar);
  // }

  @override
  void initState() {
    // MyApp.fetchDb();
    super.initState();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    // print('inam az in : ${UserInfoControll.user_avatar}');
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Visibility(
        visible: UserInfoControll.userType.value == 'Admin' ? true : false,
        child: Drawer(
          backgroundColor: const Color.fromARGB(255, 226, 219, 219),
          child: Container(
            color: const Color.fromARGB(255, 226, 219, 219),
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    // check_void.servicedialog();
                    showModalBottomSheet(
                      showDragHandle: true,
                      enableDrag: true,
                      backgroundColor: const Color.fromARGB(255, 226, 219, 219),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Container()),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 130,
                                                height: 30,
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                      height: 0.5),
                                                  controller: ironfee,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hoverColor: Colors.blue,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                child: const Text(
                                                    '  : تعیین قیمت آهن'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 130,
                                                height: 30,
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                      height: 0.5),
                                                  // controller: ironfee,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hoverColor: Colors.blue,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                child: const Text(
                                                    '  : تعیین حداکثر سطح'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Get.to(GradeList());
                                                    },
                                                    child: const Text(
                                                        'مدیریت گرید ها')),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Get.to(
                                                          ConfirmedSuppliersPage());
                                                    },
                                                    child: const Text(
                                                        'لیست تامین کنندگان')),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (ironfee.text != '') {
                                          CurrencyController.iron.value =
                                              ironfee.text;
                                          setState(() {});

                                          Get.off(HomePage(
                                            controller: SidebarXController(
                                                selectedIndex: 0),
                                          ));
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('ثبت')),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  tileColor: Colors.white,
                  splashColor: Colors.amber,
                  trailing: const Icon(Icons.settings),
                  title: const Text('تنظیمات'),
                ),
                ListTile(
                  onTap: () {
                    Get.back();
                    Get.defaultDialog(
                        title: 'کاربر جدید',
                        titleStyle: const TextStyle(fontFamily: 'BYekan'),
                        backgroundColor:
                            const Color.fromARGB(255, 226, 219, 219),
                        content: const Addunituser());
                  },
                  trailing: const Icon(Icons.person),
                  title: const Text('اضافه کردن کاربر'),
                ),
                const ListTile(
                  trailing: Icon(Icons.file_copy),
                  title: Text('فایل های خروجی'),
                ),
                const ListTile(
                  trailing: Icon(Icons.chat),
                  title: Text('گفتوگو'),
                ),
                ListTile(
                  onTap: () {
                    Get.to(const UsersConfig());
                  },
                  trailing: const Icon(Icons.manage_accounts),
                  title: const Text('مدیریت کاربران'),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.15,
        actions: [
          Expanded(
            child: Container(
              color: const Color(0xFF2E2E48),
              width: screenWidth,
              height: screenHeight * 0.221,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: Container(
                              // color: Colors.purple,
                              width: screenWidth * 0.1,
                              height: screenHeight * 0.12,
                              margin: EdgeInsets.only(
                                  right: screenWidth * 0.01,
                                  top: screenHeight * 0.01),
                              child: Container(
                                // height: 60,

                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(64, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(CurrencyController
                                                    .eur.value
                                                    .toString()),
                                                const Text(
                                                  ' :یورو',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                              right: 8.0,
                                              bottom: 4.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(CurrencyController
                                                    .iron.value),
                                                const Text(
                                                  ' :آهن',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // VerticalDivider(
                                    //   width: 10,
                                    //   color: Colors.black,
                                    //   // indent: 2,
                                    //   // endIndent: 2,
                                    //   thickness: 20,
                                    // ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 24,
                                          color: Colors.white,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              // fetchCurrencyValues();
                                              tokenCheck();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.refresh_outlined,
                                              size: 14,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(CurrencyController
                                                    .usd.value
                                                    .toString()),
                                                const Text(
                                                  ' :دلار',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4.0,
                                              right: 8.0,
                                              bottom: 4.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(CurrencyController
                                                    .dirhamDubai.value
                                                    .toString()),
                                                const Text(
                                                  ' :درهم دبی',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          // اضافه شده
                          child: Container(
                            // color: Colors.red,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right: screenWidth * 0.01,
                                top: screenHeight * 0.01),
                            // color: Colors.amber,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'پنل کاربری هرمس استیل',
                                  style: TextStyle(
                                      fontFamily: 'Irs',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Container(
                                //   alignment: Alignment.center,
                                //   // color: Colors.grey,
                                //   width: 60,
                                //   height: 60,
                                //   child: Image.asset(
                                //     'assets/images/hs.png',
                                //     scale: 1,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFDDDDDD),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                Expanded(
                  flex: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: const Color.fromARGB(146, 255, 255, 255)),
                      child: SizedBox(
                        // color: Colors.amber,
                        width: 222,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              // color: Colors.red,
                              width: 50,
                              // height: 45,
                              // height: 60,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(55),
                                  child: PopupMenuButton(
                                      itemBuilder: (ctx) => [
                                            _buildPopupMenuItem(
                                              'تصویر پروفایل',
                                              () {
                                                print('object');
                                                _openFilePicker();
                                              },
                                            ),
                                            _buildPopupMenuItem('مشخصات', () {
                                              print('object');
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    width: screenWidth * 0.2,
                                                    height: screenHeight * 0.8,
                                                    child: Center(
                                                        child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 40,
                                                          child: myTextField(
                                                              controller: fname,
                                                              hintText: 'نام',
                                                              type:
                                                                  TextInputType
                                                                      .name,
                                                              errorText:
                                                                  'نام را وارد کنید',
                                                              prefixicon:
                                                                  const Icon(Icons
                                                                      .person)),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 50,
                                                          child: myTextField(
                                                              controller: lname,
                                                              hintText:
                                                                  ' نام خانوادگی',
                                                              type:
                                                                  TextInputType
                                                                      .name,
                                                              errorText:
                                                                  'نام را وارد کنید',
                                                              prefixicon:
                                                                  const Icon(Icons
                                                                      .lock)),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              userUpdate(
                                                                  fname.text,
                                                                  lname.text,
                                                                  UserInfoControll
                                                                      .user_id
                                                                      .value);
                                                              print(
                                                                  UserInfoControll
                                                                      .user_id);
                                                            },
                                                            child: const Text(
                                                                'آپدیت'))
                                                      ],
                                                    )),
                                                  );
                                                },
                                              );
                                            }),
                                            // _buildPopupMenuItem('Copy'),
                                            _buildPopupMenuItem('خروج', () {
                                              _deleteCookie('textfield_value=');
                                              Get.to(LoginPageSk());
                                            }),
                                          ],
                                      child: Obx(() {
                                        return UserInfoControll
                                                    .user_avatar.value !=
                                                ''
                                            ? Image.memory(
                                                // width: 60,
                                                fit: BoxFit.cover,
                                                base64Decode(UserInfoControll
                                                    .user_avatar.value))
                                            : Image.memory(
                                                // width: 60,
                                                fit: BoxFit.cover,
                                                base64Decode(UserInfoControll
                                                    .testavatar.value));

                                        // CircleAvatar(
                                        //     child: CachedNetworkImage(
                                        //       width: 60,
                                        //       height: 60,
                                        //       imageUrl:
                                        //           "assets/images/user.jpeg",
                                        //       placeholder: (context, url) =>
                                        //           const CircularProgressIndicator(),
                                        //       errorWidget: (context, url,
                                        //               error) =>
                                        //           const Icon(Icons.error),
                                        //     ),
                                        //   );
                                      }))),
                            ),

                            // Container(
                            //     alignment: Alignment.centerRight,
                            //     child: GestureDetector(
                            //       onTap: () {
                            //         // _deleteCookie('textfield_value=');
                            //         // Get.to(LoginPageSk());

                            //       },
                            //       child: const CircleAvatar(
                            //         backgroundColor: Colors.amber,
                            //       ),
                            //     )),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                  // color: Colors.blue,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.centerRight,
                                  child: Obx(() {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        UserInfoControll.username.value == ''
                                            ? 'بدون نام'
                                            : '${UserInfoControll.username.value} خوش آمدید ',
                                        style: const TextStyle(
                                            fontFamily: 'Irs',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 5, 12, 70)),
                                        textAlign: TextAlign.right,
                                      ),
                                    );
                                  })),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: UserInfoControll.userType == 'Admin' ? true : false,
                  child: Expanded(
                      flex: 1,
                      child: EndDrawerButton(
                        onPressed: () {
                          // openDrawer();
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                      )),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    // height: screenHeight * 0.5,user-khayam.zip
                    width: screenWidth * 0.9,
                    // color: Colors.blue,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: UserInfoControll.userType.value == 'Guest'
                          ? const GuestsPanel()
                          : UserInfoControll.userType.value == 'Customers'
                              ? const CustomerPanel()
                              : UserInfoControll.userType.value ==
                                      'confirmed_customers'
                                  ? const CustomerPanel()
                                  : UserInfoControll.userType.value == 'Seller'
                                      ? const CustomerPanel()
                                      : UserInfoControll.userType.value ==
                                              'Admin'
                                          ? GridView(
                                              shrinkWrap: true, // اضافه شده
                                              // physics: NeverScrollableScrollPhysics(), // اضافه شده
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                              ),
                                              children: [
                                                MyCardWidget(
                                                  onpress: () {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => HomeMain(
                                                                    xxcontroller: SidebarXController(
                                                                        selectedIndex:
                                                                            4,
                                                                        extended:
                                                                            true))
                                                                // InvoicesPage(
                                                                //       refresh: refresh,
                                                                //     )

                                                                ),
                                                            (route) => false);
                                                  },
                                                  text: 'خرید / فروش',
                                                  image: Image.asset(
                                                    'assets/images/trade.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                MyCardWidget(
                                                  onpress: () {
                                                    if (UserInfoControll
                                                                .userType
                                                                .value !=
                                                            'Customers' &&
                                                        UserInfoControll
                                                                .userType
                                                                .value !=
                                                            'Supplier') {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => HomeMain(
                                                                      xxcontroller: SidebarXController(
                                                                          selectedIndex:
                                                                              3,
                                                                          extended:
                                                                              true))
                                                                  // InvoicesPage(
                                                                  //       refresh: refresh,
                                                                  //     )

                                                                  ),
                                                              (route) => false);
                                                    } else {
                                                      Get.defaultDialog(
                                                          title: 'خطا',
                                                          middleText:
                                                              'مجوز دیدن این بخش را ندارید');
                                                    }
                                                  },
                                                  text: 'فاکتورها',
                                                  image: Image.asset(
                                                    'assets/images/factors.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                MyCardWidget(
                                                  onpress: () {
                                                    print(UserInfoControll
                                                        .userType.value);
                                                    if (UserInfoControll
                                                                .userType
                                                                .value !=
                                                            'Customers' &&
                                                        UserInfoControll
                                                                .userType
                                                                .value !=
                                                            'Supplier') {
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  // OrdersPage(
                                                                  //       refresh: refresh,
                                                                  //     )
                                                                  HomeMain(xxcontroller: SidebarXController(selectedIndex: 2, extended: true))),
                                                          (route) => false);
                                                    } else {
                                                      Get.defaultDialog(
                                                          title: 'خطا',
                                                          middleText:
                                                              'مجوز دیدن این بخش را ندارید');
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
                                                    fetchCustomers();

                                                    setState(() {});
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => HomeMain(
                                                                    xxcontroller: SidebarXController(
                                                                        selectedIndex:
                                                                            1,
                                                                        extended:
                                                                            true))
                                                                // CustomersPage(),
                                                                ),
                                                            (route) => false);
                                                  },
                                                  text: 'مشتریان',
                                                  image: Image.asset(
                                                    'assets/images/customers.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                MyCardWidget(
                                                  onpress: () {
                                                    Get.to(LogsScreen());
                                                  },
                                                  text: 'گزارشات',
                                                  image: Image.asset(
                                                    'assets/images/report.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                MyCardWidget(
                                                  onpress: () {
                                                    Get.to(
                                                        ConfirmedSuppliersPage());
                                                  },
                                                  text: 'تامیین کنندگان',
                                                  image: Image.asset(
                                                    'assets/images/supply.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                MyCardWidget(
                                                  onpress: () {},
                                                  text: 'حمل و نقل',
                                                  image: Image.asset(
                                                    'assets/images/transfer.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                MyCardWidget(
                                                  onpress: () {
                                                    void refresh() {
                                                      setState(() {});
                                                    }

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return HomeMain(
                                                            xxcontroller:
                                                                SidebarXController(
                                                                    selectedIndex:
                                                                        1,
                                                                    extended:
                                                                        true));
                                                      },
                                                    ));

                                                    widget.controller
                                                        .selectIndex(1);
                                                    // تغییر index به صفحه اصلی homeController.intjer.value = 1;
                                                    print('object');
                                                    setState(() {});
                                                  },
                                                  text: 'مالی',
                                                  image: Image.asset(
                                                    'assets/images/money.gif',
                                                    scale: 0.8,
                                                  ),
                                                ),
                                                UserInfoControll.userType ==
                                                        'Customers'
                                                    ? MyCardWidget(
                                                        image:
                                                            Image.network(''),
                                                        onpress: () {},
                                                        text: '',
                                                      )
                                                    : Container(),
                                                UserInfoControll.userType ==
                                                        'Customers'
                                                    ? MyCardWidget(
                                                        onpress: () {
                                                          void refresh() {
                                                            setState(() {});
                                                          }

                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return HomeMain(
                                                                  xxcontroller: SidebarXController(
                                                                      selectedIndex:
                                                                          1,
                                                                      extended:
                                                                          true));
                                                            },
                                                          ));

                                                          widget.controller
                                                              .selectIndex(1);
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
                                                      )
                                              ],
                                            )
                                          : const CustomerPanel(),
                    )))
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, Function()? setAction) {
    return PopupMenuItem(
      onTap: setAction,
      child: Text(title),
    );
  }

  Future<void> addAdminToHive(String username, String password) async {
    final box = await Hive.openBox<AdminInfo>('adminBox');
    final admin = AdminInfo(
        id: box.values.length + 1,
        name: 'Admin ${box.values.length + 1}',
        lastName: 'Last Name ${box.values.length + 1}',
        unit: 'Admin Unit ${box.values.length + 1}',
        isadmin: true,
        username: username,
        password: password,
        number: '');
    await box.add(admin);
  }
}

class MyCardWidget extends StatefulWidget {
  const MyCardWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onpress,
  });
  final Image image;
  final String text;
  final Function() onpress;

  @override
  State<MyCardWidget> createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {
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
                          child: widget.image)),
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

  PopupMenuItem _buildPopupMenuItem(String title, Function()? setAction) {
    return PopupMenuItem(
      onTap: setAction,
      child: Text(title),
    );
  }
}
