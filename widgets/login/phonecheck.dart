import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/widgets/login/phoneverify.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class PhoneCheck extends StatefulWidget {
  const PhoneCheck({super.key});

  @override
  State<PhoneCheck> createState() => _PhoneCheckState();
}

class _PhoneCheckState extends State<PhoneCheck> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobile = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();

  double screenWidth = 0;
  double screenHeight = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 1, 1, 34),
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
              key: _formKey, // Assign the form key
              child: Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          const Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: 50,
                              child: Text(''),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 100,
                          width: 300,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child:
                                    const Text('شماره موبایل خود را وارد کنید'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: mobile, // Assign the controller
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.phone_android_rounded),
                                    hintText: 'موبایل',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'شماره موبایل خود را وارد کنید';
                                    }
                                    if (value.length < 11) {
                                      return 'شماره موبایل باید 11 رقم باشد';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            if (_formKey.currentState!.validate()) {
                              // await _Register();
                              VerifyCodePage.numberSms = mobile.text;
                              Get.to(VerifyCodePage());
                            }
                          },
                          child: const Text(
                            'ارسال',
                            style: TextStyle(
                                color: Colors.orange,
                                fontFamily: 'Irs',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
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
      String token = jsonDecode(response.body)['token'];
      html.document.cookie = 'textfield_value=$token; path=/';
      Get.to(HomeMain(
          xxcontroller: SidebarXController(selectedIndex: 0, extended: true)));
    } else if (response.statusCode == 409) {
      _displayErrorMotionToast();
    } else {
      print(response.body);
    }
  }
}
