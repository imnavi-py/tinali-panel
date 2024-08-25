import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:steelpanel/add_admin.dart';
import 'package:steelpanel/api/config.dart';
import 'package:steelpanel/data/admin_info.dart';
// import 'package:steelpanel/login/login.dart';
import 'package:steelpanel/models/print-model-factore.dart';
import 'package:steelpanel/screens/factors.dart';
import 'package:steelpanel/screens/homescreen.dart';
// import 'package:steelpanel/login/testlocal.dart';
import 'package:steelpanel/screens/pages/home.dart';
import 'package:steelpanel/screens/pages/invoice-card.dart';
import 'package:steelpanel/utils/dialog_functions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:steelpanel/widgets/login/testlocal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(DialogFuncs());
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  void refresh() {}
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: 'Steel Panel',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:

          //

          // HomeMain()
          // PrintableFactor()
          // HomePage()
          // InvoicesPage(refresh: refresh)
          LoginPageSk(),
      // home: FutureBuilder<String>(
      //   future: _checkTableStatus(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return SizedBox(
      //         height: 40,
      //         child: const CircularProgressIndicator(),
      //       );
      //     } else if (snapshot.hasError) {
      //       return Text('Error: ${snapshot.error}');
      //     } else {
      //       if (snapshot.data == 'isEmpty') {
      //         return const AddAdmin();
      //       } else if (snapshot.data == 'isNotEmpty') {
      //         return LoginPageSk();
      //       } else {
      //         return const Text('Invalid response');
      //       }
      //     }
      //   },
      // ),
    );
  }
}

Future<String> _checkTableStatus() async {
  final url = Uri.parse('https://test.ht-hermes.com/table_check.php/');
  final response = await http.post(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return response.body;
  }
}
