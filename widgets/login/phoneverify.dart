import 'dart:async'; // For the Timer class
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/control/user-info.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/widgets/login/register.dart';
import 'package:steelpanel/widgets/mytextfield.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  static String numberSms = '';

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Create 6 TextEditingControllers for 6 digits
  List<TextEditingController> codeControllers =
      List.generate(6, (index) => TextEditingController());

  // Create FocusNodes for each text field
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  String codesms = '';
  Timer? _timer;
  int _start = 59;

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer when the widget is initialized
    _sendSmsRequest();
  }

  Future<void> _sendSmsRequest() async {
    try {
      await _sendSms();
    } catch (e) {
      print('Error: $e');
    }
  }

  void startTimer() {
    _start = 59; // Reset the timer to 59 seconds before starting
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel(); // Stop the timer when it reaches 0
        });
      } else {
        setState(() {
          _start--; // Decrease the timer every second
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    for (var controller in codeControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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
                    const Text(
                      'کد تایید ارسال شده را وارد کنید',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    // Row for Timer and Code Input
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Build the 6 digit verification code input
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) {
                            return Container(
                              width: 40,
                              height: 60,
                              alignment: Alignment.center,
                              child: TextField(
                                controller: codeControllers[index],
                                focusNode: focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText:
                                      '', // Hide the counter below the TextField
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 103, 168, 212),
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  // Move to next field if value is entered
                                  if (value.length == 1 && index < 5) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  }
                                  // If user deletes the value, go back to the previous field
                                  if (value.isEmpty && index > 0) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index - 1]);
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        // Timer Display
                        Container(
                          height: 50,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$_start', // Display the countdown timer
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 300,
                      height: 40,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'تغییر شماره',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontFamily: 'Irs',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _verifyCode();
                                  }
                                },
                                child: const Text(
                                  'تایید',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Irs',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Visibility(
                        visible: _start == 0 ? true : false,
                        child: Container(
                          height: screenHeight * 0.05,
                          child: TextButton(
                              onPressed: () {
                                Duration(seconds: 2);
                                setState(() {
                                  startTimer();
                                  _sendSms();
                                });
                              },
                              child: Text('ارسال دوباره')),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifyCode() {
    // Concatenate the 6 digit code from each TextField
    String verificationCode =
        codeControllers.map((controller) => controller.text).join();

    if (verificationCode.length == 6) {
      // Call the backend to verify the code
      print("Verification code entered: $verificationCode");
      print(codesms == verificationCode);
      if (codesms == verificationCode) {
        Get.to(RegsiterPage());
      }
      // Your verification logic here
    } else {
      print("Invalid verification code");
    }
  }

  String generateSixDigitCode() {
    Random random = Random();
    // تولید یک عدد تصادفی بین 100000 و 999999
    int code = 100000 + random.nextInt(900000);
    return code.toString();
  }

  Future _sendSms() async {
    print('run');
    final verifyCodeGen = generateSixDigitCode();
    print(verifyCodeGen);
    codesms = verifyCodeGen;
    // آدرس API
    final String url = apiService.apiurl + '/users/sms-check.php';

    // داده‌هایی که می‌خواهید ارسال کنید
    Map<String, dynamic> requestBody = {
      "text": [
        verifyCodeGen,
      ],
      "to": VerifyCodePage.numberSms,
      "bodyId": 244759,
    };

    // ارسال درخواست POST
    final response = await http.post(
      Uri.parse(url),

      body: jsonEncode(requestBody), // تبدیل داده‌ها به فرمت JSON
    );

    // چک کردن وضعیت پاسخ
    if (response.statusCode == 200) {
      // در صورت موفقیت
      print('SMS sent successfully');
    } else {
      // در صورت وجود خطا
      print('Failed to send SMS. Status code: ${response.statusCode}');
    }
  }
}
