import 'dart:convert';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class RegsiterPage extends StatefulWidget {
  const RegsiterPage({super.key});

  @override
  State<RegsiterPage> createState() => _RegsiterPageState();
}

class _RegsiterPageState extends State<RegsiterPage> {
  TextEditingController mobile = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();

  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  void _displayErrorMotionToast() {
    MotionToast.error(
      title: const Text(
        'خطا',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('این نام کاربری موجود است'),
      position: MotionToastPosition.top,
      barrierColor: Colors.black.withOpacity(0.3),
      width: 300,
      height: 80,
      dismissable: false,
    ).show(context);
  }

  void refresh() {
    setState(() {});
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 1, 1, 34),

      // const Color.fromARGB(255, 230, 227, 222),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(blurStyle: BlurStyle.outer)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  // SizedBox(
                  //   child: Image.asset('assets/images/hs.png', scale: 4),
                  //   // height: 40,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).maybePop();
                                  },
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded)),
                              const Text(
                                'ثبت نام',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'Irs',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 50,
                          child: const Text(''),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.00005,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.person_2_rounded),
                          controller: lname,
                          hintText: 'نام',
                          type: TextInputType.name,
                          errorText: 'نام خود را وارد کنید'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.person_2_rounded),
                          controller: fname,
                          hintText: 'نام خانوادگی',
                          type: TextInputType.name,
                          errorText: 'نام خانوادگی را وارد کنید'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.supervised_user_circle),
                          controller: _username,
                          hintText: 'نام کاربری',
                          type: TextInputType.name,
                          errorText: 'نام کاربری را وارد کنید'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.password),
                          controller: _password,
                          hintText: 'رمز خود را وارد کنید',
                          type: TextInputType.name,
                          errorText: 'رمز عبور را وارد کنید'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      width: 300,
                      child: myTextField(
                          prefixicon: const Icon(Icons.phone_android_rounded),
                          controller: mobile,
                          hintText: 'موبایل',
                          type: TextInputType.number,
                          errorText: 'شماره موبایل خود را وارد کنید'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 206, 201, 201),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () async {
                              await _Register();
                            },
                            child: const Text(
                              'ارسال',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontFamily: 'Irs',
                                  fontWeight: FontWeight.bold),
                            ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _Register() async {
    final response = await http.post(
      Uri.parse('${apiService.apiurl}/reg-user.php'),
      body: jsonEncode({
        "username": _username.text,
        "password": _password.text,
        "name": fname.text,
        "lastname": lname.text,
        "number": mobile.text,
        "permission": 100
      }),
    );

    if (response.statusCode == 201) {
      String userName = jsonDecode(response.body)['username'];
      String userType = jsonDecode(response.body)['userType'];
      String token = jsonDecode(response.body)['token'];
      String fName = jsonDecode(response.body)['name'];
      String lName = jsonDecode(response.body)['lastName'];
      int usrId = jsonDecode(response.body)['userID'];
      print('yes');
      print(jsonDecode(response.body));

      UserInfoControll.userType.value = userType;
      UserInfoControll.username.value = userName;

      UserInfoControll.token.value = token;
      UserInfoControll.first_name.value = fName;
      UserInfoControll.last_name.value = lName;
      UserInfoControll.user_id.value = usrId;

      const value = "_controller.text";
      // ذخیره مقدار در کوکی
      html.document.cookie = 'textfield_value=$token; path=/';
      // UserInfoControll.first_name.value = jsonDecode(response.body)['name'];
      // UserInfoControll.last_name.value = jsonDecode(response.body)['lastname'];
      // UserInfoControll.mobile.value = mobile.text;

      Get.to(HomeMain(
          xxcontroller: SidebarXController(selectedIndex: 0, extended: true)));
    } else if (response.statusCode == 409) {
      print('object');

      _displayErrorMotionToast();
    } else {
      print(response.body);
      print('Error');
    }
  }
}
